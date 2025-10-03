#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"

class VersionBumper
  VERSION_FILE = "lib/business_card/version.rb"
  CHANGELOG_FILE = "CHANGELOG.md"

  def initialize(version_type)
    @version_type = version_type.to_sym
    validate_version_type!
  end

  def bump!
    current_version = get_current_version
    new_version = calculate_new_version(current_version)
    
    puts "Bumping version from #{current_version} to #{new_version}"
    
    update_version_file(new_version)
    update_changelog(new_version)
    
    puts "Version bumped to #{new_version}"
    puts "Don't forget to commit and push your changes!"
  end

  private

  def validate_version_type!
    unless %i[major minor patch].include?(@version_type)
      raise ArgumentError, "Version type must be :major, :minor, or :patch"
    end
  end

  def get_current_version
    require_relative "../lib/business_card/version"
    BusinessCard::VERSION
  end

  def calculate_new_version(current_version)
    major, minor, patch = current_version.split(".").map(&:to_i)
    
    case @version_type
    when :major
      "#{major + 1}.0.0"
    when :minor
      "#{major}.#{minor + 1}.0"
    when :patch
      "#{major}.#{minor}.#{patch + 1}"
    end
  end

  def update_version_file(new_version)
    content = File.read(VERSION_FILE)
    updated_content = content.gsub(/VERSION = ".*"/, %(VERSION = "#{new_version}"))
    File.write(VERSION_FILE, updated_content)
  end

  def update_changelog(new_version)
    return unless File.exist?(CHANGELOG_FILE)
    
    changelog_content = File.read(CHANGELOG_FILE)
    today = Date.today.strftime("%Y-%m-%d")
    
    # Add new version entry at the top
    new_entry = <<~ENTRY
      ## [#{new_version}] - #{today}
      
      ### Added
      - Your changes here
      
      ### Changed
      - Your changes here
      
      ### Fixed
      - Your changes here
      
    ENTRY
    
    # Insert after the header (assuming ## [Unreleased] exists)
    if changelog_content.include?("## [Unreleased]")
      updated_content = changelog_content.gsub(
        /(## \[Unreleased\].*?\n)/m,
        "\\1#{new_entry}"
      )
    else
      # If no unreleased section, add at the top after any header
      updated_content = changelog_content.gsub(
        /(^# .*?\n)/m,
        "\\1\n#{new_entry}"
      )
    end
    
    File.write(CHANGELOG_FILE, updated_content)
  end
end

# CLI usage
if __FILE__ == $0
  require "date"
  
  if ARGV.empty?
    puts "Usage: ruby scripts/bump_version.rb [major|minor|patch]"
    exit 1
  end
  
  version_type = ARGV[0]
  bumper = VersionBumper.new(version_type)
  bumper.bump!
end
