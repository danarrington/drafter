require 'rails_helper'

RSpec.describe PlayersController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      return pending
      get :show
      expect(response).to have_http_status(:success)
    end
  end

end
