class SearchTypes::Text < ActiveRecord::Base
  has_one :search_field, as: :field
end
