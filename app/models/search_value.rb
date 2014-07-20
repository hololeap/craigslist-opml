class SearchValue < ActiveRecord::Base
  belongs_to :feed_aggregator
  belongs_to :search_field
  belongs_to :feed

  def value
    search_field.field_class.convert_string(read_attribute(:value))
  end

  def matching_data?(post)
    data = post.send search_attribute
    search_field.field_class.matching_data?(value, data)
  end

  def search_attribute
    search_field.search_attribute
  end
end
