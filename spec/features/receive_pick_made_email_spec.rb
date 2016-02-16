require 'rails_helper'

describe "Receiving a 'pick made' email during a draft" do
  let(:draft) {create(:mid_draft_draft)}

  before do
    clear_emails
    current_pick = draft.current_pick
    current_pick.update(draftable: draft.remaining_draftables.first)
    on_deck_pick = Pick.find(current_pick.id + 2)
    DraftMailer.pick_made(on_deck_pick.player, draft).deliver
    open_email(on_deck_pick.player.email)
  end

  it 'should list the most recent pick' do
    last_pick = draft.most_recently_made_pick
    expected = "With the 3rd overall pick #{last_pick.player.name} has " +
    "selected #{last_pick.draftable.name}"
    expect(current_email).to have_content expected
  end

  it 'should say who is now on the clock' do
    expected = "#{draft.current_pick.player.name} is now on the clock"
    expect(current_email).to have_content expected
  end

  it 'should list the recipients next pick' do
    #emailing the 
    expected = "You're next pick is the 5th pick"
    expect(current_email).to have_content expected
  end

  it 'should list the next 5 drafters' do
    next_5_picks = draft.picks.where(number: (3..7))
    next_5_picks.each do |p|
      expect(current_email).to have_content p.player.name
    end
  end

  it 'should list the top 5 remaining draftables' do
    top_5_remaining_draftables = draft.remaining_draftables.limit(5)
    sixth_best_draftable = draft.remaining_draftables[5]

    top_5_remaining_draftables.each do |d|
      expect(current_email).to have_content d.name
    end

    expect(current_email).to_not have_content sixth_best_draftable.name
  end



end
