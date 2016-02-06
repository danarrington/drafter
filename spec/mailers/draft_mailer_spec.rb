require "rails_helper"

RSpec.describe DraftMailer, type: :mailer do
  describe "new_draft_started" do
    let(:player) {create(:player)}
    let(:mail) { DraftMailer.new_draft_started(player) }

    it "renders the headers" do
      expect(mail.subject).to eq("New draft started")
      expect(mail.to).to eq([player.email])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
