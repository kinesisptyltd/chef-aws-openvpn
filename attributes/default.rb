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

default[:openvpn][:subnet] = "10.8.0.0 255.255.0.0"
default[:openvpn][:port] = 1194
default[:openvpn][:protocol] = "udp"
default[:openvpn][:dev] = "tun"
default[:openvpn][:routes] = []

default[:openvpn][:ca_cert] = "/etc/openvpn/ca.crt"
default[:openvpn][:server_cert] = "/etc/openvpn/server.crt"
default[:openvpn][:server_key] = "/etc/openvpn/server.key"
default[:openvpn][:crl] = "/etc/openvpn/crl.pem"
default[:openvpn][:dh] = "/etc/openvpn/dh.pem"

default[:openvpn][:log] = "/var/log/openvpn.log"
default[:openvpn][:log_level] = 4

default[:openvpn][:compression] = true

default[:openvpn][:keep_alive][:enabled] = true
default[:openvpn][:keep_alive][:timeout] = 120
default[:openvpn][:keep_alive][:repeat] = 10

default[:openvpn][:bucket] = nil
default[:openvpn][:bucket_path] = ""
