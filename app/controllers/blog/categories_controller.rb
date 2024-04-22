module Blog
  class CategoriesController < ApplicationController
    before_action :authenticate_user!, only: %i[index edit update destroy child_categories]
    before_action :set_category, only: %i[show edit update destroy child_categories]
    layout :set_layout

    def index
      @categories = Category.all
      authorize @categories
    end

    def show
      @page_title = @category.name.titleize
      @category_posts = @category.posts
      @essential_guides = @category_posts.essential_guides
      @regular_posts = @category_posts.regular_posts
      authorize @category

      # Use the CategoryHierarchyService to get ancestors and descendants
      hierarchy_service = Blog::CategoryHierarchyService.new(@category)
      @ancestors = hierarchy_service.ancestors
      @descendants = hierarchy_service.descendants
    end

    def new
      @category = Blog::Category.new
      authorize @category
      @page_title = 'New Category'
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
      @page_title = 'Edit Category'
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
      redirect_to dashboard_path, notice: 'Category was successfully destroyed.'
    end

    def child_categories
      @child_categories = @category.child_categories
      respond_to do |format|
        format.html
        format.json { render json: @child_categories }
      end
    end

    private

    def set_category
      @category = Category.friendly.find(params[:id])
    end

    def category_params
      params.require(:blog_category).permit(:name, :description, :parent_id)
    end

    def set_layout
      case action_name
      when 'new', 'edit'
        'page_templates/small_page'
      when 'show'
        'page_templates/medium_page'
      when 'index'
        'page_templates/large_page'
      else
        'application'
      end
    end
  end
end
