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

  describe "last_pick_made" do
    let(:player) {create(:player)}
    let(:draft) {create(:finished_draft)}
    let(:mail) { DraftMailer.last_pick_made(player, draft) }

    it "renders the headers" do
      expect(mail.subject).to eq("Drafter: The last pick is in")
      expect(mail.to).to eq([player.email])
    end

    it "renders the body" do
      expected_content = "With the 20th and final pick"
      expect(mail.body.encoded).to match(expected_content)
    end
  end
end
