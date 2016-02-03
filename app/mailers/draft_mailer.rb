class DraftMailer < ActionMailer::Base
  default from: "from@sandbox03cef81ae9f946a197266c69d34b2f94.mailgun.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.draft_mailer.new_draft_started.subject
  #
  def new_draft_started
    @greeting = "Hi"

    mail to: "dan.arrington@gmail.com", subject: "We did it!"
  end
end
