require File.expand_path('../boot', __FILE__)

require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GizHub
  class Application < Rails::Application
    config.i18n.default_locale = :'pt-BR'
    config.time_zone = 'Brasilia'
    Slim::Engine.set_default_options format: :html5

    config.generators do |g|
      g.assets            false
      g.helper            false
      g.view_specs        false
      g.helper_specs      false
    end
  end
end
