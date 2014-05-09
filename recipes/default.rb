#
# Cookbook Name:: openvpn
# Recipe:: default
#
# Author:: Christopher Chow (<chris@chowie.net>)
#
# Copyright 2014, Christopher Chow
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
#

package "openvpn" do
  action :install
end

directory "/etc/openvpn/easy-rsa" do
  owner "root"
  group "root"
  mode 0755
end

directory "/etc/openvpn" do
  owner "root"
  group "root"
  mode 0755
end

template "/etc/openvpn/server.conf" do
  owner "root"
  group "root"
  mode 0644
  source "server.conf.erb"
  notifies :restart, "service[openvpn]"
end

service "openvpn" do
  action [:enable, :start]
end

include_recipe "sysctl"

sysctl_param "net.ipv4.ip_forward" do
  value 1
end

include_recipe "iptables"

iptables_rule "openvpn" do
  source "openvpn.erb"
end
