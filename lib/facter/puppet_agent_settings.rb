# Fact that displays selected configuration settings from the agent
# Omit the ones already exposed by Puppet - https://www.puppet.com/docs/puppet/latest/lang_facts_builtin_variables.html#lang_facts_builtin_variables-agent-facts
Facter.add(:puppet_agent_settings) do
  setcode do
    puppet_agent_settings = {}

    # Select all values to display
    # Config: Path to puppet.conf
    # Confdir: Path to configuration directory
    # SSLDir: Path to your SSL directory
    # HostPrivKey: Path to the host SSL Private Key
    # HostPubKey: Path to the host SSL Public Key
    # LocalCACert: Path to the host local copy of the CA certificate
    # HostCert: Path to the host local SSL certificate file
    keys = ['config', 'confdir', 'ssldir', 'hostprivkey', 'hostpubkey', 'localcacert', 'hostcert', 'resubmit_facts', 'pluginfactdest']

    keys.each do |key|
      puppet_agent_settings[key] = Puppet.settings[key]
    end

    # Output the populated hash
    puppet_agent_settings
  end
end
