# Puppet Agent Settings Facts

This module adds Puppet agent settings facts:

```
[root@master ~]# facter -p puppet_agent_settings
{
  config => "/etc/puppetlabs/puppet/puppet.conf",
  confdir => "/etc/puppetlabs/puppet",
  hostcert => "/etc/puppetlabs/puppet/ssl/certs/blah.pem",
  hostprivkey => "/etc/puppetlabs/puppet/ssl/private_keys/blah.pem",
  hostpubkey => "/etc/puppetlabs/puppet/ssl/public_keys/blah.pem",
  localcacert => "/etc/puppetlabs/puppet/ssl/certs/ca.pem",
  pluginfactdest => "/opt/puppetlabs/puppet/cache/facts.d",
  resubmit_facts => false,
  ssldir => "/etc/puppetlabs/puppet/ssl",
}
```

## Why not use the settings variable?

```
[root@master ~]# puppet apply -e 'notice($settings::confdir)'
Notice: Scope(Class[main]): /etc/puppetlabs/puppet
Notice: Compiled catalog for master.lmacchi.vm in environment production in 0.21 seconds
Notice: Applied catalog in 0.29 seconds
[root@master ~]# puppet apply -e 'notice($settings::config)'
Notice: Scope(Class[main]): /etc/puppetlabs/puppet/puppet.conf
Notice: Compiled catalog for master.lmacchi.vm in environment production in 0.23 seconds
Notice: Applied catalog in 0.37 seconds
[root@master ~]# puppet apply -e 'notice($settings::ssldir)'
Notice: Scope(Class[main]): /etc/puppetlabs/puppet/ssl
Notice: Compiled catalog for master.lmacchi.vm in environment production in 0.20 seconds
Notice: Applied catalog in 0.32 seconds
```

As explained in the [Puppet docs](https://docs.puppet.com/puppet/latest/lang_facts_and_builtin_vars.html#puppet-master-variables), 
the settings variable return values from the master, which is always Linux. This module returns paths from the agent, which are different 
for Windows agents.

## How do I see all Puppet agent settings?

```
16:50:12 root@blah ~ # puppet config print
agent_catalog_run_lockfile = /opt/puppetlabs/puppet/cache/state/agent_catalog_run.lock
agent_disabled_lockfile = /opt/puppetlabs/puppet/cache/state/agent_disabled.lock
allow_duplicate_certs = false
allow_pson_serialization = true
always_retry_plugins = true
autoflush = true
[...]
```

## Are all of those available in this module as facts?

No, I selected some that I've needed while writing code and some requested via pull request. I haven't been very diligent about checking
for PRs, but hope to change that!

In order to get an up to date list of available facts, check the code under 'lib/facter'.

As of this writing:

`settings = ['config', 'confdir', 'ssldir', 'hostprivkey', 'hostpubkey', 'localcacert', 'hostcert', 'resubmit_facts', 'pluginfactdest']`

## Example

```
ini_setting { 'Change runinterval in puppet.conf':
  ensure  => present,
  section => 'agent',
  setting => 'runinterval',
  value   => '2h',
  path    => $facts['puppet_agent_settings']['config'],
}
```

## 2025 update

Puppet has added some agent settings into the core product, more details 
[here](https://www.puppet.com/docs/puppet/8/lang_facts_builtin_variables.html)
