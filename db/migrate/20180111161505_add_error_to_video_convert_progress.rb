class AddErrorToVideoConvertProgress < ActiveRecord::Migration[5.1]
  def change
    add_column :video_convert_progresses, :error, :text
  end
end
