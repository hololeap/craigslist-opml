class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :url, default: '', null: false
      t.decimal :range_min, precision: 10, scale: 2
      t.decimal :range_max, precision: 10, scale: 2
      t.string :search_string
      
      t.string :last_url
      t.string :last_matching_url

      t.references :category, index: true
      t.references :city, index: true

      t.timestamps
    end
  end
end
