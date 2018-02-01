module Admin
  class ArchiveItemsController < AdminController
    before_action :set_archive_item, only: [:show, :edit, :update, :destroy]

    def index
      @archive_items = ArchiveItem.page params[:page]
    end

    def new
      @archive_item = ArchiveItem.new
    end

    def show
      @archive_files = ArchiveFile.where(archive_item_id: @archive_item.id)
      @convert_profiles = VideoConvertProfile.all
    end

    def create
      p archive_item_params
      @archive_item = ArchiveItem.new(archive_item_params)
      @archive_item.hash_id = SecureRandom.hex(4)
      if @archive_item.save
        redirect_to admin_archive_item_path(@archive_item), notice: 'Archive item was successfully created.'
      else
        render :new
      end
    end

    def update
      if @archive_item.update(archive_item_params)
        redirect_to admin_archive_item_path(@archive_item), notice: 'Archive item was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @archive_item.destroy
      redirect_to admin_archive_items_url, notice: 'Archive item was successfully destroyed.'
    end

    private
    def set_archive_item
      @archive_item = ArchiveItem.find(params[:id])
    end

    def archive_item_params
      permitted = ArchiveItem.globalize_attribute_names + [:published, :hash_id, :date, :tags, :note]
      params.require(:archive_item).permit(*permitted)
    end
  end
end