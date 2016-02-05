class DeviseUpdatePlayers< ActiveRecord::Migration
  def change
      ## Rememberable
      add_column :players, :remember_created_at, :datetime
  end
end
