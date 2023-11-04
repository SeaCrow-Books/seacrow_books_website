class TagsController < ApplicationController
    def index
      @tags = ActsAsTaggableOn::Tag.all
      authorize @tags, policy_class: TagPolicy
    end
    
    def show
      @tag = ActsAsTaggableOn::Tag.find(params[:id])
      authorize @tag, policy_class: TagPolicy
      @image_resources = ImageResource.tagged_with(@tag.name)
    end
  
    def new
      @tag = ActsAsTaggableOn::Tag.new
      authorize @tag, policy_class: TagPolicy
    end
  
    def create
      @tag = ActsAsTaggableOn::Tag.new(tag_params)
      authorize @tag, policy_class: TagPolicy
      if @tag.save
        redirect_to tags_path, notice: 'Tag was successfully created.'
      else
        render :new
      end
    end
  
    def edit
      @tag = ActsAsTaggableOn::Tag.find(params[:id])
      authorize @tag, policy_class: TagPolicy
    end
  
    def update
      @tag = ActsAsTaggableOn::Tag.find(params[:id])
      authorize @tag, policy_class: TagPolicy
      if @tag.update(tag_params)
        redirect_to tags_path, notice: 'Tag was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @tag = ActsAsTaggableOn::Tag.find(params[:id])
      authorize @tag, policy_class: TagPolicy
      @tag.destroy
      redirect_to tags_path, notice: 'Tag was successfully destroyed.'
    end

    private
  
    def tag_params
      params.require(:acts_as_taggable_on_tag).permit(:name)
    end
    
  end
  