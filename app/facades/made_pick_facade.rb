class MadePickFacade
  include Rails.application.routes.url_helpers

  attr_accessor :pick_number, :drafted_team, :next_picker, :next_pick, 
    :has_next_pick, :draft, :pick

  def initialize(draft_id)
    @draft = Draft.find(draft_id)
    @pick = draft.most_recently_made_pick
    @pick_number = pick.number.ordinalize
    @drafted_team = pick.draftable.name
    @next_picker = draft.current_pick.player.name
    next_pick = draft.next_pick_for(pick.player)
    if next_pick
      @next_pick = next_pick.number.ordinalize
    end
    @has_next_pick = draft.current_pick.player == @pick.player
  end

  def pick_again_path
    pick_path(@draft.id, @pick.player.id, @pick.player.token)
  end

end
