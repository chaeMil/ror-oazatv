class RenameFilenameToFileInArchiveFile < ActiveRecord::Migration[5.1]
  def change
    change_table :archive_files do |t|
      t.rename :filename, :file
    end
  end
end
