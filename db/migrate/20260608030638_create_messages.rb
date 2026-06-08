class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :event, null: false, foreign_key: true
      t.string :speaker_name
      t.text :content
      t.datetime :posted_at

      t.timestamps
    end
  end
end
