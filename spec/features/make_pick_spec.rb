require 'rails_helper'

describe 'Making a pick' do

  context 'A user picking third, who is on the clock' do
    let!(:draft) {create(:mid_draft_draft)}
    it 'should be able to make a pick' do
      player = draft.current_pick.player
      visit pick_path(draft, player, player.authentication_token)
      expect(page).to have_content player.name
      expect(page).to have_content "1st pick"
      expect(page).to have_content "3rd overall"
      expect(page).to have_content draft.draftables[2].name
      click_button 'Pick', match: :first

      expect(player.made_picks_for(draft).count).to eq 1
    end

    it 'should be able to see more teams' do
      player = draft.current_pick.player
      visit pick_path(draft, player, player.authentication_token)

      within('.draftable-table', match: :first) do
        expect(page).to have_selector('.rank', count: 5)
      end
        click_link 'Show More'
      within('.draftable-table', match: :first) do
        expect(page).to have_selector('.rank', count: 10)
      end
        click_link 'Show More'
      within('.draftable-table', match: :first) do
        expect(page).to have_selector('.rank', count: 15)
      end
    end

    it 'should be able to see recent picks by other players' do
      player = draft.current_pick.player
      visit pick_path(draft, player, player.authentication_token)
      previous_pick = Pick.where(draft: draft, 
        number: draft.current_pick.number-1).first

      expect(page).to have_content previous_pick.player.name
      expect(page).to have_content previous_pick.draftable.name
    end

  end

  context 'A player making their 4th pick' do
    let!(:draft) {create(:late_draft_draft)}
    it 'should be able to see their previous picks' do
      player = draft.current_pick.player
      visit pick_path(draft, player, player.authentication_token)

      expect(page).to have_content('Your Picks')
      expect(page).to have_content(player.picks.first.draftable.name)
    end

  end



end
