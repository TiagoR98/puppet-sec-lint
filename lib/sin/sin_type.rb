module SinType
  base_url="https://tiagor98.github.io/puppet-sec-lint"

  HardCodedCred = {
    name: "Hard Coded Credentials",
    message: "Do not hard code secrets. This may help an attacker to attack the system.",
    solution: "#{base_url}/hard-coded-credentials"
  }
  HttpWithoutTLS = {
    name: "HTTP without TLS",
    message: "Do not use HTTP without TLS. This may cause a man in the middle attack.",
    solution: "#{base_url}/http-without-tls"
  }
  AdminByDefault = {
    name: "Admin by default",
    message: "This violates the secure by design principle.",
    solution: "#{base_url}/admin-by-default"
  }
  EmptyPassword = {
    name: "Empty password",
    message: "Do not keep password field empty. This may help an attacker to attack.",
    solution: "#{base_url}/empty-password"
  }
  InvalidIPAddrBinding = {
    name: "Invalid IP Address Binding",
    message: "This config allows connections from every possible network.",
    solution: "#{base_url}/invalid-ip-addr-binding"
  }
  SuspiciousComments = {
    name: "Suspicious Comments",
    message: "This comment can expose sensitive information to attackers.",
    solution: "#{base_url}/suspicious-comments"
  }
  WeakCryptoAlgorithm = {
    name: "Weak Crypto Algorithm",
    message: "Do not use this algorithm, as it may have security weaknesses.",
    solution: "#{base_url}/weak-crypto-algorithm"
  }
end