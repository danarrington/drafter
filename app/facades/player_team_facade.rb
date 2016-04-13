class PlayerTeamFacade
  include Rails.application.routes.url_helpers

  attr_accessor :current_pick, :current_picker, :any_picks_left,
    :your_next_pick, :picks, :surrounding_picks, :draft, :count,
    :player

  
  def initialize(draft_id, player, count: nil)
    @count = count ? count.to_i : 5
    @draft = Draft.find(draft_id)
    @current_pick = draft.current_pick.number.ordinalize
    @current_picker = draft.current_pick.player.name
    @picks = player.picks_for(draft)
    @any_picks_left = draft.next_pick_for(player)
    @surrounding_picks = draft.surrounding_picks(@count)
    @player = player

    if @any_picks_left
      @your_next_pick = draft.next_pick_for(player).number.ordinalize
    end
  end

  def show_more_path
    player_page_path(@draft, count: @count+5)
  end

  def more_to_show?
    @count >= draft.picks.count
  end

  def autodraft_path
    draft_autodrafts_path(@draft)
  end


end
