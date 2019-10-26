class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table  :products do |t|
      t.integer   :user_id,                      foreign_key: true
      t.string    :name
      t.text      :text,                         null: true
      t.integer   :price
      t.string    :category,                     null: true
      t.string    :brand,                        null: true
      t.string    :status
      t.date      :date
      t.string    :image,                        null: true
      t.string    :product_size
      t.string    :delivery_fee
      t.string    :delivery_method
      t.string    :delivery_from
      t.date      :estimated_delivery_date
      t.timestamps
    end
  end
end
