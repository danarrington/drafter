class Pick < ActiveRecord::Base
  belongs_to :player
  belongs_to :draft
  belongs_to :draftable


  def players_pick_number
    draft.picks.where(player: player).where("number < #{number}").count+1
  end
end
