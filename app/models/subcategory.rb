class Subcategory < Category
  belongs_to :category
  has_many :search_fields, foreign_key: 'category_id'
  has_many :feeds, foreign_key: 'category_id'
  
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
