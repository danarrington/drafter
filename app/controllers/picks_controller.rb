class PicksController < ApplicationController
  def new
    draft = Draft.find(params[:draft_id])
    @pick_info = NewPickFacade.new(draft, current_player)
  end

  def create
  end
end
