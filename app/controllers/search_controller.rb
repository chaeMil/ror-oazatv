class SearchController < ApplicationController
  before_action :set_query

  def index
    if @query.present?
      @videos = ArchiveItem
                    .by_title(@query)
                    .includes(:archive_files, :translations)
                    .where(published: true)
    end
  end

  private

  def set_query
    @query = query_params[:q] || nil
  end

  def query_params
    params.permit(:q)
  end
end