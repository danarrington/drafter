class Player < ActiveRecord::Base

  validates :name, presence: true
  validates :email, presence: true

  def name=(value)
    super(value.titleize)
  end
end
