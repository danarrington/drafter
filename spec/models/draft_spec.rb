require 'rails_helper'

describe Draft do

  let(:draft) {create(:mid_draft_draft)}
  describe "#current_pick" do
    it 'returns the lowest pick without a draftable' do
      #mid_draft_draft creates a draft with two made picks
      expect(draft.current_pick.number).to eq 3
    end
  end
  describe "#remaining_draftables" do
    it 'returns the highest ranked unpicked draftables' do
      expect(draft.remaining_draftables.first).to eq draft.draftables[2]
    end
  end
end
