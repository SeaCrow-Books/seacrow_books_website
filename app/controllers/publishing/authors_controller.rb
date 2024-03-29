module Publishing
  class AuthorsController < ApplicationController
    before_action :authenticate_user!, only: %i[index edit update destroy]
    before_action :set_author, only: %i[show edit update destroy]
    layout :set_layout

    def index
      @page_title = "Authors"
      @authors = policy_scope(Author)
      authorize @authors
    end

    def show
      @page_title = "#{@author.name.titleize}"
      authorize @author
    end

    def new
      @author = Author.new
      authorize @author
    end

    def create
      @author = Author.new(author_params)
      authorize @author
      if @author.save
        redirect_to @author, notice: 'Author was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      authorize @author
    end

    def update
      authorize @author
      if @author.update(author_params)
        redirect_to @author, notice: 'Author was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize @author
      @author.destroy
      redirect_to dashboard_pathh, notice: 'Author was successfully destroyed.'
    end

    private

    def set_author
      @author = Author.friendly.find(params[:id])
    end

    def author_params
      params.require(:publishing_author).permit(:name)
    end

    def set_layout
      case action_name
      when 
        'page_templates/tiny_page'
      when 'new', 'edit'
        'page_templates/small_page'
      when 'show'
        'page_templates/medium_page'
      when 'index', 'show'
        'page_templates/large_page'
      else
        'application'
      end
    end

  end
end