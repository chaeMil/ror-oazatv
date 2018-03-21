class DeletePhotoAlbums < ActiveRecord::Migration[5.1]
  def up
    drop_table :photos
    drop_table :photo_albums
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
