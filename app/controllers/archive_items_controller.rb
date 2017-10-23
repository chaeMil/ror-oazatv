class ArchiveItemsController < ApplicationController
  before_action :set_archive_item, only: [:show, :edit, :update, :destroy, :create_archive_file]

  def index
    @archive_items = ArchiveItem.all
  end

  def show
    @archive_files = ArchiveFile.find_by(archive_item_id: @archive_item.id)
  end

  def new
    @archive_item = ArchiveItem.new
  end

  def edit
  end

  def create
    @archive_item = ArchiveItem.new(archive_item_params)
    if @archive_item.save
      redirect_to @archive_item, notice: 'Archive item was successfully created.'
    else
      render :new
    end
  end

  def update
    if @archive_item.update(archive_item_params)
      redirect_to @archive_item, notice: 'Archive item was successfully updated.'
    else
      render :edit
    end
  end

  def create_archive_file
    @archive_item = ArchiveItem.find(params[:id])
    @archive_file = ArchiveFile.new(archive_item_id: @archive_item.id)
    # if @archive_file.save
    #   redirect_to @archive_file
    # end
  end

  def destroy
    @archive_item.destroy
    redirect_to archive_items_url, notice: 'Archive item was successfully destroyed.'
  end

  private
  def set_archive_item
    @archive_item = ArchiveItem.find(params[:id])
  end

  def archive_item_params
    params.require(:archive_item).permit(:name, :description, :published, :hash_id, :date, :tags, :note)
  end
end
