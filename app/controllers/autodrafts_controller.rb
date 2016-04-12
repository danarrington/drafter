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
    repo = AutoDraftRepository.new(draft, current_player)
    repo.save(draftable)
    redirect_to autodrafts_path(draft, current_player)
  end

  before_action :redirect_to_player_page_if_unauthorized_delete, only: [:destroy]

  def destroy
    autodraft = Autodraft.find(params[:id])
    repo = AutoDraftRepository.new(autodraft.draft, current_player)
    repo.destroy(autodraft.id)
    redirect_to autodrafts_path(autodraft.draft, autodraft.player)
  end

  private

  def redirect_to_player_page_if_unauthorized_delete
    autodraft = Autodraft.find(params[:id])
    if autodraft.player != current_player
      redirect_to player_page_url(autodraft.draft)
    end
  end
end
