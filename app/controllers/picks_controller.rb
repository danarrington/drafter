class PicksController < ApplicationController

  before_action :redirect_to_player_page_unless_current_picker

  def new
    draft = Draft.find(params[:draft_id])
    @pick_info = NewPickFacade.new(draft, current_player, count: params[:count])
  end

  def make
    unless PickHandler.run(params[:draft_id], params[:draftable_id])
      #TODO Flash error 'team already taken', redirect to new
      render text: "Quit trying to cheat"
    else
      @pick_info = MadePickFacade.new(params[:draft_id])
    end
  end

  private

  def redirect_to_player_page_unless_current_picker
    draft = Draft.find(params[:draft_id])
    redirect_to player_page_url unless draft.current_pick.player == current_player
  end
end
