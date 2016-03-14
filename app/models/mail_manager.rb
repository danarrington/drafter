class MailManager
  #TODO: move to wherever we decide service objects live

  def self.send_pick_made_emails(picks)
    draft = picks.first.draft
    if draft.is_over?
      draft.players.each{|p| DraftMailer.last_pick_made(p, draft, picks).deliver}
    else
      draft.players.each{|p| send_pick_made_or_on_the_clock_email(p, draft, picks)}
    end
  end

  private

  def self.send_pick_made_or_on_the_clock_email(player, draft, picks)
    if player == draft.current_pick.player
      DraftMailer.on_the_clock(player, draft, picks).deliver
    else
      DraftMailer.pick_made(player, draft, picks).deliver
    end
  end


end
