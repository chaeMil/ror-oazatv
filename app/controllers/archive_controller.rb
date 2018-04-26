class ArchiveController < ApplicationController
  def index
    page = params[:page] || 1
    @page = page
    @videos = ArchiveItem
                  .where(published: true)
                  .order(date: :desc)
                  .page(page).per(12)
  end

  def category
    page = params[:page] || 1
    category = Category.find(params[:category])
    if category.present?
      @videos = ArchiveItem.by_category(category)
                    .where(published: true)
                    .page(page).per(12)
      @category = category
    end
  end
end