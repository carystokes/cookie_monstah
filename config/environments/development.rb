Rails.application.configure do
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  config.eager_load = false
end
