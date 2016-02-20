class PicksController < ApplicationController

  before_action :redirect_to_player_page_unless_current_picker

  def new
    draft = Draft.find(params[:draft_id])
    @pick_info = NewPickFacade.new(draft, current_player, count: params[:count])
  end

  def make
    unless submit_made_pick
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

  def submit_made_pick
    draft = Draft.find(params[:draft_id])
    unless draft.draftable_available(params[:draftable_id])
      return false
    end 
    update_pick_and_send_emails(draft.current_pick)
  end

  def update_pick_and_send_emails(pick)
    draftable = Draftable.find(params[:draftable_id])
    pick.update(draftable: draftable)
    MailManager.send_pick_made_emails(pick)
  end

end
