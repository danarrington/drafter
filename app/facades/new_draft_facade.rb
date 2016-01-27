class NewDraftFacade

  attr_accessor :draft, :player, :current_players

  def initialize(draft, player)
    @draft = draft
    @player = player
    @current_players = @draft.players
  end


end
