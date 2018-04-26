class ArchiveController < ApplicationController
  def index
    page = params[:page] || 1
    @videos = ArchiveItem
                  .where(published: true)
                  .order(date: :desc)
                  .page(page).per(12)
  end
end