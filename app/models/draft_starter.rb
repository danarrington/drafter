class DraftStarter

  def initialize(draft)
    @draft = draft
  end

  def start
    @draft.players.each do |player|
      DraftMailer.new_draft_started(player).deliver
    end
    first_picker = @draft.picks.first.player
    DraftMailer.on_the_clock(first_picker, @draft).deliver
  end

end
