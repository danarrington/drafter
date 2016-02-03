# Preview all emails at http://localhost:3000/rails/mailers/draft_mailer
class DraftMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/draft_mailer/new_draft_started
  def new_draft_started
    DraftMailer.new_draft_started
  end

end
