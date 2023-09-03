class PostsController < ApplicationController
    before_action :set_post, only: %i[show edit update destroy]
  
    def index
      @posts = policy_scope(Post)
      authorize @posts
    end
  
    def show
      authorize @post
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
      params.require(:post).permit(:title, :content, :slug, :published_at, :writer)
    end
  end
  