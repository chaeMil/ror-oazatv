class AddProcessingColumnToPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :image_processing, :boolean, null: false, default: false
  end
end
