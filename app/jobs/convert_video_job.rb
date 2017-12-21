class ConvertVideoJob < ApplicationJob
  queue_as :video_conversion_queue

  def perform(archive_item, archive_file)
    archive_file.convert
  end
end
