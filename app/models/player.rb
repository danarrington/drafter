class Player < ActiveRecord::Base
  devise :rememberable

  has_and_belongs_to_many :drafts
  has_many :picks

  validates :name, presence: true
  validates :email, presence: true

  before_save :update_auth_token

  def name=(value)
    super(value.titleize)
  end

  def picks_for(draft)
    picks.where(draft:draft)
  end

  def made_picks_for(draft)
      picks.where(draft:draft).where.not(draftable:nil)
  end

  private 
  def update_auth_token
    self.authentication_token = Devise.friendly_token
  end
end
