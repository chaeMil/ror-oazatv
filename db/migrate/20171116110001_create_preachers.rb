class CreatePreachers < ActiveRecord::Migration[5.1]
  def change
    create_table :preachers do |t|
      t.text :title
      t.text :tags
      t.text :description

      t.timestamps
    end
  end
end
