require 'rails_helper'

RSpec.describe RecapsController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end

    pending "redirect if draft is not over"
  end

end
