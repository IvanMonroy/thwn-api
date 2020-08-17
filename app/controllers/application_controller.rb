class ApplicationController < ActionController::Base
  #SE COMENTAREA APARENTEMENTE GENERA ERROR DE CORS AL CONSUMIR EL API DESDE EL FRONT EN ANGULAR
  # protect_from_forgery with: :null_session

  def authenticate_user!
    return true
  end
  def status
    render json: { data: 'ok' }
  end
end