require 'bookyt_salary'
require 'rails'

module BookytSalary
  class Railtie < Rails::Engine
    initializer :after_initialize do |app|
      app.config.bookyt.engines << 'bookyt_salary'
    end
  end
end
