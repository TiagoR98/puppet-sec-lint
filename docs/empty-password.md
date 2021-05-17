---
title: Empty Password
permalink: /empty-password/
layout: default
---

# Empty password

## What are they?

An account with an empty password is different from an account with no password. Here, the password exists, it's prompted but it's an empty string.

### Example
If an account has an empty password, when logging in, the user should still be prompted fo input the password:
```
Password:
```

But a simple click on the return key, without actually writing anything, is enough to log in.

## How can it be exploited?

An attacker looking to gain access to an account my try a couple of different generic and vulnerable passwords to brute force his way in. One of his first attempts may be to just press return without actually writing anything. This makes for a very easy password to be guessed.

## How to avoid it?

Secure software systems should have a decent password policy that prevents, among other types, empty passwords. This means that it's very likely for the Puppet manifest to fail as the password would be rejected. But even if the target software accepts empty passwords, a long and hard to guess password is always a much safer option against malicious attacks.

## More related information

* [CWE-258: Empty Password in Configuration File](https://cwe.mitre.org/data/definitions/258.html)