require 'rails_helper'

describe AutoDrafter, '.run' do
  let(:draft) {create(:mid_draft_draft)}
  context 'with no autodrafts set for the next picker' do
    it 'should return an empty array' do
      expect(AutoDrafter.run(draft)).to eq []
    end
  end

  context 'when the next picker has an autodraft for an available draftable' do
    let!(:autodraft) {create(:autodraft, draft: draft,
      player: draft.current_pick.player, draftable: draft.draftables.last)}
    it 'should update the pick with that draftable' do
      pick = draft.current_pick
      AutoDrafter.run(draft)
      pick.reload
      expect(pick.draftable).to eq autodraft.draftable
    end

    pending 'set autodraft property'

    it 'should return the pick' do
      pick = draft.current_pick
      autopicks = AutoDrafter.run(draft)
      expect(autopicks.include?(pick)).to eq true
    end
  end


end
