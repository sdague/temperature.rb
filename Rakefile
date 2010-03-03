require 'rubygems' 
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/clean'
require 'rake/contrib/sshpublisher'

PKG_NAME = "temperature"
PKG_VERSION = "0.1"

$VERBOSE = nil
TEST_CHANGES_SINCE = Time.now - 600 # Recent tests = changed in last 10 minutes

desc "Run all the unit tests"
task :default => [ :test, :lines ]

desc "Run the unit tests in test"
Rake::TestTask.new(:test) { |t|
    t.libs << "test"
    t.test_files = FileList['test/*_test.rb']
    t.verbose = true
}

# rcov code coverage
rcov_path = '/usr/bin/rcov'
rcov_test_output = "./test/coverage"
rcov_exclude = "interactive.rb,read_write.rb,fixtures"

# Add our created paths to the 'rake clobber' list
CLOBBER.include(rcov_test_output)

desc 'Removes all previous unit test coverage information'
task (:reset_unit_test_coverage) do |t|
  rm_rf rcov_unit_test_output
  mkdir rcov_unit_test_output
end

desc 'Run all unit tests with Rcov to measure coverage'
Rake::TestTask.new(:rcov) do |t|
  t.libs << "test"
  t.pattern = 'test/**/*_test.rb'
  t.ruby_opts << rcov_path
  t.ruby_opts << "-o #{rcov_test_output}"
  t.ruby_opts << "-x #{rcov_exclude}"
  t.verbose = true
end

# Generate the RDoc documentation
Rake::RDocTask.new(:doc) { |rdoc|
  rdoc.main = 'README'
  rdoc.rdoc_files.include('lib/**/*.rb', 'README')
  rdoc.rdoc_files.include('GPL', 'COPYING')
  rdoc.rdoc_dir = 'docs/temperature'
  rdoc.title    = "Temperature -- Temperature mixin for Numerics and Strings"
  rdoc.options << "--include=examples --line-numbers --inline-source"
}

require 'rubygems'
require 'rubygems/gem_runner'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s| 
  s.name = "temperature" 
  s.version = PKG_VERSION 
  s.homepage = "http://github.com/sdague/temperature.rb"
  s.platform = Gem::Platform::RUBY 
  s.summary = "A ruby mixin for making Numerics temperatures"
  s.description = ""

  s.files = FileList["{test,lib,docs,examples}/**/*"].to_a
  s.files += ["Rakefile", "README", "COPYING" ]
  s.require_path = "lib" 
  s.autorequire = "temperature"
  s.has_rdoc = true 
  s.extra_rdoc_files = ["README", "COPYING" ]
  s.rdoc_options.concat ['--main', 'README']

  s.author = "Sean Dague" 
  s.email = "sean@dague.net" 
end 

Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.gem_spec = spec
  pkg.need_tar = true
  pkg.need_zip = true
end

desc "Upload Docs to RubyForge"
task :publish_docs => [:doc] do
    publisher = Rake::SshDirPublisher.new(
                                          "sdague@rubyforge.org",
                                          "/var/www/gforge-projects/sdaguegems",
                                          "docs"
                                          )
    publisher.upload
end

desc "Publish the release files to RubyForge."
task :release => [ :package, :publish_docs ] do
    require 'rubyforge'
    packages = %w( gem tgz zip ).collect{ |ext| "pkg/#{PKG_NAME}-#{PKG_VERSION}.#{ext}" }
    rubyforge = RubyForge.new
    rubyforge.configure
    rubyforge.scrape_config
    rubyforge.scrape_project(PKG_NAME)
    rubyforge.add_release(540, PKG_NAME, "v#{PKG_VERSION}", *packages)
end

desc 'Install the gem globally (requires sudo)'
task :install => :package do |t|
  `sudo gem install pkg/temperature-#{PKG_VERSION}.gem`
end

task :lines do
  lines = 0
  codelines = 0
  Dir.foreach("lib/") { |file_name|
    next unless file_name =~ /.*rb/

    f = File.open("lib/" + file_name)

    while line = f.gets
      lines += 1
      next if line =~ /^\s*$/
      next if line =~ /^\s*#/
      codelines += 1
    end
  }
  puts "\n------------------------------\n"
  puts "Total Lines: #{lines}"
  puts "Lines of Code: #{codelines}"
end
