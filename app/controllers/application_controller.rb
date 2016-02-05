class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user_from_token!


  def authenticate_user_from_token! 
    auth_token = params[:token]
    player_id = params[:player_id]
    return if player_signed_in? && auth_token.blank?

    player = Player.find(player_id)

    if (Devise.secure_compare(player.authentication_token, auth_token))
      sign_in player, store: true
    else
      render text: 'FAILED'
    end
    
  end
end
