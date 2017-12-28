class AddMetadataToVideoConversionProgress < ActiveRecord::Migration[5.1]
  def change
    add_reference :video_convert_progresses, :archive_file, foreign_key: true
  end
end
