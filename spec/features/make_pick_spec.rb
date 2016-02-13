require 'rails_helper'

describe 'Making a pick' do
  let!(:draft) {create(:mid_draft_draft)}

  context 'A user picking third, who is on the clock' do
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

      expect(page).to have_selector('.rank', count: 5)
      click_link 'Show More'
      expect(page).to have_selector('.rank', count: 10)
      click_link 'Show More'
      expect(page).to have_selector('.rank', count: 15)
    end

  end



end
