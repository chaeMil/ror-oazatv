class VideoConversionService
  class << self
    def convert(archive_item_id, archive_file_id, video_convert_progress_id, convert_profile_id)
      archive_file = ArchiveFile.find(archive_file_id)
      archive_item = ArchiveItem.find(archive_item_id)
      convert_profile = VideoConvertProfile.find(convert_profile_id)
      video_convert_progress = VideoConvertProgress.find(video_convert_progress_id)

      if archive_file.video?
        video = FFMPEG::Movie.new(archive_file.file.path)

        new_video_filename = "#{SecureRandom.hex(6)}.#{convert_profile['extension']}"
        new_archive_file = create_new_archive_file(archive_file, archive_item)

        update_filename = "UPDATE archive_files SET file='#{new_video_filename}' WHERE id = #{new_archive_file.id}"
        ActiveRecord::Base.connection.execute(update_filename)

        video_convert_progress.update(archive_file_id: new_archive_file.id, started_at: DateTime.now)

        transcode(archive_file, new_video_filename, video, convert_profile, video_convert_progress)
      else
        throw 'File is not a video! Cannot convert'
      end
    end

    private
    def transcode(archive_file, new_video_filename, video, convert_profile, video_convert_progress)
      options = create_transcode_options(convert_profile)
      begin
        video.transcode("#{File.dirname(archive_file.file.path)}/#{new_video_filename}", options) do |progress|
          on_transcode_progress(progress, video_convert_progress)
          if progress == 1.0
            on_transcode_finish(video_convert_progress)
          end
        end
      rescue StandardError => error
        on_transcode_error(error, video_convert_progress)
      end
    end

    def on_transcode_progress(progress, video_convert_progress)
      video_convert_progress.update(progress: progress,
                                    status: VideoConvertProgress.status.find_value(:processing).value)
    end

    def on_transcode_finish(video_convert_progress)
      video_convert_progress.update(finished_at: DateTime.now,
                                    status: VideoConvertProgress.status.find_value(:done).value)
    end

    def on_transcode_error(error, video_convert_progress)
      p '=================error======================='
      p error
      p '=================error======================='
      video_convert_progress.update(error: error,
                                    status: VideoConvertProgress.status.find_value(:error).value)
    end

    def create_new_archive_file(archive_file, archive_item)
      new_archive_file = ArchiveFile.new(archive_item: archive_item,
                                         language_id: archive_file['language_id'],
                                         file_type: archive_file['file_type'])
      new_archive_file.save
      new_archive_file
    end

    def create_transcode_options(convert_profile)
      options = {
          video_codec: convert_profile['video_codec'],
          frame_rate: convert_profile['frame_rate'],
          resolution: convert_profile['resolution'],
          video_bitrate: convert_profile['video_bitrate'],
          audio_codec: convert_profile['audio_codec'],
          audio_bitrate: convert_profile['audio_bitrate'],
          audio_sample_rate: convert_profile['audio_sample_rate'],
          audio_channels: convert_profile['audio_channels'],
          threads: convert_profile['threads']
      }
    end
  end
end