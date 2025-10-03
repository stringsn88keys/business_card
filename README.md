# Business Card

A beautiful terminal-based business card with ASCII art, similar to the popular `npx` business card packages. Display your contact information in style with a piano keys ASCII art header.

## Installation

```bash
gem install business_card
```

## Usage

Simply run the command:

```bash
business_card
```

This will display your business card in the terminal with default information.

## Customization

You can customize your business card by creating a configuration file. The gem looks for configuration in the following order:

1. `~/.plan` (checked first)
2. `~/.project` (checked if `.plan` doesn't exist)
3. Default values (if no config file exists)

### Configuration File Format

Create a YAML file at `~/.plan` or `~/.project` with your information:

```yaml
name: "Your Name"
title: "Your Title"
company: "Your Company"
email: "your@email.com"
github: "github.com/username"
twitter: "@handle"
linkedin: "linkedin.com/in/profile"
website: "https://yourwebsite.com"
skills: "Skill1 • Skill2 • Skill3"
```

All fields are optional and will use defaults if not specified.

### Example Configuration

See `example.plan` for a complete example configuration file.

## Features

- 🎹 Beautiful piano keys ASCII art header
- 🎨 Colorized terminal output
- 📝 Customizable contact information
- ⚙️ YAML configuration support
- 🔗 Clickable links (in supported terminals)
- 📦 Easy installation via RubyGems

## Dependencies

- Ruby 2.6.0 or higher
- colorize (~> 1.1)
- tty-box (~> 0.7)
- tty-link (~> 0.1)

## Development

### Setup

```bash
git clone https://github.com/stringsn88keys/business_card.git
cd business_card
bundle install
```

### Version Management

The gem uses semantic versioning with automated version bumping via GitHub Actions.

#### Local Version Management

```bash
# Show current version
rake version:show

# Bump versions locally
rake version:patch  # 1.0.0 -> 1.0.1
rake version:minor  # 1.0.0 -> 1.1.0
rake version:major  # 1.0.0 -> 2.0.0

# Or use the script directly
ruby scripts/bump_version.rb patch
```

#### Automated Version Management

1. **Manual Release**: Go to Actions → "Version Bump" → Run workflow
2. **Automatic Release**: Push to main branch (bumps patch version)
3. **GitHub Actions** will:
   - Bump the version
   - Update CHANGELOG.md
   - Create a Git tag
   - Build the gem
   - Create a GitHub release
   - Publish to RubyGems

#### Required GitHub Secrets

For automated publishing to RubyGems, add this secret to your repository:
- `RUBYGEMS_API_KEY`: Your RubyGems API key (get from https://rubygems.org/settings/edit)

### Testing

```bash
# Run the business card
rake run

# Test with example configuration
rake test

# Build the gem
rake release:build

# Install locally
rake release:install

# Uninstall for testing
rake release:uninstall

# Clean up built gems
rake release:clean
```

### Publishing

The gem is automatically published to RubyGems when you:
1. Use the "Version Bump" GitHub Action, or
2. Push changes to the main branch

For manual publishing:

```bash
# First time setup
gem signin

# Build and push
rake release:build
gem push business_card-$(rake version:show).gem
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE.txt](LICENSE.txt) file for details.

## Acknowledgments

- Inspired by the popular `npx` business card packages
- Built with Ruby and the amazing TTY toolkit
