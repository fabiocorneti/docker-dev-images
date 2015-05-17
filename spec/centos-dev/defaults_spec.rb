require 'spec_helper'

describe 'Dockerfile' do
  before(:all) do
    image = Docker::Image.build_from_dir('centos-dev')
    if ENV['CIRCLECI']
      set :os, :family => 'redhat'
    end
    set :backend, :docker
    set :docker_image, image.id
  end

  def os_version
    command("cat /etc/redhat-release").stdout
  end

  if ENV['CIRCLECI']
    it 'is based on the correct Centos version' do
      expect(os_version).to include("CentOS Linux release 7")
    end
  else
    it 'is based on the correct Centos version' do
      expect(host_inventory['platform']).to eq('redhat')
      expect(host_inventory['platform_version']).to start_with('7')
    end
  end

  describe yumrepo('epel') do
    it { should be_enabled }
  end

end
