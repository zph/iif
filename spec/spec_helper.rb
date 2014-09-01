require 'rspec'
require_relative '../lib/iif'

def content
  file = Dir.glob("fixtures/import_first*.iif").first
  content = File.read(file)
end

def parser(content = content)
  IIF::Parser.new(content: content)
end
