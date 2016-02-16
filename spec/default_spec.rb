require_relative 'spec_helper'

describe 'fog::default' do
  before{
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).and_call_original
    %w(build-essential::default libxml2::default).each do |recipe|
      allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with(recipe)
    end
  }
  
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
  let(:chef_run_ubuntu) { ChefSpec::Runner.new(platform: 'ubuntu',
      version: '14.04').converge(described_recipe) }

  it "installs zlib package" do
    expect(chef_run_ubuntu).to install_package("zlib1g-dev")
  end

  it 'includes build-essential' do
    expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('build-essential::default')
    chef_run
  end

  it 'includes libxml-devel' do
    expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('libxml2::default')
    chef_run
  end

  it 'installs fog gem' do
    expect(chef_run).to install_chef_gem('fog').with(
      compile_time: nil,
      version: chef_run.node['fog']['version']
    )
  end
end
