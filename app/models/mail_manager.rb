class MailManager

  def self.send_pick_made_emails(pick)
    draft = pick.draft
    draft.players.each do |player|
      send_pick_made_or_on_the_clock_email(player, draft)
    end
  end

  private

  def self.send_pick_made_or_on_the_clock_email(player, draft)
    if player == draft.current_pick.player
      DraftMailer.on_the_clock(player, draft).deliver
    else
      DraftMailer.pick_made(player, draft).deliver
    end
  end


end
