class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :url

      t.string :last_url
      t.string :last_matching_url

      t.references :category
      t.references :city

      t.timestamps
    end
  end
end
