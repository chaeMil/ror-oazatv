class AddSyncToArchiveFile < ActiveRecord::Migration[5.1]
  def change
    add_column :archive_files, :sync, :double
  end
end
