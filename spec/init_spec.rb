require 'spec_helper'

describe 'skyline::init' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
