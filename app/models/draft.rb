class Draft < ActiveRecord::Base
  has_and_belongs_to_many :players
  has_many :picks
  has_many :draftables

  validates :name, presence: true

  def current_pick
    picks.where(draftable:nil).order(:number).first
  end
end
