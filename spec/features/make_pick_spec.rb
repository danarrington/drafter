require 'rails_helper'

describe 'Making a pick' do
  before(:each) {ActionMailer::Base.deliveries.clear}

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

      expect(page).to have_content("You're pick is in!")
      expect(page).to have_content(draft.draftables[2].name)
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

    it 'making a pick results in emails being sent' do
      player = draft.current_pick.player
      visit pick_path(draft, player, player.authentication_token)

      click_button 'Pick', match: :first

      expect(ActionMailer::Base.deliveries.count).to eq draft.players.count
    end

  end

  context 'A player picking 5th with back-to-back picks' do
    let!(:draft) {create(:mid_draft_draft)}
    before do
      draft.current_pick.update(draftable: draft.remaining_draftables.first)
      draft.current_pick.update(draftable: draft.remaining_draftables.first)
    end

    it 'should be prompted to make their next pick immediately' do
      draft.reload
      player = draft.current_pick.player
      visit pick_path(draft, player, player.authentication_token)
      click_button 'Pick', match: :first

      expect(page).to have_content 'Pick again'
    end
  end

  context 'A player making their 4th and last pick' do
    let!(:draft) {create(:late_draft_draft)}
    it 'should be able to see their previous picks' do
      player = draft.current_pick.player
      visit pick_path(draft, player, player.authentication_token)

      expect(page).to have_content('Your Picks')
      expect(page).to have_content(player.picks.first.draftable.name)
    end

    it 'should be able to see recent picks by other players' do
      player = draft.current_pick.player
      visit pick_path(draft, player, player.authentication_token)
      previous_pick = Pick.where(draft: draft,
        number: draft.current_pick.number-1).first

      expect(page).to have_content previous_pick.player.name
      expect(page).to have_content previous_pick.draftable.name
    end

    it 'should be able to make a pick' do
      player = draft.current_pick.player
      visit pick_path(draft, player, player.authentication_token)
      click_button 'Pick', match: :first
    end
  end

  context 'A player picking when the on-deck picker has an autodraft set' do
    let!(:draft) {create(:mid_draft_draft)}
    let(:team_to_autodraft) {draft.draftables.last}
    before do
      next_picker = draft.next_5_picks.second.player
      create(:autodraft, draft: draft, player: next_picker,
             draftable: team_to_autodraft)
    end

    it 'should autodraft for the on deck player' do
      player = draft.current_pick.player
      visit pick_path(draft, player, player.authentication_token)
      click_button 'Pick', match: :first

      expect(draft.most_recently_made_pick.draftable).to eq team_to_autodraft
    end



  end



end
