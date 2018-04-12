module Admin
  class CategoriesController < AdminController
    before_action :set_category, only: [:show, :edit, :update, :destroy]

    def index
      @categories = Category.page(params[:page]).per(30)
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      if @category.save!
        redirect_to admin_category_path(@category), notice: 'Category was successfully created.'
      else
        render :new
      end
    end

    def update
      if @category.update(category_params)
        redirect_to admin_category_path(@category), notice: 'Category was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @category.destroy
      redirect_to admin_categories_path, notice: 'Category was successfully destroyed.'
    end

    private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      permitted = Category.globalize_attribute_names + [:title, :color]
      params.require(:category).permit(*permitted)
    end
  end
end