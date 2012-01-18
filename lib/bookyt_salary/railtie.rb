require 'bookyt_salary'
require 'rails'

module BookytSalary
  class Railtie < Rails::Engine
    config.autoload_paths << File.expand_path("../lib", __FILE__)

    engine_name "bookyt_salary"
  end
end
