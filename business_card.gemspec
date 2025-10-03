# frozen_string_literal: true

require_relative "lib/business_card/version"

Gem::Specification.new do |spec|
  spec.name          = "business_card"
  spec.version       = BusinessCard::VERSION
  spec.authors       = ["Thomas Powell"]
  spec.email         = ["twilliampowell@gmail.com"]

  spec.summary       = "A terminal-based business card with ASCII art"
  spec.description   = "Display a beautiful business card in your terminal with contact information and piano keys ASCII art. Supports customization via ~/.plan or ~/.project files."
  spec.homepage      = "https://github.com/stringsn88keys/business_card"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/stringsn88keys/business_card"
  spec.metadata["changelog_uri"] = "https://github.com/stringsn88keys/business_card/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ["business_card"]
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "colorize", "~> 1.1"
  spec.add_dependency "tty-box", "~> 0.7"
  spec.add_dependency "tty-link", "~> 0.1"
end
