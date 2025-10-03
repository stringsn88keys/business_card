# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

# Load the version
require_relative "lib/business_card/version"

namespace :version do
  desc "Show current version"
  task :show do
    puts BusinessCard::VERSION
  end

  desc "Bump patch version (1.0.0 -> 1.0.1)"
  task :patch do
    system("ruby scripts/bump_version.rb patch")
  end

  desc "Bump minor version (1.0.0 -> 1.1.0)"
  task :minor do
    system("ruby scripts/bump_version.rb minor")
  end

  desc "Bump major version (1.0.0 -> 2.0.0)"
  task :major do
    system("ruby scripts/bump_version.rb major")
  end
end

namespace :release do
  desc "Build the gem"
  task :build do
    system("gem build business_card.gemspec")
  end

  desc "Install the gem locally"
  task :install => :build do
    version = BusinessCard::VERSION
    system("gem install ./business_card-#{version}.gem")
  end

  desc "Uninstall the gem"
  task :uninstall do
    system("gem uninstall business_card")
  end

  desc "Clean up built gems"
  task :clean do
    system("rm -f *.gem")
  end
end

desc "Run the business card"
task :run do
  system("ruby bin/business_card")
end

desc "Test the business card with example config"
task :test do
  system("cp example.plan ~/.plan")
  system("ruby bin/business_card")
  system("rm ~/.plan")
end

# Default task
task :default => :run
