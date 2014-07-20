class SearchTypes::Text < ActiveRecord::Base
  has_one :search_field, as: :field

  def self.convert_string(s)
    s
  end

  def self.matching_data?(value, data)
    true & (data =~ Regexp.new(value, 'i'))
  end
end
