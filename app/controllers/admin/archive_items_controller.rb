# frozen_string_literal: true
module Admin
  class ArchiveItemsController < AdminController
    before_action :set_archive_item, only: %i[show edit update destroy]

    def index
      @archive_items = ArchiveItem.order(date: :desc).page(params[:page]).per(30)
    end

    def new
      @categories = Category.all
      @archive_item = ArchiveItem.new
    end

    def edit
      @categories = Category.all
    end

    def show
      @archive_files = ArchiveFile.where(archive_item_id: @archive_item.id)
      @convert_profiles = VideoConvertProfile.all
    end

    def create
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
      permitted = ArchiveItem.globalize_attribute_names + [:published, :description, :hash_id, :date, :tags, :note, :categories]
      params.require(:archive_item).permit(*permitted)
      new_params = params[:archive_item].as_json
      category_ids = params[:archive_item][:categories].reject {|c| c.empty?}
      categories_db = Category.find(category_ids)
      new_params['categories'] = categories_db
      new_params.to_hash
    end
  end
end