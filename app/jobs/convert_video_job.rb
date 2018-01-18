class ConvertVideoJob < ApplicationJob
  queue_as :video_conversion_queue

  def perform(archive_item, archive_file, video_convert_progress, convert_profile)
    VideoConversionService.convert(archive_file, archive_item, video_convert_progress, convert_profile)
  end
end
