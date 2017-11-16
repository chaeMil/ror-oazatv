class RenameLanguageNameToTitle < ActiveRecord::Migration[5.1]
  def change
    change_table :languages do |t|
      t.rename :name, :title
    end
  end
end
