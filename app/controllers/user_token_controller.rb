# frozen_string_literal: true

# :nodoc:
class UserTokenController < Knock::AuthTokenController
  skip_before_action :verify_authenticity_token, only: [:dv_create]

  def dv_create
    # debugger
    decoded_token = Knock::AuthToken.new(token: auth_token.token).payload
    return unless decoded_token && decoded_token['sub']

    result = {
      jwt: auth_token.token,
      id: decoded_token['sub']
    }.to_json

    render json: result, status: :created
  end
end
