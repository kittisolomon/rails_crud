class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.integer :quantity
      t.text :description
      t.string :sku
      t.boolean :instock, default: true
      t.timestamps
    end
  end
end
