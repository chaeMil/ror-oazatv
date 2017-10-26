class ChangeVideoTypeToInteger < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      change_table :archive_files do |t|
        dir.up   { t.change :type, :integer }
        dir.down { t.change :type, :string }
      end
    end
  end
end
