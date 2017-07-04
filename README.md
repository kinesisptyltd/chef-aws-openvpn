# chef-aws-openvpn

Cookbook to set up an OpenVPN server on Amazon VPCs.

## Requirements

Only tested on Ubuntu 14.04, but should work on earlier versions. Depends on
[sysctl](https://github.com/onehealth-cookbooks/sysctl) to setup the IP
forwarding and iptables to setup IP masquerading.

## Usage

Include `openvpn` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[openvpn]"
  ]
}
```

## License

    Copyright (C) 2015 Kinesis Pty Ltd

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
