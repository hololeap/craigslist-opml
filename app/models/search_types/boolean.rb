class SearchTypes::Boolean < ActiveRecord::Base
  has_one :search_field, as: :field

  def search_hash(min, max)
    {min_name => min, max_name => max}
  end
end
