class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user_from_token!

  def sign_in
  end

end
