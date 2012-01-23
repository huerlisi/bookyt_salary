# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'bookyt_salary/version'

Gem::Specification.new do |s|
  # Description
  s.name         = "bookyt_salary"
  s.version      = BookytSalary::VERSION
  s.summary      = "Salary plugin for bookyt"
  s.description  = "This plugin extends bookyt with Salary functionality."

  s.homepage     = "https://github.com/huerlisi/bookyt_salary"
  s.authors      = ["Simon Hürlimann (CyT)"]
  s.email        = "simon.huerlimann@cyt.ch"
  s.licenses     = ["MIT"]

  # Files
  s.files        = `git ls-files app lib config db`.split("\n")

  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'

  # Dependencies
  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["~> 3.1"])
      s.add_runtime_dependency(%q<recurrence>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>)
    else
      s.add_dependency(%q<rails>, ["~> 3.1"])
      s.add_dependency(%q<recurrence>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<rspec-rails>)
    end
  else
    s.add_dependency(%q<rails>, ["~> 3.1"])
    s.add_dependency(%q<recurrence>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<rspec-rails>)
  end
end
