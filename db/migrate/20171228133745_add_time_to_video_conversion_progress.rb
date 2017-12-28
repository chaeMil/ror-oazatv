class AddTimeToVideoConversionProgress < ActiveRecord::Migration[5.1]
  def change
    add_column :video_convert_progresses, :finished_at, :datetime
  end
end
