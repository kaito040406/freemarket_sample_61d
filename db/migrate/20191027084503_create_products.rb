class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t| 
      t.integer :seller_id, null: false, foreign_key: true
      t.string  :name, null: false
      t.text    :text, null: false
      t.integer :price, null: false
      t.string  :categry
      t.integer :status, null: false
      t.integer :brand, null: true
      t.integer :size, null: false
      t.date    :date, null: false 
      t.integer :delivery_fee, null: false
      t.integer :delivery_method
      t.integer :delivery_from, null: true
      t.integer :estimated_delivery_date, null: true
      t.integer :buyer_id, null: true, foreign_key: true
      t.integer :finished, null: false, default:0
      t.timestamps
    end
  end
end
