class Admin::PreachersController < Admin::AdminController
  before_action :set_preacher, only: [:show, :edit, :update, :destroy]

  def index
    @preachers = Preacher.page(params[:page]).per(30)
  end

  def new
    @preacher = Preacher.new
  end

  def create
    @preacher = Preacher.new(preacher_params)
    if @preacher.save!
      redirect_to admin_preacher_path(@preacher), notice: 'Preacher was successfully created.'
    else
      render :new
    end
  end

  def update
    if @preacher.update(preacher_params)
      redirect_to admin_preacher_path(@preacher), notice: 'Preacher was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @preacher.destroy
    redirect_to admin_preachers_path, notice: 'Preacher was successfully destroyed.'
  end

  private

  def set_preacher
    @preacher = Preacher.find(params[:id])
  end

  def preacher_params
    permitted = Preacher.globalize_attribute_names + [:description]
    params.require(:preacher).permit(*permitted)
  end
end