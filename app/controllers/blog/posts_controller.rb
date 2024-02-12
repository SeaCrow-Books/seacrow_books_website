module Blog
  class PostsController < ApplicationController
    before_action :authenticate_user!, only: %i[edit update destroy]
    before_action :set_post, only: %i[show edit update destroy]
    layout :set_layout
  
    def index
      @posts = Post.all
      @published_posts = Post.published

      @featured_post = @published_posts.order(created_at: :asc).first
      @featured_posts = @published_posts.order(created_at: :desc).offset(1).limit(3)
      @latest_posts = Post.latest_published
  
      @featured_book = Publishing::Book.order(publication_date: :asc).first
      @recent_books = Publishing::Book.order(publication_date: :desc).limit(3)

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
      @categories = Blog::Category.where(parent_id: nil)
      authorize @post
    end
  
    def create
      @post = Post.new(post_params)
      authorize @post
      if @post.save
        redirect_to edit_blog_post_path(@post), notice: 'Post was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
      authorize @post
      @categories = Blog::Category.where(parent_id: nil)
      @page_title = "Editing" + " " + @post.meta_title.titleize 
    end
  
    def update
      authorize @post
    
      if params[:blog_post][:main_image].present?
        @post.main_image.attach(params[:blog_post][:main_image])
      end
    
      # Other update logic
      if @post.update(post_params)
        redirect_to edit_blog_post_path(@post), notice: 'Post was successfully updated.'
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
      params.require(:blog_post).permit(:title, :main_image, :main_image_alt_text, :meta_title, :description, :meta_description, :published, :published_at, :custom_url, :content, :slug, :writer, category_ids: [])
    end

    def set_layout
      case action_name
      when 
        'page_templates/tiny_page'
      when 
        'page_templates/small_page'
      when 'show', 'new', 'edit'
        'page_templates/medium_page'
      when 'index'
        'page_templates/large_page'
      else
        'application'
      end
    end

  end
end  