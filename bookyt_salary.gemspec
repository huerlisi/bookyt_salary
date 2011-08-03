# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'bookyt_salary/version'

Gem::Specification.new do |s|
  s.name         = "bookyt_salary"
  s.version      = BookytSalary::VERSION
  s.authors      = ["Simon Hürlimann (CyT)"]
  s.email        = "simon.huerlimann@cyt.ch"
  s.homepage     = "https://github.com/huerlisi/bookyt_salary"
  s.summary      = "Salary plugin for bookyt"
  s.description  = "This plugin extends bookyt with Salary functionality."

  s.files        = `git ls-files app lib config`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
end
