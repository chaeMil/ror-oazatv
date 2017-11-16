class AddLanguageAndArchiveFileReferences < ActiveRecord::Migration[5.1]
  def change
    change_table :languages do |t|
      t.remove :archive_file
    end
  end
end
