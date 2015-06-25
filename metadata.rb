name             "aws-openvpn"
maintainer       "Kinesis Pty Ltd"
maintainer_email "devs@kinesis.org"
license          "Apache 2.0"
description      "Setup OpenVPN instances on AWS VPCs"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "1.0.0"

depends "aws"
depends "sysctl", "~> 0.6.2"
depends "iptables", "~> 1.0.0"
