class RenameArchiveItemHashColumn < ActiveRecord::Migration[5.1]
  def change
    change_table :archive_items do |t|
      t.rename :hash, :hash_id
    end
  end
end
