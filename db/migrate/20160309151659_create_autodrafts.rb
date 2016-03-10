class CreateAutodrafts < ActiveRecord::Migration
  def change
    create_table :autodrafts do |t|
      t.references :draft, index: true
      t.references :player, index: true
      t.references :draftable, index: true
      t.integer :order

      t.timestamps
    end
  end
end
