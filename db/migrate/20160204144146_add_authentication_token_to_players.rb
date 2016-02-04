class AddAuthenticationTokenToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :authentication_token, :string
    add_index :players, :authentication_token
  end
end
