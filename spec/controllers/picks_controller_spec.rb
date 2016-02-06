require 'rails_helper'

RSpec.describe PicksController, type: :controller do

  describe 'POST make' do
    let(:draft) {create(:mid_draft_draft)}
    let(:pick) {draft.current_pick}
    let(:player) {pick.player}
    context 'player is signed in' do
      before(:each) {sign_in player}

      it 'make the pick for the player/draft provided' do
        team_to_draft = draft.draftables[7]
        expect {
          post :make, draft_id: draft.id, draftable_id: team_to_draft.id
        }.to change(player.made_picks_for(draft), :count).by(1)
      end

      it 'fails if the current pick does not belong to the signed in player' do
        #signed in player makes their pick
        pick.update(draftable: draft.draftables[6])

        team_to_draft = draft.draftables[7]
        next_player = draft.current_pick.player
        expect {
          post :make, draft_id: draft.id, draftable_id: team_to_draft.id
        }.to change(next_player.made_picks_for(draft), :count).by(0)
      end
    end
  end

end
