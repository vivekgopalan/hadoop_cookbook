require 'spec_helper'

describe 'hadoop::hadoop_yarn_proxyserver' do
  context 'on Centos 6.4 x86_64' do
    let(:chef_run) do
      ChefSpec::Runner.new(platform: 'centos', version: 6.4) do |node|
        node.automatic['domain'] = 'example.com'
        node.default['hadoop']['yarn_site']['yarn.web-proxy.address'] = '127.0.0.1'
        stub_command('update-alternatives --display hadoop-conf | grep best | awk \'{print $5}\' | grep /etc/hadoop/conf.chef').and_return(false)
      end.converge(described_recipe)
    end

    it 'install hadoop-yarn-proxyserver package' do
      expect(chef_run).to install_package('hadoop-yarn-proxyserver')
    end

    it 'creates hadoop-yarn-proxyserver service resource, but does not run it' do
      expect(chef_run).to_not start_service('hadoop-yarn-proxyserver')
    end
  end
end
