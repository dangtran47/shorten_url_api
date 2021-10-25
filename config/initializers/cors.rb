Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ['localhost:3000', 'shortat.herokuapp.com']
    resource '*', headers: :any, methods: %i[get post]
  end
end
