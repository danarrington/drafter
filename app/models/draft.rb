class Draft < ActiveRecord::Base
  has_and_belongs_to_many :players

  validates :name, presence: true
end
