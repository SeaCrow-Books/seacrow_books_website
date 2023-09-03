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


end
