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

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def homepage?
    params[:controller] == 'static_pages' and params[:action] == 'home'
  end

  def body_id
    homepage? ? 'landing-body' : 'normal-body'
  end

  def container_id
    homepage? ? 'landing-container' : 'main-container'
  end

  def yandex_link(city, street, house)
    "http://maps.yandex.ru/?text=Казахстан, #{URI::escape(city)}, улица #{URI::escape(street)}, #{URI::escape(house)}"
  end
  
end