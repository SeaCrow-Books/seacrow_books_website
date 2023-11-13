module ApplicationHelper

    # Sets Bootstrap for the flash messages
    def flash_class(key)
        case key.to_sym
        when :notice then "alert-info"
        when :success then "alert-success"
        when :error then "alert-danger"
        when :alert then "alert-warning"
        end
    end

    # Markdown helper
    def markdown_to_html(text)
        renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
        markdown = Redcarpet::Markdown.new(renderer, extensions = {})
        markdown.render(text).html_safe
    end


end
