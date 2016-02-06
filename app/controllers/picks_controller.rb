class PicksController < ApplicationController
  def new
    @player = current_player
  end

  def create
  end
end
