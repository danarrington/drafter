require 'rails_helper'

RSpec.describe Autodraft, '.available_for' do
  let(:draft) {create(:mid_draft_draft)}
  context 'with no autodraft set' do
    it 'returns nil' do
      expect(Autodraft.available_for(draft.current_pick)).to eq nil
    end
  end

  context 'with an available autodraft set' do
    let!(:autodraft) {create(:autodraft, draft: draft,
      player: draft.current_pick.player, draftable: draft.draftables.last)}
    it 'returns the autodraft' do
      expect(Autodraft.available_for(draft.current_pick)).to eq autodraft
    end
  end

  context 'with an unavailable autodraft set' do
    let!(:autodraft) {create(:autodraft, draft: draft,
      player: draft.current_pick.player, draftable: draft.draftables.first)}
    it 'returns the autodraft' do
      expect(Autodraft.available_for(draft.current_pick)).to eq nil
    end
  end

  context 'with an unavailable followed by an available autodraft' do
    let!(:unavailable_autodraft) {create(:autodraft, draft: draft, order: 1,
      player: draft.current_pick.player, draftable: draft.draftables.first)}
    let!(:available_autodraft) {create(:autodraft, draft: draft, order: 2,
      player: draft.current_pick.player, draftable: draft.draftables.last)}
    it 'returns the available autodraft' do
      expect(Autodraft.available_for(draft.current_pick)).to eq available_autodraft
    end
  end
end
