
  module CategoriesHelper
    def category_hierarchy(categories, parent_id = nil, &block)
      categories.select { |c| c.parent_id == parent_id }.map do |category|
        render_category(category, &block)
      end.join.html_safe
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
 