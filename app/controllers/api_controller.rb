# frozen_string_literal: true

# :nodoc:
class ApiController < ActionController::API
  include Knock::Authenticable

  after_action :refresh_token, if: :token?

  private

  def token?
    request.env['HTTP_AUTHORIZATION'] =~ /Bearer/
  end

  def refresh_token
    return unless current_user

    payload = { sub: current_user.id }
    headers['Authorization'] = Knock::AuthToken.new(payload: payload).token
  end
end
