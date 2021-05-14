---
title: Admin by default
permalink: /admin-by-default/
layout: default
---

# Admin by default

## What is it?

An user who is created with administrator privileges usually has permission to do everything in the system. It's usually identified with the username 'admin' in a lot of software applications.  

### Example
```puppet
user { 'admin':
  ensure => 'present'
}
```
This user, with the username 'admin', will likely have a big concentration of privileges by default.

## How can it be exploited?

Any account with the power to do everything in the system is a very dangerous single point of failure. Firstly, even during normal operations, it allows for its user to potentially change the system in unwanted ways, or even access information that he's not supposed to. Even worse, it presents a very dangerous point of entry for an attacker, as he just needs to compromise this single password to have complete access to the system.

## How to avoid it?

Accounts should always be setup up with the [Principle of least privilege](https://us-cert.cisa.gov/bsi/articles/knowledge/principles/least-privilege) in mind, meaning that all accounts should only get the permissions strictly necessary to perform their required tasks during the minimum amount of time possible. This severely limits the exposure to accidental errors and also to malicious attackers.