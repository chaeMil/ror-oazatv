module Admin
  class VideoQueueItemsController < AdminController


    def index
      queue_name = 'video_conversion_queue'

      get_running_jobs(queue_name)
      get_queued_jobs(queue_name)
      get_finished_jobs
      get_jobs_with_error
    end

    def show

    end

    def destroy

    end

    private
    def get_jobs_with_error
      with_error = VideoConvertProgress.where(status: VideoConvertProgress.status.find_value(:error).value)
      @jobs_with_error = []
      with_error.each do |job|
        archive_file = ArchiveFile.find(job.archive_file_id) rescue nil
        if archive_file != nil
          job_with_error = {
              archive_file: archive_file,
              archive_item: archive_file.archive_item,
              created_at: job['created_at'],
              finished_at: job['finished_at'],
              started_at: job['started_at'],
              status: job['status'],
              error: job['error'],
              progress: VideoConvertProgress.status.find_value(:error).value
          }
          @jobs_with_error << job_with_error
        end
      end
    end

    def get_finished_jobs
      finished = VideoConvertProgress.where(status: VideoConvertProgress.status.find_value(:done).value)
      @finished_jobs = []
      finished.each do |job|
        archive_file = ArchiveFile.find(job.archive_file_id) rescue nil
        if archive_file != nil
          finished_job = {
              archive_file: archive_file,
              archive_item: archive_file.archive_item,
              created_at: job['created_at'],
              finished_at: job['finished_at'],
              started_at: job['started_at'],
              status: job['status'],
              error: job['error'],
              progress: VideoConvertProgress.status.find_value(:done).value
          }
          @finished_jobs << finished_job
        end
      end
    end

    def get_queued_jobs(queue_name)
      @queued_jobs = []
      queue = Sidekiq::Queue.new(queue_name)
      queue.each do |job|
        arguments = job['args'][0]['arguments']
        queued_job = {
            archive_file: ArchiveFile.find(arguments[1]),
            archive_item: ArchiveItem.find(arguments[0]),
            created_at: job['created_at'],
            finished_at: nil,
            started_at: nil,
            status: job['status'],
            error: job['error'],
            progress: VideoConvertProgress.find(arguments[2])
        }
        @queued_jobs << queued_job
      end
    end

    def get_running_jobs(queue_name)
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
              started_at: video_convert_progress[:started_at],
              progress: video_convert_progress,
              status: job['status'],
              error: job['error']
          }
          @running_jobs << running_conversion
        end
      end
    end

  end
end