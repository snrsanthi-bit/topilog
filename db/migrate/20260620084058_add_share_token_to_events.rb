class AddShareTokenToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :share_token, :string

    add_index :events, :share_token, unique: true
  end
end