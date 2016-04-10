require 'rails_helper'

describe AutoDraftRepository, '.save' do
  let(:draft) {create(:mid_draft_draft)}
  let(:player) {draft.current_pick.player}
  subject {AutoDraftRepository.new(draft, player)}

  context 'a player saving their first autodraft' do
    it 'should set the order to 1' do
      subject.save(draft.remaining_draftables.first)
      expect(Autodraft.first.order).to eq 1
    end
  end

  context 'a player adding a second autodraft' do
    let!(:existing_autodraft) {create(:autodraft, draft: draft, player: player,
      draftable: draft.remaining_draftables.first)}
    it 'should set the order to 2' do
      subject.save(draft.remaining_draftables.second)
      expect(Autodraft.last.order).to eq 2
    end
  end

end
