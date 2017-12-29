class AddStartedAtToVideoConvertProgress < ActiveRecord::Migration[5.1]
  def change
    add_column :video_convert_progresses, :started_at, :datetime
  end
end
