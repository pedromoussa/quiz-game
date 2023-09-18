class RangeFilterInput < Formtastic::Inputs::StringInput
  def to_html
    input_wrapping do
      label_html <<
      builder.text_field("#{method}_gteq", input_html_options) <<
      builder.text_field("#{method}_lteq", input_html_options)
    end
  end
end