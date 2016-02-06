class DraftMailer < ActionMailer::Base
  default from: "from@sandbox03cef81ae9f946a197266c69d34b2f94.mailgun.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.draft_mailer.new_draft_started.subject
  #
  def new_draft_started(player)
    @greeting = "Hi"

    mail to: player.email, subject: "New draft started"
  end

  def on_the_clock(player)
    mail to: player.email, subject: "Drafter: You're on the clock"
  end
end
