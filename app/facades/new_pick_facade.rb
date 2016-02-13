class NewPickFacade
  include Rails.application.routes.url_helpers

  attr_accessor :draft, :player, :pick, :player_name, :player_pick_number, 
    :overall_pick_number, :top_draftables, :count

  def initialize(draft, player, count: nil)
    @count = count ? count.to_i : 5
    @pick = draft.current_pick
    @player = player
    @draft = draft
    @player_name = player.name
    @player_pick_number = pick.players_pick_number.ordinalize
    @overall_pick_number = pick.number.ordinalize
    @top_draftables = draft.remaining_draftables.limit(@count)
  end

  def pick_path_for(draftable)
    make_pick_path(@draft, draftable)
  end

  def show_more_path
    pick_path(@draft, @player, @player.token, count: @count+5)
  end
end
