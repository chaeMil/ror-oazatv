class DeleteSongs < ActiveRecord::Migration[5.1]
  def up
    drop_table :songs
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
