class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.integer :number, null: false
      t.date    :expiration_date, null: false
      t.timestamps
    end
  end
end
