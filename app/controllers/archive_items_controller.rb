class ArchiveItemsController < ApplicationController
  before_action :set_archive_item, only: [:show, :edit, :update, :destroy]

  # GET /archive_items
  # GET /archive_items.json
  def index
    @archive_items = ArchiveItem.all
  end

  # GET /archive_items/1
  # GET /archive_items/1.json
  def show
  end

  # GET /archive_items/new
  def new
    @archive_item = ArchiveItem.new
  end

  # GET /archive_items/1/edit
  def edit
  end

  # POST /archive_items
  # POST /archive_items.json
  def create
    @archive_item = ArchiveItem.new(archive_item_params)

    respond_to do |format|
      if @archive_item.save
        format.html { redirect_to @archive_item, notice: 'Archive item was successfully created.' }
        format.json { render :show, status: :created, location: @archive_item }
      else
        format.html { render :new }
        format.json { render json: @archive_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /archive_items/1
  # PATCH/PUT /archive_items/1.json
  def update
    respond_to do |format|
      if @archive_item.update(archive_item_params)
        format.html { redirect_to @archive_item, notice: 'Archive item was successfully updated.' }
        format.json { render :show, status: :ok, location: @archive_item }
      else
        format.html { render :edit }
        format.json { render json: @archive_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /archive_items/1
  # DELETE /archive_items/1.json
  def destroy
    @archive_item.destroy
    respond_to do |format|
      format.html { redirect_to archive_items_url, notice: 'Archive item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_archive_item
      @archive_item = ArchiveItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def archive_item_params
      params.require(:archive_item).permit(:name, :description, :published, :hash_id, :date, :tags, :note)
    end
end
