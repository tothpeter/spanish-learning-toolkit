require 'rubygems'
require 'bundler/setup'

require 'net/http'
require 'nokogiri'
require 'json'

def reload
  load_files
end

# alias :r, :reload

def load_files
  files_to_load = [
    'lib/english/simple_past.rb',
    'lib/main.rb'
  ]

  files_to_load.each do |file_to_load|
    load(file_to_load)
  end
end

load_files
