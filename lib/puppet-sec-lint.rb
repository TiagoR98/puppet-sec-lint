#require 'rack'
#require 'thin'
require_relative 'rule_engine'
require 'hard_coded_credentials_rule'
#require 'language_server'
require 'json'
require 'optparse'
require 'optparse/uri'
require 'configuration_visitor'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: puppet-sec-lint [options]"

  opts.on("-f", "--file FILE",URI, "Path of puppet file to be analyzed") do |file|
    options[:file] = file
  end
end.parse!

raise OptionParser::MissingArgument if options[:file].nil?

File.open(options[:file].to_s, 'rb:UTF-8') do |f|
  code = f.read

  RuleEngine.analyzeDocument(code)
end

puts ConfigurationVisitor.Visit



#Rack::Handler::Thin.run(LanguageServer.new, Port: 3000)