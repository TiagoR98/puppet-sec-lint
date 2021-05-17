---
title: Suspicious Comments
permalink: /suspicious-comments/
layout: default
---

# Suspicious Comments

## What are they?

Suspicious comments are all comments left in a release of a Puppet Manifest that might suggest the existence of bugs, missing security functionalities or other weaknesses.


### Example
```puppet
# TODO: switch password from weak hash to sha256
$key = md5("${client_name} ${client_ip} ${client_seed}")
```
This comment immediately tells that developers are aware of the weakness of using a compromised hashing algorithm, but still hadn't made the necessary fix.

## How can it be exploited?

In the previous example, the presence of the comment immediately draws the attention of a malicious hacker who might have gained access to the code repository. By stating the portion of code that is considered insecure, it tells to an attacker exactly where to look for unpatched vulnerabilities. In this case, he could start working on ways to break the weak hashing algorithm.

## How to avoid it?

All comments indicating to be implemented features or non-resolved security issues should be erased, as they pose a very serious threat by gaining the attackers attention. Instead, proper and secure defect management solutions should be used. As a plus, the code stays clean and easy to read.

## More related information

* [CWE-546: Suspicious Comment](https://cwe.mitre.org/data/definitions/546.html)