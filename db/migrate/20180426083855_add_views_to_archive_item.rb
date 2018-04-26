class AddViewsToArchiveItem < ActiveRecord::Migration[5.1]
  def change
    add_column :archive_items, :views, :integer
  end
end
