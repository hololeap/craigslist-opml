class CreateSearchTexts < ActiveRecord::Migration
  def change
    create_table :search_texts do |t|
      t.string :name

      t.timestamps
    end
  end
end
