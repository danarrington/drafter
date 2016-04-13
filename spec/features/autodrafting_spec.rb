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
      visit autodraft_path_for(on_deck_player)

      3.times { add_top_remaining_draftable }

      top_autodraft_row = first('li')
      top_autodraft_row.click_button('Remove')

      within('.current-autodrafts') do
        expect(page).to_not have_content top_autodraft_row.find('.name').text
      end
    end

    scenario 'A user can re-order existing autodrafts' do
      on_deck_player = draft.next_5_picks.second.player
      visit autodraft_path_for(on_deck_player)
      3.times { add_top_remaining_draftable }

      original_autodrafts = page.all('.current-autodrafts li')
      original_autodrafts[0].find('.fa-chevron-down').click
      original_top_team = original_autodrafts[0].find('.name').text

      reordered_autodrafts = page.all('.current-autodrafts li')
      expect(reordered_autodrafts[1]).to have_content '2'
      expect(reordered_autodrafts[1]).to have_content original_top_team

      reordered_autodrafts[1].find('.fa-chevron-up').click
      rereordered_autodrafts = page.all('.current-autodrafts li')
      expect(rereordered_autodrafts[0]).to have_content '1'
      expect(rereordered_autodrafts[0]).to have_content original_top_team

    end

    private

    def add_top_remaining_draftable
      within('.remaining-draftables') do
        first('li').click_button('Add')
      end
    end

    def autodraft_path_for(player)
      draft_autodrafts_path(draft, player_id: player, token: player.token)
    end

end
