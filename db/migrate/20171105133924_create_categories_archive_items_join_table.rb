class CreateCategoriesArchiveItemsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :archive_items, :categories
  end
end
