module PostsHelper

    # Calculates read time for blog posts
    def read_time(post_content)
        word_count = post_content.split.size
        minutes = (word_count / 250.0).ceil
        "#{minutes} min read"
    end

end
