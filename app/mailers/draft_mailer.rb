class DraftMailer < ActionMailer::Base
  default "Message-ID" => lambda {|v| "<#{SecureRandom.uuid}@#{Rails.configuration.mailgun_domain}"}

  def new_draft_started(player)
    @greeting = "Hi"

    #TODO: Implement new draft email, on the clock will work for now.
    #mail to: player.email, subject: "New draft started"
  end

  def on_the_clock(recipient, draft, picks = [])
    @draft = draft
    @player = recipient
    @picks = picks
    @next_pick = draft.next_pick_for(recipient)
    @top_remaining_draftables = draft.remaining_draftables.limit(5)
    @existing_team = @player.made_picks_for(@draft)
    mail to: recipient.email, subject: "Drafter: You're on the clock"
  end

  def pick_made(recipient, draft, picks)
    @picks = picks
    @recipient = recipient
    @next_picker = draft.current_pick.player
    @next_pick = draft.next_pick_for(recipient)
    @upcoming_picks = draft.next_5_picks
    @top_remaining_draftables = draft.remaining_draftables.limit(5)
    @autodraft_path = draft_autodrafts_path(draft)
    mail to: recipient.email, subject: "Drafter: A pick has been made"
  end

  def last_pick_made(recipient, draft, picks)
    #TODO finish this email
    @picks = picks
    @player_team = recipient.picks_for(draft)
    @draft = draft
    @other_players = @draft.players.reject {|p| p == recipient}
    mail to: recipient.email, subject: "Drafter: The last pick is in"
  end

end
