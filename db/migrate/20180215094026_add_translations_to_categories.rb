class AddTranslationsToCategories < ActiveRecord::Migration[5.1]
  def change
  end

  reversible do |dir|
    dir.up do
      Category.create_translation_table! :title => :string
    end

    dir.down do
      Category.drop_translation_table!
    end
  end
end
