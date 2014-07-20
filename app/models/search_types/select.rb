class SearchTypes::Select < ActiveRecord::Base
  has_one :search_field, as: :field
  has_many :options, class_name: 'SearchTypes::Option'

  def self.convert_string(s)
    s.split(',').map{|i| options.find_by_name}
  end
end
