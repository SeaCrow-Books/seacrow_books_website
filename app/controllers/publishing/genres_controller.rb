module Publishing
  class GenresController < BasePublishingController
    before_action :authenticate_user!
      before_action :set_genre, only: %i[show edit update destroy]
    
      def index
        @page_title = "Genres"
        @genres = policy_scope(Genre)
        authorize @genres
      end
    
      def show
        @page_title = "#{@genre.name.titleize}"
        authorize @genre
      end
    
      def new
        @genre = Genre.new
        authorize @genre
      end
    
      def create
        @genre = Genre.new(genre_params)
        authorize @genre
        if @genre.save
          redirect_to @genre, notice: 'Genre was successfully created.'
        else
          render :new, status: :unprocessable_entity
        end
      end
    
      def edit
        authorize @genre
      end
    
      def update
        authorize @genre
        if @genre.update(genre_params)
          redirect_to @genre, notice: 'Genre was successfully updated.'
        else
          render :edit, status: :unprocessable_entity
        end
      end
    
      def destroy
        authorize @genre
        @genre.destroy
        redirect_to genres_url, notice: 'Genre was successfully destroyed.'
      end
    
      private
    
      def set_genre
        @genre = Genre.friendly.find(params[:id])
      end
    
      def genre_params
        params.require(:genre).permit(:name)
      end

  end
end