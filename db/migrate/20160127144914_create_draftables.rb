class CreateDraftables < ActiveRecord::Migration
  def change
    create_table :draftables do |t|
      t.string :name
      t.integer :rank
      t.belongs_to :draft, index: true

      t.timestamps
    end
  end
end
