
  module CategoriesHelper

    # I think this method is now redundant after adding sub-child
  #  def category_hierarchy(categories, parent_id = nil, &block) 
  #    categories.select { |c| c.parent_id == parent_id }.map do |category|
  #      render_category(category, &block)
  #    end.join.html_safe
  #  end

    def display_categories(categories, margin_level = 0)
      content_tag(:ul) do
        categories.each do |category|
          concat(content_tag(:li, style: "margin-left: #{20 * margin_level}px;") do
            link_to(category.name, category_path(category)) + 
            " | ".html_safe + 
            (link_to('Edit', edit_category_path(category)) if policy(category).update?).to_s.html_safe +
            " | ".html_safe +
            (link_to('Delete', category_path(category), method: :delete, data: { "turbo-method": :delete, "turbo_confirm": 'Are you sure?' }) if policy(category).destroy?).to_s.html_safe +
            (display_categories(category.child_categories, margin_level + 1) unless category.child_categories.empty?)
          end)
        end
      end
    end

    def category_depth(category, current_depth = 0)
      return current_depth unless category.parent_category
      category_depth(category.parent_category, current_depth + 1)
    end
  
    def category_checkboxes(categories, f, margin = 0)
      safe_join(categories.map do |category|
        content_tag(:div, class: "form-check", style: "margin-left: #{20 * margin}px;") do
          concat(f.check_box :category_ids, { multiple: true, id: "category_#{category.id}", class: "form-check-input" }, category.id, nil)
          concat(label_tag "category_#{category.id}", category.name, class: 'form-check-label')
          concat(category_checkboxes(category.child_categories, f, margin + 1)) if category.child_categories.any?
        end
      end, "")
    end

    def display_category_and_posts(category)
      render_content = ''.html_safe
  
      # Display the category title linking to its show page
      render_content += content_tag(:h3, link_to(category.name.titleize, category_path(category)), class: 'category-show__sub-title')
  
      # Display the category's posts using the `latest_posts` partial
      render_content += render(partial: 'shared/latest_posts', locals: { posts: category.posts.published })
  
      # Recursively display each child category and its posts
      category.child_categories.each do |child_category|
        render_content += display_category_and_posts(child_category)
      end
  
      render_content
    end



    def build_breadcrumbs(categories)
      content_tag(:nav, {'aria-label' => 'breadcrumb'}, itemscope: true, itemtype: 'https://schema.org/BreadcrumbList') do
        content_tag(:ol, class: 'breadcrumb') do
          categories.each_with_index.map do |category, index|
            content_tag(:li, class: 'breadcrumb-item', itemprop: 'itemListElement', itemscope: true, itemtype: 'https://schema.org/ListItem') do
              link_to(category_path(category), itemprop: "item") do
                concat(tag.span(category.name, itemprop: "name"))
              end + (index < categories.length - 1 ? tag.meta('', itemprop: 'position', content: index + 1) : '')
            end
          end.join.html_safe
        end
      end
    end
    
def get_full_category_path(post)
  deepest_category = post.categories.max_by { |category| category_depth(category) }
  path = []
  current_category = deepest_category

  while current_category
    path.unshift(current_category)
    current_category = current_category.parent_category
  end

  path
end

    private
  
    def render_category(category, &block)
      content_tag(:li, class: "category-list__item") do
        link_to(category.name, category_path(category)) +
        if category.child_categories.any?
          content_tag(:ul, category_hierarchy(category.child_categories, category.id, &block), class: "category-list__nested")
        end
      end
    end
  end
 