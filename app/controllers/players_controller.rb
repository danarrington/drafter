class PlayersController < ApplicationController
  def show
    @facade = PlayerTeamFacade.new(params[:draft_id], current_player, 
                                   count: params[:count])
  end

  def all_picks
    @draft = Draft.find(params[:draft_id])
  end
end
