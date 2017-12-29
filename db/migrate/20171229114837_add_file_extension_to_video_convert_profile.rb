class AddFileExtensionToVideoConvertProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :video_convert_profiles, :extension, :text
  end
end
