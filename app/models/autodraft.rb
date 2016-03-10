class Autodraft < ActiveRecord::Base
  belongs_to :draft
  belongs_to :player
  belongs_to :draftable
end
