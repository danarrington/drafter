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

      it 'sends the pick made email to all players' do
        team_to_draft = draft.draftables[7]
        expect {
          post :make, draft_id: draft.id, draftable_id: team_to_draft.id
        }.to change{ActionMailer::Base.deliveries.count}.by(draft.players.count)
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

      it 'fails if the team has already been drafted' do
        team_to_draft = draft.most_recently_made_pick.draftable
        expect {
          post :make, draft_id: draft.id, draftable_id: team_to_draft.id
        }.to change(player.made_picks_for(draft), :count).by(0)
      end
    end
  end

  describe 'GET new' do
    let(:draft) {create(:mid_draft_draft)}
    let(:player) {draft.most_recently_made_pick.player}
    context 'when it is not the players turn to pick' do
      
      it 'should redirect to the players page' do
        get :new, draft_id: draft.id, player_id: player.id, token: player.token
        expect(response).to redirect_to player_page_url
      end

    end
  end

end
