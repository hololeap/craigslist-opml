class SearchTypes::Boolean < ActiveRecord::Base
  has_one :search_field, as: :field

  def self.convert_string(s)
    s == 'true'
  end
    
end
