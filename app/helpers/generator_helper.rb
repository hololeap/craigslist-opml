module GeneratorHelper

  def search_form_elements(field)
    additive_tag :ul, 
      *case field.field_type
         when "SearchRange"
           search_range_form_elements(field)
         when "SearchText"
           search_text_form_elements(field)
         else
           raise "Search form not implemented for #{field.field_type.inspect}"
       end
  end

  def search_range_form_elements(field)
    category = field.category
    range = field.field
    min_id = search_element_id(category, field, range.min_name)
    max_id = search_element_id(category, field, range.max_name)

    [additive_tag(:li,
       label(:category, min_id, 'Min'),
       number_field(:category, min_id, step: 0.01)),
     additive_tag(:li, 
       label(:category, max_id, 'Max'),
       number_field(:category, max_id, step: 0.01)) ]
  end

  def search_text_form_elements(field)
    category = field.category
    text = field.field
    id = search_element_id(category, field, text.name)

    text_field(:category, id)
  end


  def search_element_id(category, field, inner_text)
    "#{category.id}[search[#{field.id}[#{inner_text}]]]"
  end

  def additive_tag(tag_name, *args)
    content_tag tag_name, args.inject(ActiveSupport::SafeBuffer.new, :+)
  end
end
