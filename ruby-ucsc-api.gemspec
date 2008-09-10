Gem::Specification.new do |s|
  s.name = "ruby-ucsc-api"
  s.version = "0.9"

  s.authors = ["Jan Aerts"]
  s.email = "jan.aerts@gmail.com"
  s.homepage = "http://github.com/jandot/ruby-ucsc-api"
  s.summary = "API to UCSC databases"
  s.description = "ruby-ucsc-api provides a ruby API to the UCSC databases (http://genome.ucsc.edu)"

  s.has_rdoc = true
  s.rdoc_options = ["--exclude ."]

  s.platform = Gem::Platform::RUBY
  s.files = ["bin/ucsc","lib/ucsc/db_connection.rb","lib/ucsc/hg18/activerecord.rb","lib/ucsc/hg18/slice.rb","lib/ucsc.rb","samples/ranges.txt","samples/tryout.rb","test/unit/test_activerecord.rb"]

  s.test_files = ["test/unit/test_activerecord.rb"]


  s.add_dependency("bio", [">=1"])
  s.add_dependency("activerecord")

  s.require_path = "lib"
  s.autorequire = "ucsc"

  s.bindir = "bin"
  s.executables = ["ucsc"]
  s.default_executable = "ucsc"
end
