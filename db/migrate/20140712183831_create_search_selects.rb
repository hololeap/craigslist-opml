class CreateSearchSelects < ActiveRecord::Migration
  def change
    create_table :search_selects do |t|
      t.string :name

      t.timestamps
    end
  end
end
