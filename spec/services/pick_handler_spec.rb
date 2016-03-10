require 'rails_helper'

describe PickHandler, '.run' do
  let(:draft) {create(:mid_draft_draft)}

  it 'returns false if an already picked draftable is selected' do
    already_drafted_team = draft.most_recently_made_pick.draftable
    expect(PickHandler.run(draft.id, already_drafted_team.id)).to eq false
  end

  context 'when the on deck picker has set an autodraft list' do


  end

end

