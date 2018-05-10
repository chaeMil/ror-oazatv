class CreateVideoWatches < ActiveRecord::Migration[5.1]
  def change
    create_table :video_watches do |t|
      t.string :video_hash_id
      t.timestamps
    end
  end
end
