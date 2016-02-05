class DeviseUpdatePlayers< ActiveRecord::Migration
  def change
      ## Rememberable
      add_column :playser, :remember_created_at, :datetime
  end
end
