class DeleteAssets < ActiveRecord::Migration[5.1]
  def up
    drop_table :assets
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
