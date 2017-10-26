class RenameTypeToFileType < ActiveRecord::Migration[5.1]
  def change
    change_table :archive_files do |t|
      t.rename :type, :file_type
    end
  end
end
