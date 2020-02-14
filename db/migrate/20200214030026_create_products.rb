class CreateProducts < ActiveRecord::Migration[5.1]
  def up
    create_table :products do |t|
      t.string :name
      t.float :price
      t.string :description
      t.string :mark
      t.string :imgurl
      t.string :available
      t.text :image
      t.string :category
    end
  end
  def down
    drop_table :products
  end
end
