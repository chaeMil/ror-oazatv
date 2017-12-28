class RemoveArchiveFileReferenceFromVideoConvertProgress < ActiveRecord::Migration[5.1]
  def change
    remove_reference(:video_convert_progresses, :archive_file, index: true)
    add_column :video_convert_progresses, :archive_file_id, :integer
  end
end
