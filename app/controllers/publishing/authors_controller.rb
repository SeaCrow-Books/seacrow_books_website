module Publishing
  class AuthorsController < BasePublishingController
    before_action :authenticate_user!, only: %i[index edit update destroy]
    before_action :set_author, only: %i[show edit update destroy]

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
      redirect_to publishing_authors_path, notice: 'Author was successfully destroyed.'
    end

    private

    def set_author
      @author = Author.friendly.find(params[:id])
    end

    def author_params
      params.require(:publishing_author).permit(:name)
    end
  end
end