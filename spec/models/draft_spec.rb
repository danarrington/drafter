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

  describe "#recent_picks" do
    it 'returns the previously made picks' do
      expect(draft.recent_picks.count).to eq 2
    end
    
    context "many picks made" do
      let(:draft) {create(:late_draft_draft)}
      it 'only returns 5 most recent picks' do
        expect(draft.recent_picks.count).to eq 5
      end

      it 'orders recent picks in descending order' do
        expect(draft.recent_picks.first.number).to be > 
          draft.recent_picks.last.number
      end
    end
  end

  describe '#most_recently_made_pick' do
    it 'returns the most recently made pick' do
      expect(draft.most_recently_made_pick.number).to eq 2
    end
  end

  describe '#next_pick_for' do
    context 'for the current picker' do
      it 'it returns their pick after the current one' do
        current_picker = draft.current_pick.player 
        expect(draft.next_pick_for(current_picker)).to_not eq draft.current_pick
      end
    end
  end
end
