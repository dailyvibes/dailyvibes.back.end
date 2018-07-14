# frozen_string_literal: true

# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins   '*'
#     resource  '*',
#               headers: :any,
#               methods: %i[get post put patch delete options head]
#   end
# end
# Rails.application.config.middleware.insert_before 0, Rack::Cors, debug: true, logger: (-> { Rails.logger }) do

# :nodoc:
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:3000'
    resource  '*',
              headers: :any,
              methods: %i[get post put patch delete options],
              # credentials: true,
              max_age: 0,
              expose: %w[Authorization Etag]
  end
end
