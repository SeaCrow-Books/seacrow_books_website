module Blog
    class WriterEngagementsController < ApplicationController
      def create
        # Use friendly.find to accommodate finding the post by slug
        @post = Blog::Post.friendly.find(params[:post_id])
  
        @writer_engagement = WriterEngagement.new(writer_engagement_params)
        @writer_engagement.post = @post
  
        respond_to do |format|
          if @writer_engagement.save
            format.turbo_stream do
              render turbo_stream: turbo_stream.replace('writer_engagement_form', partial: 'blog/writer_engagements/success_message')
            end
            format.html { redirect_back(fallback_location: root_path, notice: 'Thank you for subscribing!') }
          else
            format.html { redirect_back(fallback_location: root_path, alert: 'There was an error with your submission.') }
            format.turbo_stream do
              render turbo_stream: turbo_stream.replace('writer_engagement_form', partial: 'blog/writer_engagements/form', locals: { writer_engagement: @writer_engagement })
            end
          end
        end
      end
  
      private
  
      def writer_engagement_params
        params.require(:writer_engagement).permit(:email)
      end
    end
  end
  