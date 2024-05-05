module ImageResourcesHelper
    def image_dimensions(image_type)
      if image_type == "standard"
        { width: 700, height: 400 }
      elsif image_type == "book cover"
        { width: 350, height: 200 }
      else
        { width: 700, height: 400 }
      end
    end
  end