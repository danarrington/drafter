class MailManager

  def self.send_pick_made_emails(pick)
    draft = pick.draft
    draft.players.each do |player|
      DraftMailer.pick_made(player, pick, draft.current_pick).deliver
    end
  end


end
