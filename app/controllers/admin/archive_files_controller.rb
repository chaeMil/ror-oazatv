module Admin
  class ArchiveFilesController < AdminController
    before_action :set_archive_item, except: [:get_chunk, :post_chunk]

    def show
      @languages = Language.all
      @archive_file = ArchiveFile.find(params[:id])
    end

    def new
      @languages = Language.all
      @archive_file = ArchiveFile.new(archive_item_id: @archive_item.id)
    end

    def edit
      @languages = Language.all
      @archive_file = ArchiveFile.find(params[:id])
    end

    def create
      archive_file = ArchiveFile.new(archive_file_params)
      archive_file.archive_item = @archive_item

      if archive_file.save!
        redirect_to admin_archive_item_path(archive_file.archive_item_id),
                    notice: 'Archive item was successfully created.'
      else
        render :new
      end
    end

    def update
      @archive_file = ArchiveFile.find(params[:id])
      if @archive_file.update(archive_file_params)
        redirect_to admin_archive_item_archive_file_path(archive_item_id: @archive_item.id, id: @archive_file.id),
                    notice: 'Archive file was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @archive_file = ArchiveFile.find(params[:id])
      @archive_file.destroy
      redirect_to admin_archive_item_path(@archive_item), notice: 'Archive file was successfully destroyed.'
    end

    def convert
      archive_file = ArchiveFile.find(params[:id])
      convert_profile = VideoConvertProfile.find(params[:convert_profile_id])
      convert_progress = VideoConvertProgress.new
      convert_progress.save
      ConvertVideoJob.perform_later(@archive_item.id, archive_file.id, convert_progress.id, convert_profile.id)
      redirect_to admin_archive_item_path(@archive_item)
    end

    # GET /chunk
    def get_chunk
      # chunk folder path based on the parameters
      dir = "/tmp/#{params[:resumableIdentifier]}"
      # chunk path based on the parameters
      chunk = "#{dir}/#{params[:resumableFilename]}.part#{params[:resumableChunkNumber]}"

      if File.exist?(chunk)
        # Let resumable.js know this chunk already exists
        render body: false, status: 200
      else
        # Let resumable.js know this chunk doesnt exists and needs to be uploaded
        render body: false, status: 404
      end

    end

    # POST /chunk
    def post_chunk

      # chunk folder path based on the parameters
      dir = "/tmp/#{params[:resumableIdentifier]}"
      # chunk path based on the parameters
      chunk = "#{dir}/#{params[:resumableFilename]}.part#{params[:resumableChunkNumber]}"

      # Create chunks directory when not present on system
      if !File.directory?(dir)
        FileUtils.mkdir(dir, :mode => 0700)
      elsif params[:resumableChunkNumber].to_i == 1
        FileUtils.rm_rf Dir.glob("#{dir}/*")
      end

      # Move the uploaded chunk to the directory
      FileUtils.mv params[:file].tempfile, chunk

      # Concatenate all the partial files into the original file

      currentSize = params[:resumableChunkNumber].to_i * params[:resumableChunkSize].to_i
      filesize = params[:resumableTotalSize].to_i

      # When all chunks are uploaded
      if (currentSize + params[:resumableCurrentChunkSize].to_i) >= filesize

        # Create a target file
        File.open("#{dir}/#{params[:resumableFilename]}", "a") do |target|
          # Loop trough the chunks
          for i in 1..params[:resumableChunkNumber].to_i
            # Select the chunk
            chunk = File.open("#{dir}/#{params[:resumableFilename]}.part#{i}", 'r').read

            # Write chunk into target file
            chunk.each_line do |line|
              target << line
            end

            # Deleting chunk
            FileUtils.rm "#{dir}/#{params[:resumableFilename]}.part#{i}", :force => true
          end
        end
        # You can use the file now
        puts "File saved to #{dir}/#{params[:resumableFilename]}"
        uploaded_file = File.open("#{dir}/#{params[:resumableFilename]}")
        file_type = params[:file_type]
        language_id = params[:language]
        archive_item_id = params[:archive_item_id]
        p language_id
        p archive_item_id
        language = Language.find(language_id)
        archive_item = ArchiveItem.find(archive_item_id)
        archive_file = ArchiveFile.new(file_type: file_type, language_id: language, archive_item: archive_item)
        archive_file.file = uploaded_file
        puts archive_file.save!
      end

      render body: false, status: 200
    end

    private
    def set_archive_item
      @archive_item = ArchiveItem.find(params[:archive_item_id])
    end

    def archive_file_params
      params.require(:archive_file).permit(:filename, :file, :file_type, :archive_item_id, :language_id)
    end
  end
end