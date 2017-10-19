class CreateArchiveItems < ActiveRecord::Migration[5.1]
  def change
    create_table :archive_items do |t|
      t.string :name
      t.text :description
      t.boolean :published
      t.string :hash
      t.date :date
      t.text :tags
      t.text :note

      t.timestamps
    end
  end
end
