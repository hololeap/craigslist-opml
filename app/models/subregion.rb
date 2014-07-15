class Subregion < Region
  belongs_to :region
  has_many :cities, foreign_key: 'region_id'
  has_many :subcities, through: :cities
  
  alias :children :cities
  
  def has_children?
    cities.count > 0
  end
end
