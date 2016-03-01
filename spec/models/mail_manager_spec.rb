require 'rails_helper'


describe MailManager do

  before(:each) {ActionMailer::Base.deliveries.clear}
  
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

    context 'where last pick has been made' do
      let(:draft) {create(:finished_draft)}

      it "should send all players the 'draft finished' email" do
        MailManager.send_pick_made_emails(draft.most_recently_made_pick)
        expect(ActionMailer::Base.deliveries.count).to eq draft.players.count
        ActionMailer::Base.deliveries.each do |d|
          expect(d.subject).to eq "Drafter: The last pick is in"
        end
      end
    end

  end


end
