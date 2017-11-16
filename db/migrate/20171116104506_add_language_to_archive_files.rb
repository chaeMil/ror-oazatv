class AddLanguageToArchiveFiles < ActiveRecord::Migration[5.1]
  def change
    change_table :archive_files do |t|
      t.remove :language_id
    end
    add_reference :archive_files, :language, foreign_key: true
  end
end
