class AddUsedAsConversionSourceToArchiveFile < ActiveRecord::Migration[5.1]
  def change
    add_column :archive_files, :used_as_conversion_source, :boolean
  end
end
