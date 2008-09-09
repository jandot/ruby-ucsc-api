require 'rubygems'

spec = Gem::Specification.new do |s|
  s.name = 'ruby-ucsc-api'
  s.version = "0.9"

  s.author = "Jan Aerts"
  s.email = "jan.aerts@gmail.com"
  s.homepage = "http://github.com/jandot/ruby-ucsc-api"
  s.summary = "API to UCSC databases"
  s.description = "ruby-ucsc-api provides a ruby API to the UCSC databases (http://genome.ucsc.edu)"

  s.platform = Gem::Platform::RUBY
  s.files = Dir.glob("{lib,samples,test}/**/*")

  s.add_dependency('bio', '>=1')
  s.add_dependency('activerecord')

  s.require_path = 'lib'
  s.autorequire = 'ucsc'
  
  s.bindir = "bin"
  s.executables = ["ucsc"]
  s.default_executable = "ucsc"
end

if $0 == __FILE__
  Gem::manage_gems
  Gem::Builder.new(spec).build
end
