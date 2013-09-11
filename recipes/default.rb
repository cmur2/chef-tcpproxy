
lines = []

node['tcpproxy']['listen'].each do |name,listen|
  lines << "listen #{listen['local']} {"
  lines << "  resolv: #{listen['resolv']};" if listen.key? 'resolv'
  lines << "  remote: #{listen['remote']};"
  lines << "  remote-resolv: #{listen['remote-resolv']};" if listen.key? 'remote-resolv'
  lines << "  source: #{listen['source']};" if listen.key? 'source'
  lines << "};"
end

lines << ''

file "/etc/tcpproxy.conf" do
  content lines.join("\n")
  owner "root"
  group "root"
  mode 00644
  notifies :restart, "service[tcpproxy]"
end

service "tcpproxy" do
  action [:enable, :start]
end
