require 'bookyt_pos'
require 'rails'

module BookytPos
  class Railtie < Rails::Engine
    initializer :after_initialize do |app|
      app.config.bookyt.engines << 'bookyt_pos'
    end
  end
end
