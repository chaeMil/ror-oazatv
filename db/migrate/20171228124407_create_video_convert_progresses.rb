class CreateVideoConvertProgresses < ActiveRecord::Migration[5.1]
  def change
    create_table :video_convert_progresses do |t|
      t.integer :progress
      t.integer :status

      t.timestamps
    end
  end
end
