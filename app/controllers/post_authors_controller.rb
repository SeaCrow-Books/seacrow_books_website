
    class PostAuthorsController < ApplicationController
      before_action :set_post_author, only: [:show, :edit, :update, :destroy]
      layout :set_layout
  
      def index
        @post_authors = PostAuthor.all
      end
  
      def show
        @page_title = @post_author.name.titleize
        @published_post_author_posts = @post_author.posts.published
      end
  
      def new
        @post_author = PostAuthor.new
      end
  
      def create
        @post_author = PostAuthor.new(post_author_params)
        if @post_author.save
          redirect_to blog_post_author_path(@post_author), notice: 'Post author was successfully created.'
        else
          render :new
        end
      end
  
      def edit
      end
  
      def update
        if @post_author.update(post_author_params)
          redirect_to post_author_path(@post_author), notice: 'Post author was successfully updated.'
        else
          render :edit
        end
      end
  
      def destroy
        @post_author.destroy
        redirect_to blog_post_authors_url, notice: 'Post author was successfully destroyed.'
      end
  
      private
  
      def set_post_author
        @post_author = PostAuthor.friendly.find(params[:id])
      end
  
      def post_author_params
        params.require(:author).permit(:name, :description, :image)
      end

      def set_layout
        case action_name
        when  'new', 'edit', 'index'
            'page_templates/small_page'
        when 'show'
            'page_templates/medium_page'
        when
            'page_templates/large_page'
        else
          'application'
        end
      end

    end

  