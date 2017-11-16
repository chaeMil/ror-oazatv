class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.references :photo_album, foreign_key: true
      t.text :description
      t.integer :order

      t.timestamps
    end
  end
end
