class MailManager
  #TODO: move to wherever we decide service objects live

  def self.send_pick_made_emails(pick)
    draft = pick.draft
    if draft.is_over?
      draft.players.each{|p| DraftMailer.last_pick_made(p, draft).deliver}
    else
      draft.players.each{|p| send_pick_made_or_on_the_clock_email(p, draft)}
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
