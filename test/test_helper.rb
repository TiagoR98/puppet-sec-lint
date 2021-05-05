# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require_relative '../lib/rules/rule'
require_relative '../lib/rules/hard_coded_credentials_rule'
require_relative '../lib/rules/no_http_rule'
require_relative '../lib/rules/admin_by_default_rule'
require_relative '../lib/rules/empty_password_rule'
require_relative '../lib/rules/invalid_ip_addr_binding_rule'
require_relative '../lib/rules/suspicious_comment_rule'
require_relative '../lib/rules/use_weak_crypto_algorithms_rule'
require_relative '../lib/rules/cyrillic_homograph_attack'
require_relative "../lib/sin/sin"
require_relative "../lib/sin/sin_type"

require "puppet-lint"

require "minitest/autorun"
