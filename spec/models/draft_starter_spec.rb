require 'rails_helper' 

describe DraftStarter do
  let(:players) {create_list(:player, 5)}
  let(:draft) {create(:draft_with_draftables, players: players)}
  subject {DraftStarter.new(draft)}
  
  before {DraftOrderer.generate_or_retrieve_picks(draft)}

  describe '#start' do
    it 'should send the new_draft_started email to each player' do
      expect {
        subject.start
      }.to change {ActionMailer::Base.deliveries.count}.by(6)
    end

    it 'should email the player with the first pick' do
      subject.start
      last_email = ActionMailer::Base.deliveries.last
      expect(last_email.to.first).to eq Pick.first.player.email
      expect(last_email.subject).to eq "Drafter: You're on the clock"
    end



  end

end
