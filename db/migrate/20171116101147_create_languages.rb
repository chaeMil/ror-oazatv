class CreateLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :languages do |t|
      t.text :name
      t.text :locale

      t.timestamps
    end
  end
end
