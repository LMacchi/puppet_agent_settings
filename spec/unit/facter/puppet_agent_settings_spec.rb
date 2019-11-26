# Test that the keys collected exist inside the settings hash
require "spec_helper"

describe Facter::Util::Fact do
  before {
    Facter.clear
  }

  settings = ['confdir', 'ssldir','noop','resubmit_facts']

  describe "puppet_agent_settings" do
    settings.each do |s|
      it "key #{s} should not be nil" do
        expect(Facter.fact(:puppet_agent_settings).value[s]).to be_truthy
      end
    end
  end

end
