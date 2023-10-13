module PostsHelper

    # Calculates read time for blog posts
    def read_time(post_content)
        word_count = post_content.split.size
        minutes = (word_count / 250.0).ceil
        "#{minutes} min read"
    end

    def embed_images_in_text(text)
        text.gsub(/\[image=(\d+)\]/) do
          image = ImageResource.find($1)
          image_tag(image.url, alt: image.alt_text)
        end
      end

end
