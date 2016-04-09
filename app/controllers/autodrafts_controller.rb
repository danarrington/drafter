class AutodraftsController < ApplicationController
  def index
    @draft = Draft.find(params[:draft_id])
    @autodrafts = Autodraft.current_for(@draft, current_player)
    @top_remaining = @draft.remaining_draftables.limit(10).reject{|d| 
      @autodrafts.collect(&:draftable_id).include?(d.id)
    }
    @player = current_player
  end

  def create
    draft = Draft.find(params[:draft_id])
    draftable = Draftable.find(params[:draftable_id])
    Autodraft.create(draft: draft, draftable: draftable, player: current_player)
    redirect_to autodrafts_path(draft, current_player)
  end
end
