class NewPickFacade
  include Rails.application.routes.url_helpers

  attr_accessor :draft, :player, :pick, :player_name, :player_pick_number, 
    :overall_pick_number, :top_draftables

  def initialize(draft, player)
    @pick = draft.current_pick
    @player = player
    @draft = draft
    @player_name = player.name
    @player_pick_number = pick.players_pick_number.ordinalize
    @overall_pick_number = pick.number.ordinalize
    @top_draftables = draft.remaining_draftables.limit(5)
  end

  def pick_path_for(draftable)
    make_pick_path(@draft, draftable)
  end
end
