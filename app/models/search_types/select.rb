class SearchTypes::Select < ActiveRecord::Base
  has_one :search_field, as: :field
end
