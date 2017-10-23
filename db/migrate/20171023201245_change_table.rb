class ChangeTable < ActiveRecord::Migration[5.1]
  def change
    change_table :archive_items do |t|
      t.rename :name, :title
    end
  end
end
