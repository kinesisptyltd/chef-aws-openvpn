apt_repository "openvpn" do
  uri          "http://build.openvpn.net/debian/openvpn/release/2.4"
  arch         "amd64"
  distribution "trusty"
  components   ["main"]
  key          "https://swupdate.openvpn.net/repos/repo-public.gpg"
end

package "openvpn" do
  action :install
end

directory "/etc/openvpn" do
  owner "root"
  group "root"
  mode 0755
end

["ca.crt", "crl.pem", "dh.pem", "server.key", "server.crt"].each do |file|
  aws_s3_file "/etc/openvpn/#{file}" do
    bucket node["openvpn"]["bucket"]
    region node["ec2"]["placement_availability_zone"].chop
    remote_path "#{node["openvpn"]["bucket_path"]}/#{file}"
  end
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
