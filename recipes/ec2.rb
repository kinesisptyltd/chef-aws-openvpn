#
# Cookbook Name:: aws-openvpn
# Recipe:: ec2
#
# Author:: Kinesis Pty Ltd (<devs@kinesis.org>)
#
# Copyright (C) 2014, Kinesis Pty Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

Chef::Recipe.send(:include, Kinesis::Aws)

ec2 = aws_resource("EC2", node["ec2"]["placement_availability_zone"].chop)
instance = ec2.instance(node["ec2"]["instance_id"])

# Disable source/dest check to false.
instance.modify_attribute(source_dest_check: { value: false })

raise "Could not determine instance #{node["ec2"]["instance_id"]}'s VPC ID. Are you running in a VPC?" if instance.vpc_id.nil?

# Find all subnets excluding main.
subnets = ec2.subnets(filters: [
  { name: "availability-zone", values: [node["ec2"]["placement_availability_zone"]] },
  { name: "vpc-id", values: [instance.vpc_id] },
  { name: "state", values: ["available"] },
  { name: "tag:network", values: ["public", "private"] }
]).to_a

raise "Could not find any non-main subnets for VPC #{instance.vpc_id}" if subnets.empty?

# Find all route tables associated
route_tables = ec2.route_tables(filters: [
  { name: "vpc-id", values: [instance.vpc_id] },
  { name: "tag:network", values: ["public", "private"] },
  { name: "association.subnet-id", values: subnets.map(&:id) }
]).to_a

raise "Could not find any route tables for subnets #{subnets.map(&:id).join(", ")}" if route_tables.empty?

# Replace the default route with route to this instance
ec2_old_client = aws_client("EC2", node["ec2"]["placement_availability_zone"].chop)
route_tables.each do |route_table|
  options = {
    route_table_id: route_table.route_table_id,
    destination_cidr_block: node["openvpn"]["cidr"],
    instance_id: node["ec2"]["instance_id"]
  }

  if route_table.routes.any? { |r| r.destination_cidr_block == node["openvpn"]["cidr"] }
    ec2_old_client.replace_route(options)
  else
    ec2_old_client.create_route(options)
  end
end

ec2_old_client.associate_address(
  instance_id: node["ec2"]["instance_id"],
  allocation_id: node["openvpn"]["eip_id"],
  allow_reassociation: true
)
