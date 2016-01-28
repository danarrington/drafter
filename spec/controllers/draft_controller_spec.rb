require 'rails_helper'

RSpec.describe DraftController, type: :controller do

  describe 'POST create_draft' do
    context 'with valid params' do
      it 'creates a new draft' do
        expect{ 
          post :create, draft: attributes_for(:draft)
        }.to change(Draft, :count).by(1)
      end

      it 'redirects to add_players' do
        post :create, draft: attributes_for(:draft)
        expect(response).to redirect_to add_players_path(Draft.last.id)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) {attributes_for(:draft, name:nil)}
      it 'does not save anything' do
        expect {
          post :create, draft: invalid_params
        }.to_not change(Draft, :count)
      end
    end
  end

  describe 'POST add_player' do
    let(:draft) {create(:draft)}
    context 'with valid params' do
      it 'creates a new player' do
        expect{ 
          post :add_player, player: attributes_for(:player), id: draft.id
        }.to change(Player, :count).by(1)
      end

      it 'redirects to add_players' do
        post :add_player, player: attributes_for(:player), id: draft.id
        expect(response).to redirect_to add_players_path
      end
    end

    context 'with invalid params' do
      let(:invalid_params) {attributes_for(:player, email:nil)}
      it 'does not save anything' do
        expect {
          post :add_player, player: invalid_params, id: draft.id
        }.to_not change(Player, :count)
      end
    end
  end

  describe 'POST save_draftables' do
    let(:draft) {create(:draft)}
    context 'with valid params for three teams' do
      let(:csv_teams) {'UW, WSU, MSU'}
      it 'creates three new teams' do
        expect{ 
          post :save_draftables, draftables: csv_teams, id: draft.id
        }.to change(Draftable, :count).by(3)
      end

      it 'sets the rank for each' do
        post :save_draftables, draftables: csv_teams, id: draft.id 
        expect(Draftable.find_by(name: 'UW').rank).to eq 1
        expect(Draftable.find_by(name: 'MSU').rank).to eq 3
      end

      it 'sets the draft of the new draftables' do
        post :save_draftables, draftables: csv_teams, id: draft.id 
        expect(Draftable.last.draft).to eq draft
      end

      it 'redirects to review_draft' do
        post :save_draftables, draftables: csv_teams, id: draft.id 
        expect(response).to redirect_to review_draft_path
      end
    end

    context 'with no teams entered' do
      it 're-renders the add_draftables view' do
        post :save_draftables, draftables: '', id: draft.id
        expect(response).to render_template(:add_draftables)
      end
    end
  end
end
