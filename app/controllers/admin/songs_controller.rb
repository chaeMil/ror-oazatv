module Admin
  class SongsController < AdminController
    before_action :set_song, only: [:show, :edit, :update, :destroy]
    def index
      @songs = Song.all
    end

    def new
      @song = Song.new
    end

    def create
      @song = Song.new(song_params)
      if @song.save!
        redirect_to admin_song_path(@song), notice: 'Song was created successfully.'
      else
        render :new
      end
    end

    def update
      if @song.update(song_params)
        redirect_to admin_song_path(@song), notice: 'Song was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @song.destroy
      redirect_to admin_songs_path, notice: 'Song was successfully destroyed.'
    end

    private
    def set_song
      @song = Song.find(params[:id])
    end

    def song_params
      params.require(:song).permit(:title, :author, :tag, :text)
    end
  end
end