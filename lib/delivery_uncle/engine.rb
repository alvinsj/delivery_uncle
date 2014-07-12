module DeliveryUncle
  class Engine < ::Rails::Engine
    isolate_namespace DeliveryUncle

    config.autoload_paths << File.expand_path("../app/services", __FILE__)
    config.autoload_paths << File.expand_path("../app/workers", __FILE__)

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
      g.factory_girl dir: 'spec/factories'
    end
    
    initializer "static assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end
    
    config.after_initialize do
      require_dependency root.join('app/models/delivery_uncle/email_request.rb').to_s
    end

  end
end
