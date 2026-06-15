class CreateTopicMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :topic_messages do |t|
      t.references :topic, null: false, foreign_key: true
      t.references :message, null: false, foreign_key: true

      t.timestamps
    end
  end
end
