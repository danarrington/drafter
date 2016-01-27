class DraftController < ApplicationController

  def welcome
  end

  def new
    @draft = Draft.new
  end

  def create
    if save_new_draft
      redirect_to add_players_path(@draft)
    else
      render :new
    end
  end

  def add_players
    draft = Draft.find(params[:id])
    player = Player.new
    @facade = NewDraftFacade.new(draft, player)
  end

  def add_player
    if add_new_player_to_draft
      redirect_to add_players_path
    else
      render :add_players
    end
  end

  private
  def player_params
    params.require(:player).permit(:name, :email)
  end

  def draft_params
    params.require(:draft).permit(:name)
  end

  def save_new_draft
    @draft = Draft.new(draft_params)
    @draft.save
  end

  def add_new_player_to_draft
    @draft = Draft.find(params[:id])
    if create_new_player
      add_player_to_draft
    else
      return false
    end
  end

  def create_new_player
    @player = Player.new(player_params)
    @player.save
  end

  def add_player_to_draft
    @draft.players << @player
    @draft.save
  end
end
