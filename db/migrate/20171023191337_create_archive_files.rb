class CreateArchiveFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :archive_files do |t|
      t.string :filename
      t.string :type

      t.timestamps
    end
  end
end
