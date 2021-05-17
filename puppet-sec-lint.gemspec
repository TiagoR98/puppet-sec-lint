# frozen_string_literal: true

require_relative "lib/puppet-sec-lint/version"

Gem::Specification.new do |spec|
  spec.name          = "puppet-sec-lint"
  spec.version       = PuppetSecLint::VERSION
  spec.authors       = ["Tiago Ribeiro"]
  spec.email         = ["tiago7b27@gmail.com"]

  spec.summary       = "Security vulnerabilities linter for Puppet Manifests"
  spec.description   = "Linter built to detect potential security vulnerabilities in Puppet manifests code. It also offers integration with Visual Studio Code https://marketplace.visualstudio.com/items?itemName=tiago1998.puppet-sec-lint-vscode"
  spec.homepage      = "https://github.com/TiagoR98/puppet-sec-lint"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/TiagoR98/puppet-sec-lint"
  spec.metadata["changelog_uri"] = "https://github.com/TiagoR98/puppet-sec-lint"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_runtime_dependency 'puppet-lint', '~> 2.4', '>= 2.4.2'
  spec.add_runtime_dependency 'rake', '~> 13.0'
  spec.add_runtime_dependency 'minitest', '~> 5.0'
  spec.add_runtime_dependency 'rack', '~> 2.2.3'
  spec.add_runtime_dependency 'webrick', '~> 1.7.0'
  spec.add_runtime_dependency 'inifile', '~> 3.0.0'
  spec.add_runtime_dependency 'launchy', '~> 2.5.0'
  spec.add_runtime_dependency 'logger', '~> 1.4.3'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
