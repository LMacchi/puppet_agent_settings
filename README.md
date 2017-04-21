# Puppet Agent Settings Facts

This module adds Puppet agent settings facts:

```
[root@master ~]# facter -p puppet_agent_settings
{
  config => "/etc/puppetlabs/puppet/puppet.conf",
  confdir => "/etc/puppetlabs/puppet",
  ssldir => "/etc/puppetlabs/puppet/ssl"
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

As explain in the [Puppet docs](https://docs.puppet.com/puppet/4.10/lang_facts_and_builtin_vars.html#puppet-master-variables), the settings variable return values from the master, which is always Linux. This module returns paths from the agent, which are different to the master ones in Windows.




