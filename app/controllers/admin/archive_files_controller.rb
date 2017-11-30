module Admin
  class ArchiveFilesController < AdminController
    before_action :set_archive_item

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
      @archive_item = ArchiveItem.find(@archive_file.archive_item)
      @archive_file.destroy
      redirect_to @archive_item, notice: 'Archive file was successfully destroyed.'
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