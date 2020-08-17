class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }
  def authenticate_user!
    return true
  end
  def status
    render json: { data: 'ok' }
  end
end