 
  module BooksHelper
    def link_to_if_authorized(text, book, action)
      policy_check = case action
                     when :edit, :destroy
                       policy(book).public_send("#{action}?")
                     when :book_sections
                      policy(Publishing::BookSection).index?
                     else
                       false
                     end
  
      if policy_check
        link_options = case action
                       when :edit
                         { path: edit_publishing_book_path(book), method: :get }
                       when :destroy
                         { path: publishing_book_path(book), method: :delete, data: { confirm: 'Are you sure?' } }
                       when :book_sections
                         { path: publishing_book_book_sections_path(book), method: :get, class: 'btn btn-primary' }
                       else
                         {}
                       end
  
        link_to text, link_options[:path], method: link_options[:method], 
                data: link_options[:data], class: link_options.fetch(:class, 'btn btn-secondary')
      end
    end
  end
