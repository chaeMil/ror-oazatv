class CreatePhotoAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :photo_albums do |t|
      t.boolean :published
      t.text :title
      t.text :description
      t.text :tags
      t.date :date
      t.integer :days

      t.timestamps
    end
  end
end
