# frozen_string_literal: true

# :nodoc:
class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception

  def csrf
    render json: { csrf: form_authenticity_token }
  end
end
