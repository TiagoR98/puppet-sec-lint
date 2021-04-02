module SinType
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
end