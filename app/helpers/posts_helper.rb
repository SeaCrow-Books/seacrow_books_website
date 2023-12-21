
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

    # Structuers category dropdown in post form
    def structured_category_options(categories)
      options = []
      categories.each do |category|
        # Add the parent category
        options << [category.name, category.id]
  
        # Add its child categories, indented
        category.child_categories.each do |child|
          options << ["-- #{child.name}", child.id]
        end
      end
      options
    end
