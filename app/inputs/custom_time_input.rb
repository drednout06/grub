class CustomTimeInput < SimpleForm::Inputs::Base
  def input
    "#{@builder.text_field("delivery_time", input_html_options)}".html_safe
  end

  #Makes the label target the day input
  def label_target
    "delivery_time"
  end
end