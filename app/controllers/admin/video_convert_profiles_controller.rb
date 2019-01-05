class Admin::VideoConvertProfilesController < Admin::AdminController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def index
    @profiles = VideoConvertProfile.all
  end

  def new
    @profile = VideoConvertProfile.new
  end

  def create
    @profile = VideoConvertProfile.new(profile_params)
    if @profile.save!
      redirect_to admin_video_convert_profile_path(@profile), notice: 'Video convert profile created successfully.'
    else
      render :new
    end
  end

  def update
    if @profile.update(profile_params)
      redirect_to admin_video_convert_profile_path(@profile), notice: 'Video convert profile was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @profile.destroy
    redirect_to admin_video_convert_profiles_path, notice: 'Vdieo convert profile was successfully destroyed.'
  end

  private

  def set_profile
    @profile = VideoConvertProfile.find(params[:id])
  end

  def profile_params
    params.require(:video_convert_profile).permit(:title, :video_codec, :video_bitrate, :threads, :resolution, :frame_rate, :custom, :audio_sample_rate, :audio_codec, :audio_channels, :audio_bitrate, :extension)
  end
end
