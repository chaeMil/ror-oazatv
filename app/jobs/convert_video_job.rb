class ConvertVideoJob < ApplicationJob
  queue_as :video_conversion_queue

  def perform(*args)
    # Do something later
  end
end
