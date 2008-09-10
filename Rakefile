desc "Rebuild gemspec"
task :rebuild_gemspec do
  outfile = File.open('ruby-ucsc-api.gemspec','w')

  outfile.puts 'Gem::Specification.new do |s|'
  outfile.puts '  s.name = "ruby-ucsc-api"'
  outfile.puts '  s.version = "0.9"'
  outfile.puts ''
  outfile.puts '  s.authors = ["Jan Aerts"]'
  outfile.puts '  s.email = "jan.aerts@gmail.com"'
  outfile.puts '  s.homepage = "http://github.com/jandot/ruby-ucsc-api"'
  outfile.puts '  s.summary = "API to UCSC databases"'
  outfile.puts '  s.description = "ruby-ucsc-api provides a ruby API to the UCSC databases (http://genome.ucsc.edu)"'
  outfile.puts ''
  outfile.puts '  s.has_rdoc = true'
  outfile.puts '  s.rdoc_options = ["--exclude ."]'
  outfile.puts ''
  outfile.puts '  s.platform = Gem::Platform::RUBY'
  
  
  outfile.puts '  s.files = ["' + FileList.new("bin/*", "lib/**/*.rb", "samples/**/*", "test/**/*.rb").join("\",\"") + '"]'
  outfile.puts ''
  outfile.puts '  s.test_files = ["' + FileList.new("test/**/test_*.rb").join("\",\"") + '"]'
  outfile.puts ''
  outfile.puts ''
  outfile.puts '  s.add_dependency("bio", [">=1"])'
  outfile.puts '  s.add_dependency("activerecord")'
  outfile.puts ''
  outfile.puts '  s.require_path = "lib"'
  outfile.puts '  s.autorequire = "ucsc"'
  outfile.puts ''
  outfile.puts '  s.bindir = "bin"'
  outfile.puts '  s.executables = ["ucsc"]'
  outfile.puts '  s.default_executable = "ucsc"'
  outfile.puts 'end'

  outfile.close
end