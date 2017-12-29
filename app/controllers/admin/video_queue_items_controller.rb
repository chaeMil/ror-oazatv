module Admin
  class VideoQueueItemsController < AdminController


    def index
      queue_name = 'video_conversion_queue'

      @running_jobs = []
      workers = Sidekiq::Workers.new
      workers.each do |process_id, thread_id, job|
        if job['queue'] == queue_name
          arguments = job['payload']['args'][0]['arguments']
          video_convert_progress = VideoConvertProgress.find(arguments[2])
          running_conversion = {
              archive_file: ArchiveFile.find(arguments[1]),
              archive_item: ArchiveItem.find(arguments[0]),
              created_at: video_convert_progress[:created_at],
              finished_at: nil,
              progress: video_convert_progress
          }
          @running_jobs << running_conversion
        end
      end

      @queued_jobs = []
      queue = Sidekiq::Queue.new(queue_name)
      queue.each do |job|
        arguments = job['args'][0]['arguments']
        queued_job = {
            archive_file: ArchiveFile.find(arguments[1]),
            archive_item: ArchiveItem.find(arguments[0]),
            created_at: job.created_at,
            finished_at: nil,
            progress: VideoConvertProgress.find(arguments[2])
        }
        @queued_jobs << queued_job
      end

      finished = VideoConvertProgress.where(status: VideoConvertProgress.status.find_value(:done).value)
      @finished_jobs = []
      finished.each do |job|
        archive_file = ArchiveFile.find(job.archive_file_id)
        finished_job = {
            archive_file: archive_file,
            archive_item: archive_file.archive_item,
            created_at: job.created_at,
            finished_at: job.finished_at,
            progress: VideoConvertProgress.status.find_value(:done).value
        }
        @finished_jobs << finished_job
      end
    end

    def show

    end

    def destroy

    end

  end
end