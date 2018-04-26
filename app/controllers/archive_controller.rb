class ArchiveController < ApplicationController
  def page
    @videos = ArchiveItem
                  .where(published: true)
                  .order(date: :desc)
                  .page(params[:page]).per(30)
  end
end