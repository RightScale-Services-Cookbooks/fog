require_relative 'spec_helper'

describe 'fog::default' do

  
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }


  it 'includes nokogiri' do
    expect(chef_run).to include_recipe("nokogiri")
  end



  it 'installs fog gem' do
    expect(chef_run).to install_chef_gem('fog').with(
      compile_time: nil,
      version: chef_run.node['fog']['version']
    )
  end
end
