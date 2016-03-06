class PlayersController < ApplicationController

  before_action :redirect_to_recap_if_draft_over

  def show
    @facade = PlayerTeamFacade.new(params[:draft_id], current_player,
                                   count: params[:count])
  end

  def all_picks
    @draft = Draft.find(params[:draft_id])
  end
end
