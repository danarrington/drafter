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
    update_pick_and_send_emails(pick)
  end

  def update_pick_and_send_emails(pick)
    draftable = Draftable.find(params[:draftable_id])
    pick.update(draftable: draftable)
    MailManager.send_pick_made_emails(pick)
  end

end
