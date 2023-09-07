class PostsController < ApplicationController
    before_action :set_post, only: %i[show edit update destroy]
  
    def index
      @posts = Post.all
      @published_posts = @posts.published
      authorize @posts
      @page_title = 'xxx Blog' 
      @page_description = 'Articles all about erotic fiction.'
    end
  
    def show
      authorize @post
      @page_title = @post.meta_title 
      @page_description = @post.meta_description
    end
  
    def new
      @post = Post.new
      authorize @post
    end
  
    def create
      @post = Post.new(post_params)
      authorize @post
      if @post.save
        redirect_to @post, notice: 'Post was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
      authorize @post
    end
  
    def update
      authorize @post
      if @post.update(post_params)
        redirect_to @post, notice: 'Post was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      authorize @post
      @post.destroy
      redirect_to posts_url, notice: 'Post was successfully destroyed.'
    end
  
    private
  
    def set_post
      @post = Post.friendly.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:title, :main_image, :meta_title, :meta_description, :published, :published_at, :custom_url, :content, :slug, :writer, category_ids: [])
    end

  end
  