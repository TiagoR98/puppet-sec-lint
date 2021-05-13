---
title: Cyrillic Homograph Attack
permalink: /cyrillic-homograph-attack/
layout: default
---

# Cyrillic Homograph Attack

## What are they?

A Cyrillic Homograph attack takes advantage of the fact that several characters in the [Cyrillic alphabet](https://www.britannica.com/topic/Cyrillic-alphabet) are virtually indistinguishable (homographs) from regular Latin ones in a lot of fonts. This makes it possible for attackers to setup fake domains with Cyrillic characters that look identical to the real one but redirect the user to a malicious website.

### Example
These two website links look identical:
```
https://google.com
https://gооgle.com
```

But after taking a closer look at the code of each character of the website name only, it's possible to see where the attack can be made:
```
\u0067 \u006f \u006f \u0067 \u006c \u0065 \u002e \u0063 \u006f \u006d
\u0067 \u043e \u043e \u0067 \u006c \u0065 \u002e \u0063 \u006f \u006d
  g      o       o       g      l     e       .      c     o     m
```

It's possible to see that the second and third characters in the word "google" are different. On the top domain, the Latin o letter is used (unicode u006f) but on the bottom one, the Cyrillic о letter is used (unicode u043e). Although similar, the bottom website can point to a completely different server.

## How can it be exploited?

To exploit this vulnerability, an attacker can setup, for example, a malicious software repository and register a domain that looks exactly like an existing legitimate one, but written with Cyrillic characters. It's even possible to request a SSL certificate for it, making it possible to receive HTTPS connections, further  convincing the user of its authenticity.

This malicious domain on a Puppet manifest can point to a fake package repository, containing malware infected versions of legitimate packages. These malicious packages would then be installed in all infrastructure deployed by that manifest, causing a widespread infection that could severely compromise the integrity of the systems.
  
## How to avoid it?

After the tool detects the presence of Cyrillic characters on a URL, the best course of action is to replace all Cyrillic characters with their Latin counterparts, as these characters are very rarely used in legitimate domains.
Then, check if the domain is well written (subtle misspellings with similar letters are very common in these kinds of attacks).

To better ensure that the domain is actually the correct one, the URL can also be copied from a trusted source.