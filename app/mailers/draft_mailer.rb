class DraftMailer < ActionMailer::Base
  default from: "from@sandbox03cef81ae9f946a197266c69d34b2f94.mailgun.org"

  def new_draft_started(player)
    @greeting = "Hi"

    mail to: player.email, subject: "New draft started"
  end

  def on_the_clock(player, pick)
    @draft = pick.draft
    @player = player
    mail to: player.email, subject: "Drafter: You're on the clock"
  end

  def pick_made(player, pick, next_pick)
    @pick = pick
    @next_picker = next_pick.player
    @receiver_picks_next = @next_picker == player
    mail to: player.email, subject: "Drafter: A pick has been made"
  end

end
