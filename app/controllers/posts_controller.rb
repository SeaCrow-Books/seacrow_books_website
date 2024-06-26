
  class PostsController < ApplicationController
    before_action :authenticate_user!, only: %i[edit update destroy]
    before_action :set_post, only: %i[show edit update destroy]
    layout :set_layout
  
    def index
      @posts = Post.all

      @ultimate_guides = @posts.ultimate_guides
      @essential_guides = @posts.essential_guides
      @regular_posts = @posts.regular_posts.limit(18)

      authorize @posts
      @page_title = 'SeaCrow Blog'
      @page_description = 'Articles from SeaCrow Books about romance and erotic fiction.'
    end
    
    def show
      authorize @post
      @page_title = @post.meta_title
      @page_description = @post.meta_description  
      @email_capture = EmailCapture.new
      @free_book = Book.find_by(title: 'The Stories')
    end
  
    def new
      @post = Post.new
      @page_title = "New Post"
      @categories =  Category.where(parent_id: nil)
      @post_authors =  PostAuthor.all
      authorize @post
    end
  
    def create
      @post = Post.new(post_params)
      authorize @post
    
      if @post.save
        redirect_to  post_path(@post), notice: 'Post was successfully created.'
      else
        @categories =  Category.where(parent_id: nil)  
        @post_authors =  PostAuthor.all
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
      authorize @post
      @categories =  Category.where(parent_id: nil)
      @post_authors =  PostAuthor.all
      @page_title = "Editing" + " " + @post.meta_title.titleize 
    end
  
    def update
      authorize @post
    
      if params[:post][:main_image].present?
        @post.main_image.attach(params[:post][:main_image])
      end
    
      if @post.update(post_params)
        redirect_to edit_post_path(@post), notice: 'Post was successfully updated.'
      else
        @categories =  Category.where(parent_id: nil)
        @post_authors =  PostAuthor.all  # Ensure this is set on re-render
        render :edit, status: :unprocessable_entity
      end
    end
    
    
    def destroy
      authorize @post
      @post.destroy
      redirect_to blog_dashboard_path, notice: 'Post was successfully destroyed.'
    end
  
    private
  
    def set_post
      @post = Post.friendly.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:title, :main_image, :main_image_alt_text, :meta_title, :description, :meta_description, :published, :published_at, :custom_url, :content, :slug, :writer, :post_author, :post_type, :post_author_id, category_ids: [])
    end

    def set_layout
      case action_name
      when 'show', 'new', 'edit'
         'page_templates/medium_page'
      when 'index'
         'page_templates/large_page'
      else
         'application'
      end
   end

  end
