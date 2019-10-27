class CreateUserProductComments < ActiveRecord::Migration[5.2]
  def change
    create_table :user_product_comments do |t|
      t.integer :product_id, null: false, foreign_key: true
      t.integer :user_id, null: false, foreign_key: true
      t.text    :text, null: false
      t.timestamps
    end
  end
end
