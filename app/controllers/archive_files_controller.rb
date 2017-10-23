class ArchiveFilesController < ApplicationController
  before_action :set_archive_file, only: [:show, :edit, :update, :destroy]

  def show

  end

  def new
    @archive_item = ArchiveItem.find(params[:archive_item_id])
    @archive_file = ArchiveFile.new(archive_item_id: @archive_item.id)
  end

  def update
    if @archive_file.update(archive_file_params)
      redirect_to @archive_file, notice: 'Archive file was successfully updated.'
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
    params.require(:archive_file).permit(:filename, :type)
  end
end