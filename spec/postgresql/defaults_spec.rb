require 'spec_helper'

describe 'Dockerfile' do
  before(:all) do
    image = Docker::Image.build_from_dir('postgresql')
    if ENV['CIRCLECI']
      set :os, :family => 'redhat'
    end
    set :backend, :docker
    set :docker_image, image.id
  end

  def os_version
    command("cat /etc/redhat-release").stdout
  end

  it 'is based on the correct Centos version' do
    expect(os_version).to include("CentOS Linux release 7")
  end

  """
  it 'is based on the correct Centos version' do
    expect(host_inventory['platform']).to eq('redhat')
    expect(host_inventory['platform_version']).to start_with('7')
  end
  """

  describe yumrepo('pgdg94') do
    it { should be_enabled }
  end

  it 'Installs all the needed packages' do
    expect(package("postgresql94")).to be_installed
    expect(package("postgresql94-libs")).to be_installed
    expect(package("postgresql94-server")).to be_installed
    expect(package("postgresql94-contrib")).to be_installed
  end

  if not ENV['CIRCLECI']
    describe command("psql -U dbuser -l | awk '{print $1}' | grep -vE '^(-|List|Name|\\(|\\|)'") do
      its(:stdout) { should match /^database\npostgres\ntemplate0\ntemplate1/ }
    end
  end

end
