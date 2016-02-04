class Player < ActiveRecord::Base
  acts_as_token_authenticatable
  devise :rememberable

  has_and_belongs_to_many :drafts

  validates :name, presence: true
  validates :email, presence: true

  def name=(value)
    super(value.titleize)
  end
end
