require "rails_helper"

RSpec.describe DraftMailer, type: :mailer do
  describe "new_draft_started" do
    let(:mail) { DraftMailer.new_draft_started }

    it "renders the headers" do
      expect(mail.subject).to eq("New draft started")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
