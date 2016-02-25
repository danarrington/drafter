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

  def recent_picks
    picks.where('number < ?', current_pick.number).order(number: :desc).limit(5)
  end

  def most_recently_made_pick
    picks.where.not(draftable:nil).order(number: :desc).first
  end

  def next_5_picks
    picks.where(draftable:nil).order(:number).limit(5)
  end

  def next_pick_for(player)
    current_pick_id = current_pick.id
    picks.where(draftable:nil, player: player).where.not(id: current_pick_id).
      order(:number).first  
  end

  def surrounding_picks(count)
    current_number = current_pick.number
    picks.where(number: current_number-2..current_number+count-3)
  end

  def draftable_available(draftable_id)
    picks.where(draftable_id: draftable_id).empty?
  end

end
