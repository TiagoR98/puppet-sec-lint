var = module SinType
  HardCodedCred = {
    name: "Hard Coded Credentials",
    message: "Do not hard code secrets. This may help an attacker to attack the system.",
    solution: "https://tiagor98.github.io/puppet-sec-lint/hard-coded-credentials"
  }
  HttpWithoutTLS = {
    name: "HTTP without TLS",
    message: "Do not use HTTP without TLS. This may cause a man in the middle attack.",
    solution: "https://tiagor98.github.io/puppet-sec-lint/http-without-tls"
  }
  AdminByDefault = {
    name: "Admin by default",
    message: "This violates the secure by design principle.",
    solution: "https://tiagor98.github.io/puppet-sec-lint/admin-by-default"
  }
  EmptyPassword = {
    name: "Empty password",
    message: "Do not keep password field empty. This may help an attacker to attack.",
    solution: "https://tiagor98.github.io/puppet-sec-lint/empty-password"
  }
  InvalidIPAddrBinding = {
    name: "Invalid IP Address Binding",
    message: "This config allows connections from every possible network.",
    solution: "https://tiagor98.github.io/puppet-sec-lint/invalid-ip-addr-binding"
  }
  SuspiciousComments = {
    name: "Suspicious Comments",
    message: "This comment can expose sensitive information to attackers.",
    solution: "https://tiagor98.github.io/puppet-sec-lint/suspicious-comments"
  }
  WeakCryptoAlgorithm = {
    name: "Weak Crypto Algorithm",
    message: "Do not use this algorithm, as it may have security weaknesses.",
    solution: "https://tiagor98.github.io/puppet-sec-lint/weak-crypto-algorithm"
  }
end