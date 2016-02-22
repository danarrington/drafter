require 'rails_helper'

RSpec.describe PlayersController, type: :controller do

  describe "GET #show" do
    pending 'non-authenticated-user'

    context 'Authenticated user' do
      let(:draft) {create(:mid_draft_draft)}
      let(:player) {draft.most_recently_made_pick.player}
      before {sign_in player}

      context "Early in a draft" do
        it "returns http success" do
          get :show, draft_id: draft.id
          expect(response).to have_http_status(:success)
        end
      end
      context "Late in a draft" do
        let(:draft) {create(:late_draft_draft)}
        it "returns http success" do
          get :show, draft_id: draft.id
          expect(response).to have_http_status(:success)
        end
      end
    end
  end

end
