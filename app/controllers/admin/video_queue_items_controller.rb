module Admin
  class VideoQueueItemsController < AdminController


    def index
      queue_name = 'video_conversion_queue'
      @running_conversions = []
      workers = Sidekiq::Workers.new
      workers.each do |process_id, thread_id, work|
        if work['queue'] == queue_name
          arguments = work['payload']['args'][0]['arguments']
          running_conversion = {
              archive_file: ArchiveFile.find(arguments[1]),
              archive_item: ArchiveItem.find(arguments[0])
          }
          @running_conversions << running_conversion
        end
      end
      @queue = Sidekiq::Queue.new(queue_name)
    end

    def show

    end

    def destroy

    end

  end
end