class AddLanguageToArchiveFile < ActiveRecord::Migration[5.1]
  def change
    change_table :archive_files do |t|
      t.integer :language_id
    end
  end
end
