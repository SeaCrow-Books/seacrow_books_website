
class CategoryHierarchyService
  def initialize(category)
    @category = category
  end

  def ancestors
    collect_ancestors(@category).reverse
  end

  def descendants
    collect_descendants(@category)
  end

  private

  def collect_ancestors(category, ancestors_array = [])
    return ancestors_array unless category.parent_category

    ancestors_array << category.parent_category
    collect_ancestors(category.parent_category, ancestors_array)
  end

  def collect_descendants(category, descendants_array = [])
    category.child_categories.each do |child_category|
      descendants_array << child_category
      collect_descendants(child_category, descendants_array) unless child_category.leaf?
    end
    descendants_array
  end
end

