# Test that the keys collected exist inside the settings hash
require 'spec_helper'

describe 'puppet_agent_settings' do
  before(:each) do
    Facter.clear
  end

  settings = ['config', 'confdir', 'ssldir', 'hostprivkey', 'hostpubkey', 'localcacert', 'hostcert']

  settings.each do |s|
    it "key #{s} should not be nil" do
      expect(Facter.fact(:puppet_agent_settings).value[s]).to be_truthy
    end
  end
end
