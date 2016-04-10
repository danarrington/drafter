require 'rails_helper'

feature 'User adds an autodraft draftable' do
    let!(:draft) {create(:mid_draft_draft)}
    scenario 'they see the draftable added to their autodraft list' do
      on_deck_player = draft.next_5_picks.second.player
      visit pick_path(draft, on_deck_player, on_deck_player.token)
      click_link 'Set Autodraft'
      expect(page).to have_content 'Your current autodraft list'

      best_team_left_row = page.first(:css, '.remaining-draftables li')
      within(best_team_left_row) do
        click_button 'Add'
      end

      within('.current-autodrafts') do
        expect(page).to have_content best_team_left_row.find('.name').text
        expect(page).to have_content '1'
      end
      within('.remaining-draftables') do
        expect(page).to_not have_content best_team_left_row.find('.name').text
      end

      #add the next best team
      next_best_team_left_row = page.first(:css, '.remaining-draftables li')
      within(next_best_team_left_row) do
        click_button 'Add'
      end

      within('.current-autodrafts') do
        expect(page).to have_content best_team_left_row.find('.name').text
        expect(page).to have_content '2'
      end


    end

end
