# encoding: utf-8
module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "grub.kz"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

  def star_button_readonly(name, value, checked, disabled)
    radio_button_tag(name, value, checked, class: 'hover-star {split:2}',
        disabled: disabled)
  end

  def star_button(value, checked)
    radio_button_tag("rating", value, checked, class: 'hover-star required',
      title: t("navigation.rating_#{value}"))
  end

  def order_status_to_class(status)
    case status
    when "pending"
      "warning"
    when "accepted"
      "success"
    when "rejected"
      "error"
    else
      "info"
    end
  end
  
end