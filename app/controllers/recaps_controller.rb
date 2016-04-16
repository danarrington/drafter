class RecapsController < ApplicationController
  def show
    @draft = Draft.find(params[:draft_id])
    redirect_to pick_path(@draft, current_player) unless @draft.is_over?
  end
end
