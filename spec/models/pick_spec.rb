require 'rails_helper'

describe Player do

  let(:draft) {create(:mid_draft_draft)}

  describe '#players_pick_number' do
    let(:pick) {draft.current_pick}
    it 'returns which pick number this is for the player' do
      #mid_draft_draft creates a draft with two made picks for other players
      expect(pick.players_pick_number).to eq 1
    end
  end


end
