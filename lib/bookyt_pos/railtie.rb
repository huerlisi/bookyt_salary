require 'bookyt_pos'
require 'rails'

module BookytPos
  class Railtie < Rails::Engine
    initializer :after_initialize do
      Bookyt::Engine.register_engine 'bookyt_pos'
    end
  end
end
