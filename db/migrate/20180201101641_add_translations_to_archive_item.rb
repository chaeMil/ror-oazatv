class AddTranslationsToArchiveItem < ActiveRecord::Migration[5.1]
  reversible do |dir|
    dir.up do
      ArchiveItem.create_translation_table!({
          :title => :string,
          :description => :text
      }, {
          :migrate_data => true
      })
    end

    dir.down do
      ArchiveItem.drop_translation_table! :migrate_data => true
    end
  end
end
