# cookbook-openvpn

Cookbook to set up an OpenVPN server on Amazon VPCs.

## Requirements

Only tested on Ubuntu 14.04, but should work on earlier versions. Depends on
[sysctl](https://github.com/onehealth-cookbooks/sysctl) to setup the IP
forwarding.

Note that this doesn't setup IP Masquerading, so a route will need to be added to
the private subnet's route table.

## Attributes

### openvpn::default

Key                    | Type   | Description
:----------------------|--------|----------------------------------------------------------

## Usage

Because the goal is to have this work on AWS, we won't be storing the keys and certs in the conventional spot of `/etc/openvpn/keys`. Rather, this path will be
a symlink to `/data/openvpn/pki`. Futhermore `/etc/openvpn/config` will symlink to `/data/openvpn/config`. There should then be an EBS volume mounted to `/data`
with the appropriate configuration and keys. We do this to allow for the OpenVPN instance to be torn down and brought back up easily.

Include `openvpn` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[openvpn]"
  ]
}
```

## License

    Copyright 2014 Christopher Chow

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
