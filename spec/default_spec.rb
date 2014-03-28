require 'chefspec'
begin require 'chefspec/deprecations'; rescue LoadError; end

describe 'tcpproxy::default' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path)
  end

  let(:chef_run) do
    chef_runner.converge 'tcpproxy::default'
  end
  
  it 'enables and starts tcpproxy' do
    expect(chef_run).to start_service 'tcpproxy'
    expect(chef_run).to set_service_to_start_on_boot 'tcpproxy'
  end
  
  it 'configures tcpproxy' do
    chef_runner.node.set['tcpproxy']['listen'] = {
      "example1" => {
        "local" => "* 8000",
        "resolv" => "ipv4",
        "remote" => "www.google.at 80",
        "remote-resolv" => "ipv6",
        "source" => "2a02:3e0:2002:1:218:deff:fe03:ed"
      },
      "example2" => {
        "local" => "2a02:3e0:2002:1:218:deff:fe03:ed xmpp-server",
        "remote" => "www.google.at www",
        "remote-resolv" => "ipv4"
      }
    }
    chef_run = chef_runner.converge 'tcpproxy::default'
    expect(chef_run).to create_file_with_content "/etc/tcpproxy.conf", <<EOF
listen * 8000 {
  resolv: ipv4;
  remote: www.google.at 80;
  remote-resolv: ipv6;
  source: 2a02:3e0:2002:1:218:deff:fe03:ed;
};
listen 2a02:3e0:2002:1:218:deff:fe03:ed xmpp-server {
  remote: www.google.at www;
  remote-resolv: ipv4;
};
EOF
  end
end
