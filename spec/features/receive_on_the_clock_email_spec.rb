require 'rails_helper'

describe "Receiving a 'on the clock' email during a draft" do
  let(:draft) {create(:mid_draft_draft)}

  before do
    clear_emails
    current_picker = draft.current_pick.player
    DraftMailer.on_the_clock(current_picker, draft).deliver
    open_email(current_picker.email)
  end

  it 'should list the most recent pick' do
    last_pick = draft.most_recently_made_pick
    expected = "With the 2nd overall pick #{last_pick.player.name} has " +
    "selected #{last_pick.draftable.name}"
    expect(current_email).to have_content expected
  end

  it 'should be able to make a pick from the email' do
    current_picker = draft.current_pick.player
    current_email.click_link 'Pick', match: :first
      
    expect(current_picker.made_picks_for(draft).count).to eq 1
  end

  it 'should be able to go to the pick page' do
    current_email.click_link 'See All Teams'
    expect(page).to have_content 'Show More'
  end

  context 'late in a draft' do
    let(:draft) {create(:late_draft_draft)}

    it 'should let a player know this is their last pick' do
      expect(current_email).to have_content "This is your last pick!"
    end
  end
end

