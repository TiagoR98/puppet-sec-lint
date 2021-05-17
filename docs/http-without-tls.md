---
title: Use HTTP without TLS
permalink: /http-without-tls/
layout: default
---

# Use HTTP without TLS

## What is it?

Connecting to a server using the regular HTTP protocol instead of the secure HTTPS, which uses TLS, doesn't allow for an encrypted connection. This means that all the data is sent in plaintext and easily viewed and modified by anyone, including malicious attackers.

### Example
Providing a server to run the PHPMyAdmin application:
```puppet
define phpmyadmin::server (
  $blowfish_key      = md5("${::fqdn}${::ipaddress}"),
  $absolute_uri      = "http://${::fqdn}/phpmyadmin/",
  $config_file       = $::phpmyadmin::params::config_file
)
```
This newly created service will be available to clients through a non secure HTTP address.

A more secure way of hosting the server would be by using an HTTPS url:
```puppet
define phpmyadmin::server (
  $blowfish_key      = md5("${::fqdn}${::ipaddress}"),
  $absolute_uri      = "https://${::fqdn}/phpmyadmin/",
  $config_file       = $::phpmyadmin::params::config_file
)
```


## How can it be exploited?

When a connection is made to a website using a non-secure HTTP address, all communications are sent unencrypted. An attacker can capture the traffic sent and received by a victim, for example, in the same Wifi network. After analyzing his traffic, the attacker can extract sensitive information exchanged by the victim with the websites visited, like passwords and tokens. 

The attacker can then use this information to attack his victim, by logging in and impersonating him in several different websites that don't use the TLS protocol.

## How to avoid it?

All connections to internet addresses or made available to the public by a service configured with a Puppet manifest must use some kind of secure protocol, to ensure the confidentiality, authenticity and integrity of all data exchanged. Making an HTTPS connection is the easiest way to do this and it's also the recommended way of addressing this security vulnerability. In some cases, if the transferred information is verified afterwards by an hashing algorithm, like packages transferred from a repository, then this solution can be considered optional.

## More related information

* [CWE-319: Cleartext Transmission of Sensitive Information](https://cwe.mitre.org/data/definitions/319.html)