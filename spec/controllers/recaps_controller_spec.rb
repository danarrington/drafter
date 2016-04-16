require 'rails_helper'

RSpec.describe RecapsController, type: :controller do

  describe "GET #show" do
    context 'for a finished draft' do
      let(:draft) {create(:finished_draft)}
      context 'for a player in the draft' do
        let(:player) {draft.most_recently_made_pick.player}
        before {sign_in player}

        it "returns http success" do
          get :show, draft_id: draft.id
          expect(response).to have_http_status(:success)
        end
      end

      context 'for a non authenticated visit' do
        it 'redirects to root' do
          get :show, draft_id: draft.id
          expect(response).to redirect_to sign_in_path
        end
      end

      context "for a draft still in progress" do
        let(:draft) {create(:mid_draft_draft)}
        context 'for a player in the draft' do
          let(:player) {draft.most_recently_made_pick.player}
          before {sign_in player}

          it "redirects to the player's pick page " do
            get :show, draft_id: draft.id
            expect(response).to redirect_to pick_path(draft.id, player.id)
          end
        end
      end
    end
  end
end
