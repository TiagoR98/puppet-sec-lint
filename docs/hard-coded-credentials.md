---
title: Hard Coded Credentials
permalink: /hard-coded-credentials/
---

# Hard Coded Credentials

Writing sensitive credentials on puppet scripts  can expose them to malicious actors who can obtain access to these files.

## Example

```puppet
class example::service (
    $username = "user1",
    $passsword = "amind1234"
  ) 
```
