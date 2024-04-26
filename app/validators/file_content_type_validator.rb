class FileContentTypeValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      return unless value.attached?
      
      allowed_types = options[:in]
      unless value.content_type.in?(allowed_types)
        value.purge # Optional: Remove the invalid attachment
        record.errors.add(attribute, "must be of types: #{allowed_types.join(', ')}")
      end
    end
  end