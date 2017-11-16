class AddImageToPreachers < ActiveRecord::Migration[5.1]
  def change
    add_column :preachers, :image, :string
  end
end
