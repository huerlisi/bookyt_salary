require 'bookyt_salary'
require 'rails'

module BookytSalary
  class Railtie < Rails::Engine
    engine_name "bookyt_salary"

    config.autoload_paths << File.expand_path("../lib", __FILE__)
  end
end
