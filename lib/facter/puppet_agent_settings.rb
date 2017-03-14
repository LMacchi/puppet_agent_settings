# Fact that displays selected configuration settings from the agent
Facter.add(:puppet_agent_settings) do
  setcode do
    puppet_agent_settings = {}
    
    # Select all values to display
    # Config: Path to puppet.conf
    # Confdir: Path to configuration directory
    # SSLDir: Path to your SSL directory
    keys = ['config', 'confdir', 'ssldir']
    
    keys.each do |key|
      puppet_agent_settings[key] = Puppet.settings[key]
    end
    
    # Output the populated hash
    puppet_agent_settings
  end
end
