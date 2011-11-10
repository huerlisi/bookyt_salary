# Settings
# ========
source :rubygems

gemspec

# Rails
# =====
gem 'rails', '~> 3.1.0.rc'

# Development
# ===========
group :development do
end

# Test
# ====
group :test do
  # Framework
  gem "rspec-rails"

  # Browser
  gem "capybara"

  # Fixtures
  gem "factory_girl_rails", "~>1.1"

  # Matchers/Helpers
  gem 'shoulda'
  gem 'accept_values_for'

  # Autotest
  gem 'autotest'
  gem 'autotest-rails'
  gem 'ZenTest', '< 4.6.0' # Keep it working with gems < 1.8

  # Database
  gem "sqlite3"
end

# Gem
# ===
# Date/Time handling
gem 'validates_timeliness'
