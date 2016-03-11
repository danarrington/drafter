require 'rails_helper'

describe PickHandler, '.run' do
  let!(:draft) {create(:mid_draft_draft)}

  it 'returns false if an already picked draftable is selected' do
    already_drafted_team = draft.most_recently_made_pick.draftable
    expect(PickHandler.run(draft.id, already_drafted_team.id)).to eq false
  end

  context 'when the on deck picker has set an autodraft list' do
    let(:next_pick) {draft.next_5_picks.first}
    let(:autodraft) {create(:autodraft, draft: draft, player: next_pick.player,
                            draftable: draft.draftables.last)}

    it 'makes the next pick from that autodraft' do
      PickHandler.run(draft.id, draft.draftables.third)
      expect(draft.most_recently_made_pick.draftable).to eq autodraft.draftable
    end

    pending 'multiple picks on email'
    pending 'two autodrafts with same team'


  end

end

