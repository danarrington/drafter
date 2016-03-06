class RecapsController < ApplicationController
  def show
    @draft = Draft.find(params[:draft_id])
  end
end
