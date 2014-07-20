class SearchTypes::Range < ActiveRecord::Base
  has_one :search_field, as: :field

  def self.convert_string(s)
    min, max = s.split(',').map {|n| BigDecimal.new(n, 10) }
    Range.new(min,max)
  end

  def self.matching_data?(value, data)
    value.include? data
  end
end
