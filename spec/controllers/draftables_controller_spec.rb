require 'rails_helper'

RSpec.describe DraftablesController, type: :controller do

  describe 'POST batch_create' do
    let(:draft) {create(:draft)}
    context 'with valid params for three teams' do
      let(:csv_teams) {'UW, WSU, MSU'}
      it 'creates three new teams' do
        expect{ 
          post :batch_create, draftables: csv_teams, draft_id: draft.id
        }.to change(Draftable, :count).by(3)
      end

      it 'sets the rank for each' do
        post :batch_create, draftables: csv_teams, draft_id: draft.id 
        expect(Draftable.find_by(name: 'UW').rank).to eq 1
        expect(Draftable.find_by(name: 'MSU').rank).to eq 3
      end

      it 'sets the draft of the new draftables' do
        post :batch_create, draftables: csv_teams, draft_id: draft.id 
        expect(Draftable.last.draft).to eq draft
      end

      it 'redirects to review_draft' do
        post :batch_create, draftables: csv_teams, draft_id: draft.id 
        expect(response).to redirect_to review_draft_path(draft)
      end
    end

    context 'with no teams entered' do
      it 're-renders the batch_new view' do
        post :batch_create, draftables: '', draft_id: draft.id
        expect(response).to render_template(:batch_new)
      end
    end
  end

end
