class CreateTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :topics do |t|
      t.references :event, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
