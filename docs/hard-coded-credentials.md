---
title: Hard Coded Credentials
permalink: /hard-coded-credentials/
---

# Hard Coded Credentialss

## What are they?

Hard Coded credentials are sensitive information, like passwords, private keys and other secrets, that are written directly on the source code, in plain text.
### Examples
Username and password for a mysql database:
```puppet
mysql::user { 'pdns':
  password => 'pdns123pass',
  requires => Mysql::Database['pdns'];
}
```

Private key used to access a database:
```puppet
file { '/etc/mysql/server-key.pem':
  ensure  => file,
  content => '-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEA9bftj7SJfMpBqk7eza3I1Tp4n3VbjkEo7pq9ft6hCpSHaThN
OU362GyeLawZNTCtROePj3g2StB3UFQTGRe5Xbl510UaoRwSpHnUSTaDfjPeT8SX
(...)
nh0c2NOM2YaGl1J0/WUnzsg7ZDMY6S9zQQ/KZP6LVm4P5yn3k8h8B9FL13a9AK83
89RotRTzKPEAh7SjI84GAVUn6BcxsrVroe3p45E9KpX1bgYCkvu45Q==
-----END RSA PRIVATE KEY-----',
}
```

## How can it be exploited?

Having hard coded credentials in code can expose the software to several kinds of vulnerabilities:
* If the puppet manifest is used to deploy several different machines, because the credentials are hard coded, all of them will share the same credentials. This make it possible for an attacker to exploit all machines after compromising just one of them.
* It's hard to manage and rotate secrets if these ever get compromised, as they can be distributed across several different manifests.
* If an attacker ever gets hold of the source code (by compromising the code repository or the local machine of one developer for example), he can easily access the credentials for potentially all machines in the system. 
  This is an even bigger problem if the source code is open source, as in that case the passwords are completely open to anyone to see them.
  
## How to avoid it?

There are much better ways to store credentials and other secrets. A fairly easy and secure way is by using a tool provided by Puppet called [Hiera](https://puppet.com/docs/puppet/7.6/hiera.html).

It allows the storage of credentials and other data in a centralized file, using then keys to reference them in the source code. This allows for an easy management of the passwords and the possibility of, for example, quickly rotating them between installations.

For even more security, [Hiera can use an encrypted file](https://puppet.com/blog/encrypt-your-data-using-hiera-eyaml/), protecting also against attackers who might, for example, gain access to the source code repository.

### Example

A **secrets.yaml** file containing the password:

```yaml
---
password: pdns123pass
privatekey: |-
  -----BEGIN OPENSSH PRIVATE KEY-----
  b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAABFwAAAAdzc2gtcn
  NhAAAAAwEAAQAAAQEAssBRe91wZ0TJBIWK2V1NH/ourcFPb0cA4ln32a3j5QITMS3zhs/o
(...)
  C8YRNCLnBgR2CCp27D0wuadL9aFITlx91GPytF9BKxzy949VaF6SEw9M86oouj362u/BvP
  CO7Hnjlg77HRNFXPAAAAFWxrYW1pcmVkZHlAdm13YXJlLmNvbQECAwQF
  -----END OPENSSH PRIVATE KEY-----
```

And then the source code from the examples above, but now without hard coded credentials:

```puppet
mysql::user { 'pdns':
  password => hiera("password"),
  requires => Mysql::Database['pdns'];
}

file { '/etc/mysql/server-key.pem':
  ensure  => file,
  content => hiera("privatekey"),
}
```