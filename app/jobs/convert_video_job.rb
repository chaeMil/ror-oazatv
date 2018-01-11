class ConvertVideoJob < ApplicationJob
  queue_as :video_conversion_queue

  def perform(archive_item_id, archive_file_id, video_convert_progress_id, convert_profile_id)
    archive_file = ArchiveFile.find(archive_file_id)
    archive_file.convert(video_convert_progress_id, convert_profile_id)
  end
end
