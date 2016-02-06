class Draft < ActiveRecord::Base
  has_and_belongs_to_many :players
  has_many :picks
  has_many :draftables

  validates :name, presence: true

  def current_pick
    picks.where(draftable:nil).order(:number).first
  end

  def remaining_draftables
    draftables.joins('left outer join picks on draftables.id = picks.draftable_id').
      select('draftables.*, picks.id as pick_id').where('picks.id is null').
      order(:rank)

  end
end
