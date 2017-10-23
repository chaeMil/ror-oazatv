class AddArchiveItemRefToArchiveFiles < ActiveRecord::Migration[5.1]
  def change
    add_reference :archive_files, :archive_item, foreign_key: true
  end
end
