class DraftablesController < ApplicationController
  skip_before_action :authenticate_user_from_token!

  def batch_new
  end

  def batch_create
    if params[:draftables].blank?
      render :batch_new
    else
      create_draftables_and_redirect
    end
  end

  private

  def create_draftables_and_redirect
    draft = Draft.find(params[:draft_id])
    params[:draftables].split(',').each_with_index do |name, i|
      Draftable.create(name: name.strip, rank: i+1, draft: draft)
    end
    redirect_to review_draft_path(draft)
  end
end
