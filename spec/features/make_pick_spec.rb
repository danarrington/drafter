require 'rails_helper'

describe 'Making a pick' do
  let!(:draft) {create(:mid_draft_draft)}

  context 'A user picking third, who is on the clock' do
    it 'should be able to make a pick' do
      player = draft.current_pick.player
      visit pick_path(draft, player, player.authentication_token)
      expect(page).to have_content "#{player.name}'s 1st pick"
      expect(page).to have_content "3rd overall"
    end

  end



end
