#!/usr/bin/env ruby
require_relative 'main'
require 'optparse'
require 'active_support/core_ext/hash/slice'

options = {}

optparse = OptionParser.new do |opts|
  opts.on('-d', '--depth DEPTH', "Mandatory depth") do |f|
    options[:depth] = f
  end
  opts.on('-n', '--node NODE', 'Mandatory node') do |f|
    options[:node] = f
  end
  opts.on('-p', '--pagelimit PAGE-LIMIT', 'Mandatory page limit') do |f|
    options[:page_limit] = f
  end
  opts.on('-u', '--url URL', 'Mandatory URL') do |f|
    options[:url] = f
  end

end

optparse.parse!
if !(%w(http https).include?(URI.parse(options[:url]).scheme))
  puts "======= Please enter a valid url with scheme, Example: http://example.com"
else
  if ([:node,:page_limit,:depth,:url] - options.keys).length == 0
    main = Main.new(options[:url],options.slice(:page_limit,:node,:depth))
    main.execute
    main.output
  else
    puts "=============== Command Line Args ============"
    puts "Please run this script as follows,"
    puts "mycomputer> ruby script.rb -n input -p 50 -d 2 -u http://example.com"
    puts "================================= ============"
  end
end
