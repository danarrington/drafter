require 'rails_helper'

describe AutodraftRepository, '.save' do
  let(:draft) {create(:mid_draft_draft)}
  let(:player) {draft.current_pick.player}
  subject {AutodraftRepository.new(draft, player)}

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

describe AutodraftRepository, '.destroy' do
  let(:draft) {create(:mid_draft_draft)}
  let(:player) {draft.current_pick.player}
  let!(:autodraft) {create(:autodraft_for_current_picker, draft: draft)}
  subject {AutodraftRepository.new(draft, player)}

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

describe AutodraftRepository, '.move' do
  let(:draft) {create(:mid_draft_draft)}
  let(:player) {draft.current_pick.player}
  let!(:autodraft) {create(:autodraft_for_current_picker, draft: draft)}
  let!(:autodraft_2) {create(:autodraft_for_current_picker, draft: draft, order: 2)}
  let!(:autodraft_3) {create(:autodraft_for_current_picker, draft: draft, order: 3)}
  subject {AutodraftRepository.new(draft, player)}

  describe 'moving an autodraft down' do
    it 'should increase its order by 1' do
      subject.move(autodraft.id, :down)
      autodraft.reload
      expect(autodraft.order).to eq 2
    end

    it 'should swap orders with the autodraft it replaced' do
      subject.move(autodraft.id, :down)
      autodraft_2.reload
      expect(autodraft_2.order).to eq 1
    end

    it 'should do nothing if the team is already last' do
      subject.move(autodraft_3.id, :down)
      autodraft_3.reload
      expect(autodraft_3.order).to eq 3
    end
  end

  describe 'moving an autodraft up' do
    it 'should decrease its order by 1' do
      subject.move(autodraft_2.id, :up)
      autodraft_2.reload
      expect(autodraft_2.order).to eq 1
    end

    it 'should swap orders with the autodraft it replaced' do
      subject.move(autodraft_2.id, :up)
      autodraft.reload
      expect(autodraft.order).to eq 2
    end

    it 'should do nothing if the team is already first' do
      subject.move(autodraft.id, :up)
      autodraft.reload
      expect(autodraft.order).to eq 1
    end
  end
end
