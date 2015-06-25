#
# Cookbook Name:: aws-openvpn
# Recipe:: network
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

include_recipe "sysctl"

sysctl_param "net.ipv4.ip_forward" do
  value 1
end

include_recipe "iptables"

iptables_rule "masquerade" do
  source "masquerade.erb"
  variables(cidr: node["openvpn"]["cidr"])
end
