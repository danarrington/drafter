class PicksController < ApplicationController
  def new
    draft = Draft.find(params[:draft_id])
    @pick_info = NewPickFacade.new(draft, current_player)
  end

  def make
    if submit_made_pick
      #TODO redirect to their team page
    else
      render text: "Wait your turn"
    end
  end

  private

  def submit_made_pick
    pick = Draft.find(params[:draft_id]).current_pick
    if pick.player != current_player
      return false
    end 
    return update_pick(pick)
  end

  def update_pick(pick)
    draftable = Draftable.find(params[:draftable_id])
    return pick.update(draftable: draftable)
  end

end
