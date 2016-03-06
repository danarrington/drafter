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
      redirect_to sign_in_path
    end
  end

  def redirect_to_recap_if_draft_over
    draft = Draft.find(params[:draft_id])
    if draft.is_over?
      redirect_to draft_recap_path
    end
  end
end
