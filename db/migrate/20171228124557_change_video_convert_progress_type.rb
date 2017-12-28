class ChangeVideoConvertProgressType < ActiveRecord::Migration[5.1]
  def change
    change_column :video_convert_progresses, :progress, :float
  end
end
