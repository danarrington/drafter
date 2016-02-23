class PlayerTeamFacade

  attr_accessor :current_pick, :current_picker, :any_picks_left,
    :your_next_pick, :picks

  
  def initialize(draft_id, player)
    draft = Draft.find(draft_id)
    @current_pick = draft.current_pick.number.ordinalize
    @current_picker = draft.current_pick.player.name
    @picks = player.picks_for(draft)
    @any_picks_left = draft.next_pick_for(player)

    if @any_picks_left
      @your_next_pick = draft.next_pick_for(player).number.ordinalize
    end
  end


end
