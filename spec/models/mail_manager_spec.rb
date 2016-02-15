require 'rails_helper'


describe MailManager do
  
  describe '.send_pick_made_emails' do
    let(:draft) {create(:mid_draft_draft)}
    it "should send the next player up the 'on the clock' email" do
      MailManager.send_pick_made_emails(draft.recent_picks.last) 
      next_picker = draft.current_pick.player
      email_to_next_picker = ActionMailer::Base.deliveries.select do |d|
        d.to.first == next_picker.email
      end
      
      expect(email_to_next_picker.first.subject).
        to eq "Drafter: You're on the clock"
    end

  end


end
