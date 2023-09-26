class PostsController < ApplicationController
    before_action :set_post, only: %i[show edit update destroy]
  
    def index
      @posts = Post.all
      @published_posts = @posts.published
      @all_featured_posts = Post.most_viewed
      @featured_posts = @all_featured_posts.order(created_at: :desc).offset(1).limit(3)
      @featured_post = @all_featured_posts.first || Post.order(created_at: :desc).first
      @latest_posts = @published_posts.order(created_at: :desc).limit(10)
      authorize @posts
      @page_title = 'Articles' 
      @page_description = 'Articles all about erotic fiction.'
    end
  
    def show
      authorize @post
      @page_title = @post.meta_title.titleize 
      @page_description = @post.meta_description

      # Tracking the view
      if current_visit
        AhoyEventTracker.new(@post, current_visit.visit_token).track_event
      end      

    end
  
    def new
      @post = Post.new
      @page_title = "New Post"
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
      @page_title = "Editing" + " " + @post.meta_title.titleize 
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
      params.require(:post).permit(:title, :main_image, :main_image_alt_text, :meta_title, :description, :meta_description, :published, :published_at, :custom_url, :content, :slug, :writer, category_ids: [])
    end

  end
  