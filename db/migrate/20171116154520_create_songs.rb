class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.text :title
      t.text :tag
      t.text :author
      t.text :text

      t.timestamps
    end
  end
end
