module Admin
  class PhotoAlbumsController < AdminController
    before_action :set_photo_album, only: [:show, :edit, :update, :destroy]

    def index
      @photo_albums = PhotoAlbum.all
    end

    def new
      @photo_album = PhotoAlbum.new
    end

    def create
      @photo_album = PhotoAlbum.new(photo_album_params)
      if @photo_album.save!
        redirect_to admin_photo_album_path(@photo_album), notice: 'Photo Album was successfully created'
      else
        render :new
      end
    end

    def update
      if @photo_album.update(photo_album_params)
        redirect_to admin_photo_album_path(@photo_album), notice: 'Photo Album was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @photo_album.destroy
      redirect_to admin_photo_albums_path, notice: 'Photo Album was successfully destroyed.'
    end

    private
    def set_photo_album
      @photo_album = PhotoAlbum.find(params[:id])
    end

    def photo_album_params
      params.require(:photo_album).permit(:title, :date, :days, :description, :published, :tags)
    end
  end
end