class Subcategory < Category
  has_and_belongs_to_many :search_fields, foreign_key: 'category_id'
  has_many :feeds, foreign_key: 'category_id'
  belongs_to :category

  alias_method :local_search_fields, :search_fields

  def search_fields
    local_search_fields + category.search_fields
  end
  
  def children
    nil
  end
  
  def has_children?
    false
  end

  def post_title_regex
    read_attribute(:post_title_regex) || category.post_title_regex
  end

  def post_title_matches
    read_attribute(:post_title_matches) || category.post_title_matches
  end
end
