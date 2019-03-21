class Api::V3::PreachersController < ApplicationController

  #GET /preachers
  def index
    page = params[:page] || 1
    @page = page
    @preachers = Preacher.includes(:translations)
                     .page(page)
                     .per(15)
    render json: @preachers.to_json(include: [:translations])
  end

  # GET /preachers/:id
  def show
    @preacher = Preacher.includes(:translations)
                    .where(id: params[:id])
                    .first
    if @preacher != nil
      render json: @preacher.to_json(include: [:translations])
    else
      render json: {
          error: "No such preacher; check the id",
          status: 404
      }, status: 404
    end
  end
end