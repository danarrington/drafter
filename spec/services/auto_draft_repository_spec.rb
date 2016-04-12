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

describe AutoDraftRepository, '.destroy' do
  let(:draft) {create(:mid_draft_draft)}
  let(:player) {draft.current_pick.player}
  let!(:autodraft) {create(:autodraft_for_current_picker, draft: draft)}
  subject {AutoDraftRepository.new(draft, player)}

  it 'should delete the autodraft' do
    expect {
      subject.destroy(autodraft.id)
    }.to change(Autodraft, :count).by(-1)
  end

  context 'for a player with other autodrafts set' do
    let!(:autodraft_2) {create(:autodraft_for_current_picker, draft: draft, order: 2)}
    let!(:autodraft_3) {create(:autodraft_for_current_picker, draft: draft, order: 3)}
    it 'should refresh the order of the remaining autodrafts' do
      subject.destroy(autodraft.id)
      autodraft_2.reload
      autodraft_3.reload
      expect(autodraft_2.order).to eq 1
      expect(autodraft_3.order).to eq 2
    end
  end
end
