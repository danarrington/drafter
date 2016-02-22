class PlayersController < ApplicationController
  def show
    
    @facade = PlayerTeamFacade.new(params[:draft_id], current_player)
  end
end
