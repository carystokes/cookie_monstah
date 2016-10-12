Rails.application.configure do
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.raise_delivery_errors = true

  config.eager_load = false
end
