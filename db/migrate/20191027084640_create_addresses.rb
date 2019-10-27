class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table  :addresses do |t|
      t.integer   :user_id, null: false, foreign_key: true
      t.string    :prefecture, null: false
      t.string    :below_city_or_ward, null: false
      t.string    :below_house_number, null: true
      t.integer   :postal_code, null: false
      t.timestamps
    end
  end
end
