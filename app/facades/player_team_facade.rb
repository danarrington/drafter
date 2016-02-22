class PlayerTeamFacade

  attr_accessor :current_pick, :current_picker, :any_picks_left, 
    :your_next_pick

  
  def initialize(draft_id, player)
    draft = Draft.find(draft_id)
    @current_pick = draft.current_pick.number.ordinalize
    @current_picker = draft.current_pick.player.name
    next_pick = draft.next_pick_for(player)
    @any_picks_left = !next_pick.nil? 
    if @any_picks_left
      @your_next_pick = draft.next_pick_for(player).number.ordinalize
    end
  end

end
