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

  describe 'GET review' do
    let(:draft) {create(:draft)}
    let!(:players) {create_list(:player, 5, drafts: [draft])}
    let!(:draftables) {create_list(:draftable, 20, draft: draft)}
    context 'with no existing picks' do
      it 'should create enough picks for each draftable' do
        expect {
          post :review, id: draft.id
        }.to change(Pick, :count).by(20)
      end
    end
    context 'with existing picks' do
      let!(:picks) {create_list(:pick, 20, draft: draft)}
      it 'should not create new picks' do
        expect {
          post :review, id: draft.id
        }.to_not change(Pick, :count)
      end
    end
  end

end
