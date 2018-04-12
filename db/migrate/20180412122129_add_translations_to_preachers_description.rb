class AddTranslationsToPreachersDescription < ActiveRecord::Migration[5.1]
  reversible do |dir|
    dir.up do
      Preacher.create_translation_table! description: :string
    end

    dir.down do
      Preacher.drop_translation_table!
    end
  end
end
