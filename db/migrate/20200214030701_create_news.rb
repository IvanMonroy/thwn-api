class CreateNews < ActiveRecord::Migration[5.1]
  def change
    create_table :news do |t|
      t.string :title
      t.text :description
      t.text :imageNew
      t.string :imageurl
    end
  end
end
