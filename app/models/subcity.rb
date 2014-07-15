class Subcity < City
  belongs_to :city
  has_many :categories, foreign_key: 'city_id' 
  has_many :feeds, foreign_key: 'city_id'
  
  def children
    nil
  end
end
