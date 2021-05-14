---
title: 
permalink: /weak-crypto-algorithm/
layout: default
---

# Use of weak Cryptographic algorithms

## What are they?

A Cryptographic hash algorithm is a one-way function used to map data to an unique fixed-sized sequence of bytes. This has several applications in CyberSecurity, like storing passwords securely in a server for example. The strength of an algorithm is measured by its ability to generate a truly unique output for every unique input and also by its ability to be non reversible, meaning that it should be impossible to determine the original value given the generated hash. 

Weak algorithms like MD5 or SHA-1, either by their age or by their design flaws, are known to not ensure these properties.

### Example
The weakness of the SHA-1 algorithm was originally demonstrated with the collision shown on [this website](https://shattered.it):

```shell
$ sha1sum *.pdf
38762cf7f55934b34d179ae6a4c80cadccbb7f0a  shattered-1.pdf
38762cf7f55934b34d179ae6a4c80cadccbb7f0a  shattered-2.pdf
```
They have two different .pdf files that should generate two different hashes, but as shown above, the resulting hash is exactly the same.

## How can it be exploited?

An attacker who was able to gain access to a server and steal the hashes from all passwords may exploit the weaknesses on the hashing algorithm to either try to reverse them or perform a collision attack. This happens because the algorithm allows the existence of collisions, meaning that an attacker may be able to brute force an hash without even finding the original password.

## How to avoid it?

If the Puppet manifest is being used to generate hashes for passwords or important data, using a more secure algorithm like SHA256 is very advisable as it avoids exposure to the risks mentioned above, ensuring that the algorithm actually performs what's intended to.