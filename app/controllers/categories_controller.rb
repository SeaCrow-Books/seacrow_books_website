class CategoriesController < ApplicationController
    before_action :set_category, only: %i[show edit update destroy]
  
    def index
      @page_title = "Categories"
      @categories = policy_scope(Category)
      authorize @categories
    end
  
    def show
      @page_title = "#{@category.name.titleize}"
      @category_posts = @category.posts
      @published_category_posts = @category_posts.published
      authorize @category
    end
  
    def new
      @category = Category.new
      authorize @category
    end
  
    def create
      @category = Category.new(category_params)
      authorize @category
      if @category.save
        redirect_to @category, notice: 'Category was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
      authorize @category
    end
  
    def update
      authorize @category
      if @category.update(category_params)
        redirect_to @category, notice: 'Category was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      authorize @category
      @category.destroy
      redirect_to categories_url, notice: 'Category was successfully destroyed.'
    end
  
    private
  
    def set_category
      @category = Category.friendly.find(params[:id]) # This assumes you're using the 'friendly_id' gem for slug management
    end
  
    def category_params
      params.require(:category).permit(:name, :description)
    end
  end
  