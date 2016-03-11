class Autodraft < ActiveRecord::Base
  belongs_to :draft
  belongs_to :player
  belongs_to :draftable

  def self.available_for(pick)
    #TODO optimize query
    autodrafts = where(draft:pick.draft, player: pick.player).order(:order)
    return next_available_autodraft(autodrafts, pick)
  end

  private

  def self.next_available_autodraft(autodrafts, pick)
    for autodraft in autodrafts do
      if Pick.where(draft: pick.draft, draftable: autodraft.draftable).empty?
        return autodraft
      end
    end
    return nil
  end
end
