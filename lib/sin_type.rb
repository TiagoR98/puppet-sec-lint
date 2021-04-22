var = module SinType
  HardCodedCred = {
    name: "Hard Coded Credentials",
    message: "Do not hard code secrets. This may help an attacker to attack the system.",
    recommendation: "You can use hiera to avoid this issue."
  }
  HttpWithoutTLS = {
    name: "HTTP without TLS",
    message: "Do not use HTTP without TLS. This may cause a man in the middle attack.",
    recommendation: "Use TLS with HTTP"
  }
  AdminByDefault = {
    name: "Admin by default",
    message: "This violates the secure by design principle.",
    recommendation: "Do not make default user as admin."
  }
  EmptyPassword = {
    name: "Empty password",
    message: "Do not keep password field empty. This may help an attacker to attack.",
    recommendation: "You can use hiera to avoid this issue."
  }
  InvalidIPAddrBinding = {
    name: "Invalid IP Address Binding",
    message: "This config allows connections from every possible network.",
    recommendation: "Restrict your available IPs."
  }
  SuspiciousComments = {
    name: "Suspicious Comments",
    message: "This comment can expose sensitive information to attackers.",
    recommendation: "Do not expose sensitive information."
  }
  WeakCryptoAlgorithm = {
    name: "Weak Crypto Algorithm",
    message: "Do not use this algorithm, as it may have security weaknesses.",
    recommendation: "Use SHA-512 instead."
  }
end