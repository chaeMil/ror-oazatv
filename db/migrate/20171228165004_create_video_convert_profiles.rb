class CreateVideoConvertProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :video_convert_profiles do |t|
      t.text :title
      t.text :video_codec
      t.float :frame_rate
      t.text :resolution
      t.integer :video_bitrate
      t.text :audio_codec
      t.integer :audio_bitrate
      t.integer :audio_sample_rate
      t.integer :audio_channels
      t.integer :threads
      t.text :custom

      t.timestamps
    end
  end
end
