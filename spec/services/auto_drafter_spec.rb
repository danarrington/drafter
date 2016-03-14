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

    it 'should set autodraft attribute' do
      expect(AutoDrafter.run(draft).first.autodrafted).to eq true
    end

    it 'should return an array containing the pick' do
      pick = draft.current_pick
      autopicks = AutoDrafter.run(draft)
      expect(autopicks.include?(pick)).to eq true
    end
  end

  context 'when the next picker has an autodraft for an unavailable draftable' do
    let!(:autodraft) {create(:autodraft, draft: draft,
      player: draft.current_pick.player, draftable: draft.draftables.first)}

    it 'should return an empty array' do
      expect(AutoDrafter.run(draft)).to eq []
    end
  end

  context 'when the next two picks have set the same draftable set for autodraft' do
    let!(:autodraft) {create(:autodraft, draft: draft,
      player: draft.current_pick.player, draftable: draft.draftables.last)}
    let!(:autodraft_2) {create(:autodraft, draft: draft,
      player: draft.next_5_picks.second.player, draftable: draft.draftables.last)}

    it 'should only pick for the first player' do
      expect(AutoDrafter.run(draft).count).to eq 1
    end

    context 'and the second player has a second available draftable set' do
      let!(:autodraft_3) {create(:autodraft, draft: draft,
        player: draft.next_5_picks.second.player, draftable: draft.draftables[18])}

      it 'should pick for both players' do
        picks = AutoDrafter.run(draft)
        expect(picks.count).to eq 2
      end
    end
  end

  context 'when the last pick is made' do
    let!(:draft) {create(:finished_draft)}

    it 'should not explode' do
      AutoDrafter.run(draft)
    end

  end


end
