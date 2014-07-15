class CreateSearchRanges < ActiveRecord::Migration
  def change
    create_table :search_ranges do |t|
      t.string :min_name
      t.string :max_name

      t.timestamps
    end
  end
end
