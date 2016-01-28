class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.belongs_to :draft, index: true
      t.belongs_to :player, index: true
      t.belongs_to :draftable
      t.integer    :number

      t.timestamps
    end
  end
end
