class ImageResourcesController < ApplicationController
    before_action :set_image_resource, only: %i[show edit update destroy]
  
    # Assuming you're using Pundit for authorization like in your GenresController
    def index
      @page_title = "Image Resources"
      if params[:filter].present?
        filter_type, filter_id = params[:filter].split('_')
        
        case filter_type
        when 'category'
          @image_resources = ImageResource.joins(:categories).where('categories.id = ?', filter_id)
        when 'tag'
          @image_resources = ImageResource.tagged_with(ActsAsTaggableOn::Tag.find(filter_id).name)
        else
          @image_resources = ImageResource.all
        end
        
      else
        @image_resources = ImageResource.all
      end
      authorize @image_resources
    end
  
    def show
      @page_title = "Image Resource"
      authorize @image_resource
    end
  
    def new
      @image_resource = ImageResource.new
      authorize @image_resource
    end
  
    def create
      @image_resource = ImageResource.new(image_resource_params)
      authorize @image_resource
      if @image_resource.save
        redirect_to @image_resource, notice: 'Image resource was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
      authorize @image_resource
    end
  
    def update
      authorize @image_resource
      if @image_resource.update(image_resource_params)
        redirect_to @image_resource, notice: 'Image resource was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      authorize @image_resource
      @image_resource.destroy
      redirect_to image_resources_url, notice: 'Image resource was successfully destroyed.'
    end

    # Creates the permanant image url
    def permanent_image
      @image_resource = ImageResource.friendly.find(params[:id])
      redirect_to rails_blob_url(@image_resource.image)
    end
  
    private
  
    def set_image_resource
      @image_resource = ImageResource.friendly.find(params[:id])
    end
  
    def image_resource_params
      params.require(:image_resource).permit(:alt_description, :image, :tag_list, :name, :notes, category_ids: [])
    end
  end
  