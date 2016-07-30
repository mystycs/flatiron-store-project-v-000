class CreateItems < ActiveRecord::Migration
  def change
	create_table :items do |t|
		t.references :category, index: true
		t.string :title
		t.integer :inventory
		t.integer :price

		t.timestamps null: false
	end
	add_foreign_key :items, :categories
  end
end
