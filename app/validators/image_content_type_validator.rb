class ImageContentTypeValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if value.attached? && !value.content_type.in?(%w(image/webp))
        record.errors.add(attribute, (options[:message] || 'must be a WEBP'))
      end
    end
end