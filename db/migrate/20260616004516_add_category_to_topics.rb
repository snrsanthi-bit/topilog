class AddCategoryToTopics < ActiveRecord::Migration[7.0]
  def change
    add_column :topics, :category, :integer, null: false, default: 0
  end
end
