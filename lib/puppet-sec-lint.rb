require_relative 'rule_engine'
require 'json'
require 'optparse'
require 'optparse/uri'
require 'visitors/configuration_visitor'
require 'facades/configuration_file_facade'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: puppet-sec-lint [options]"

  opts.on("-f", "--file FILE",URI, "Path of puppet file to be analyzed") do |file|
    options[:file] = file
  end
end.parse!

raise OptionParser::MissingArgument if options[:file].nil?

ConfigurationVisitor.GenerateIDs
ConfigurationFileFacade.LoadConfigurations

File.open(options[:file].to_s, 'rb:UTF-8') do |f|
  code = f.read

  result = RuleEngine.analyzeDocument(code)

  result.each do |sin|
    puts sin.ToString
  end
end