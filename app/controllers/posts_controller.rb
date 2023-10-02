class PostsController < ApplicationController
    before_action :set_post, only: %i[show edit update destroy]
  
    def index
      @posts = Post.all
      @published_posts = @posts.published
      @all_featured_posts = @published_posts
      @featured_posts = @all_featured_posts.order(created_at: :desc).offset(1).limit(3)
      @featured_post = @all_featured_posts.first || Post.published.order(created_at: :desc).first
    
      if @featured_post
        @latest_posts = @published_posts.where.not(id: @featured_post.id).order(created_at: :desc).limit(10)
      else
        @latest_posts = @published_posts.order(created_at: :desc).limit(10)
      end
    
      authorize @posts
      @page_title = 'Articles'
      @page_description = 'Articles all about erotic fiction.'
    end
    
    def show
      authorize @post
      @page_title = @post.meta_title.titleize 
      @page_description = @post.meta_description  
      
    end
  
    def new
      @post = Post.new
      @page_title = "New Post"
      @personas = Persona.for_posts
      authorize @post
    end
  
    def create
      @post = Post.new(post_params)
      @personas = Persona.for_posts
      authorize @post
      if @post.save
        redirect_to @post, notice: 'Post was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
      authorize @post
      @personas = Persona.for_posts
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
      redirect_to dashboard_path, notice: 'Post was successfully destroyed.'
    end
  
    private
  
    def set_post
      @post = Post.friendly.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:title, :main_image, :main_image_alt_text, :meta_title, :description, :meta_description, :published, :published_at, :custom_url, :content, :slug, :writer, :persona_id, category_ids: [])
    end

  end
  