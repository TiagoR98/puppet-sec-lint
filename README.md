# Puppet Security Linter

Puppet linter focused on finding security vulnerabilities in code.

![puppet-sec-lint console execution](docs/images/puppet-sec-lint_console.png)

## Installation

Install the Ruby gem:

```bash
gem install puppet-sec-lint
```
## Usage

To analyze a puppet file, simply call the newly installed linter:

```bash
puppet-sec-lint /folder/script.pp
```

If the linter is called with a folder, all puppet files inside are recursively analyzed:

```bash
puppet-sec-lint /folder
```

To open the configurations page to better tune the different rules applied, use the appropriate flag:

```bash
puppet-sec-lint -c
```
(this will open the configurations page on the computer default web browser)


### Integration with Visual Studio Code

The linter can also work inside Visual Studio code. For it, please ensure that the 'puppet-sec-lint' gem was installed on your system.

Then, install the [puppet-sec-lint VSCode extension](https://marketplace.visualstudio.com/items?itemName=tiago1998.puppet-sec-lint-vscode).

Now, after that the extension is activate, it should be activated automatically when a Puppet file is opened, analyzing and displaying warnings in real time.

![puppet-sec-lint console execution](docs/images/puppet-sec-lint_vscode.png)

## Development

<!--After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).-->

## Contributing

<!-- Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/puppet-sec-lint. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/puppet-sec-lint/blob/master/CODE_OF_CONDUCT.md). -->

## License

<!-- The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).-->

## Code of Conduct

<!-- Everyone interacting in the Puppet::Sec::Lint project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/puppet-sec-lint/blob/master/CODE_OF_CONDUCT.md).-->
