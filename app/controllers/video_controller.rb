class VideoController < ApplicationController
  before_action :set_archive_item, only: %i[watch]

  def watch

  end

  private
  def set_archive_item
    @video = ArchiveItem.where("hash_id = '#{params[:hash_id]}'").first
  end
end