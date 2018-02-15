class AddTranslationsToPhotoAlbums < ActiveRecord::Migration[5.1]
  def change
  end

  reversible do |dir|
    dir.up do
      PhotoAlbum.create_translation_table! :title => :string, :description => :text
    end

    dir.down do
      PhotoAlbum.drop_translation_table!
    end
  end
end
