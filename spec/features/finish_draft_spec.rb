require 'rails_helper'

describe 'Making the last pick of a draft' do

  let!(:draft) {create(:last_pick_draft)}
  before(:each) {ActionMailer::Base.deliveries.clear}

  it 'Displays the draft recap and sends the end of draft email' do
    player = draft.current_pick.player
    visit pick_path(draft, player, player.token)
    click_button "Pick"

    #TODO expect to see draft recap
    expect(page).to have_content 'This concludes the draft'

    all_deliveries = ActionMailer::Base.deliveries
    expect(all_deliveries.count).to eq draft.players.count
    expect(all_deliveries.last.subject).to eq "Drafter: The last pick is in"

  end




end
