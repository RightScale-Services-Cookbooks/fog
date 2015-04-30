require_relative 'spec_helper'

describe 'fog::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes build-essential' do
    expect(chef_run).to include_recipe('build-essential::default')
  end

  it 'includes libxml-devel' do
    expect(chef_run).to include_recipe('libxml2::default')
  end
end
