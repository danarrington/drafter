class Player < ActiveRecord::Base
  devise :rememberable

  has_and_belongs_to_many :drafts

  validates :name, presence: true
  validates :email, presence: true

  before_save :update_auth_token

  def name=(value)
    super(value.titleize)
  end

  private 
  def update_auth_token
    self.authentication_token = Devise.friendly_token
  end
end
