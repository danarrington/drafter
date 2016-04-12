require 'rails_helper'

feature 'Adding and managing autodrafts' do
    let!(:draft) {create(:mid_draft_draft)}
    scenario 'A user can add and view autodrafts' do
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

    scenario 'A user can remove an autodraft, re-ordering the rest' do
      on_deck_player = draft.next_5_picks.second.player
      visit autodrafts_path(draft, on_deck_player, on_deck_player.token)

      team_a_row = page.first(:css, '.remaining-draftables li')
      within(team_a_row) do
        click_button 'Add'
      end

      team_b_row = page.first(:css, '.remaining-draftables li')
      within(team_b_row) do
        click_button 'Add'
      end

      # Remove team a from autodraft
      first('li').click_button('Remove')

      within('.current-autodrafts') do
        expect(page).to_not have_content team_a_row.find('.name').text
      end



    end

end
