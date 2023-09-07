class ImageContentTypeValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if value.attached? && !value.content_type.in?(%w(image/jpeg image/png image/webp))
        record.errors.add(attribute, (options[:message] || 'must be a JPEG, PNG, or WEBP'))
      end
    end
end