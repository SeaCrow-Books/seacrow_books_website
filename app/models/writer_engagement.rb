class WriterEngagement < ApplicationRecord
  belongs_to :post, class_name: 'Blog::Post'
end
