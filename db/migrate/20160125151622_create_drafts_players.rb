class CreateDraftsPlayers < ActiveRecord::Migration
  def change
    create_table :drafts_players do |t|
      t.belongs_to :player, index: true
      t.belongs_to :draft, index: true
    end
  end
end
