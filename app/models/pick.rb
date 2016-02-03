class Pick < ActiveRecord::Base
  belongs_to :player
  belongs_to :draft
  belongs_to :draftable
end
