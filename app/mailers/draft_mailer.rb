class DraftMailer < ActionMailer::Base
  default from: "from@sandbox03cef81ae9f946a197266c69d34b2f94.mailgun.org"

  def new_draft_started(player)
    @greeting = "Hi"

    mail to: player.email, subject: "New draft started"
  end

  def on_the_clock(player, draft)
    @draft = draft
    @player = player
    mail to: player.email, subject: "Drafter: You're on the clock"
  end

  def pick_made(recipient, draft)
    @pick = draft.most_recently_made_pick
    @recipient = recipient
    @next_picker = draft.current_pick.player
    @next_pick = draft.next_pick_for(recipient).number.ordinalize
    @upcoming_picks = draft.next_5_picks
    @top_remaining_draftables = draft.remaining_draftables.limit(5)
    mail to: recipient.email, subject: "Drafter: A pick has been made"
  end

end
