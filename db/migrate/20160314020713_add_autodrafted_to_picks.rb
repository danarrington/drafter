class AddAutodraftedToPicks < ActiveRecord::Migration
  def change
    add_column :picks, :autodrafted, :boolean
  end
end
