require 'rails_helper'

describe DraftOrderer do

  describe '#generate_or_retrieve_picks' do
    let!(:draft) {create(:draft)}
    let!(:players) {create_list(:player, 5, drafts: [draft])}
    let!(:draftables) {create_list(:draftable, 20, draft: draft)}

    it 'returns the draft order as an array of players' do
      pick_1 = create(:pick, player: players[0], draft: draft)
      pick_2 = create(:pick, player: players[1], draft: draft)
      pick_3 = create(:pick, player: players[2], draft: draft)

      draft_order = DraftOrderer.generate_or_retrieve_picks(draft)
      expect(draft_order).to eq [pick_1.player, pick_2.player, pick_3.player]
    end

    context 'draft with existing picks' do
      let!(:picks) {create_list(:pick, 20, draft: draft)}

      it 'does not create new picks' do
        expect {
          DraftOrderer.generate_or_retrieve_picks(draft)
        }.to_not change(Pick, :count)
      end
    end

    context 'draft with no existing picks' do
      
      it 'creates new picks' do
        expect {
          DraftOrderer.generate_or_retrieve_picks(draft)
        }.to change(Pick, :count).by(draftables.count)
      end

      it 'creates picks in a snake order' do
        DraftOrderer.generate_or_retrieve_picks(draft)
        fifth_pick = Pick.where(draft: draft, number:5).first
        sixth_pick = Pick.where(draft: draft, number:6).first

        expect(fifth_pick.player).to eq sixth_pick.player
        expect(Pick.first.player).to eq Pick.last.player
      end
    end
  end
end
