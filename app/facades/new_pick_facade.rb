class NewPickFacade

  attr_accessor :draft, :player_name, :player_pick_number, :overall_pick_number

  def initialize(draft, player)
    @draft = draft
    @player_name = player.name
    pick = @draft.current_pick
    @player_pick_number = pick.players_pick_number.ordinalize
    @overall_pick_number = pick.number.ordinalize

  end
end
