class ArchiveFilesController < ApplicationController
  before_action :set_archive_file, only: [:show, :edit, :update, :destroy]

  def show

  end

  def new
    @archive_item = ArchiveItem.find(params[:archive_item_id])
    @archive_file = ArchiveFile.new(archive_item_id: @archive_item.id)
  end

  def create
    archive_item = ArchiveItem.find(params[:archive_item_id])
    archive_file = ArchiveFile.new(archive_file_params)
    archive_file.archive_item = archive_item
    archive_file.file = params[:file]
    if archive_file.save!
      redirect_to archive_item_path(archive_file.archive_item_id),
                  notice: 'Archive item was successfully created.'
    else
      render :new
    end
  end

  def update
    if @archive_file.update(archive_file_params)
      redirect_to archive_item_path(@archive_file.archive_item_id),
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
  def set_archive_file
    @archive_item = ArchiveItem.find(params[:id])
  end

  def archive_file_params
    params.require(:archive_file).permit(:filename, :file, :file_type, :archive_item_id)
  end
end