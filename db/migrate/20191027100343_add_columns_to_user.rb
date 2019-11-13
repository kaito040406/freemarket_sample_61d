class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    #add_column :users,  :piyo,            :string
    add_column :users,  :nick_name,       :string,  null: false, default: nil
    add_column :users,  :sur_name,        :string,  null: false, default: nil
    add_column :users,  :fr_name,         :string,  null: false, default: nil
    add_column :users,  :sur_name_yomi,   :string,  null: false, default: nil 
    add_column :users,  :first_name_yomi, :string,  null: false, default: nil
    add_column :users,  :introduction,    :string
    add_column :users,  :birthday_year,   :integer
    add_column :users,  :birthday_manth,  :integer
    add_column :users,  :birthday_day,    :integer
    #add_column :users,  :email,           :string,  null: false 
    #add_column :users,  :password,        :string,  null: false 
    add_column :users,  :tel_number,      :string,  null: false, default: nil
    add_column :users,  :certification,   :string, null: false, default: nil
    add_column :users,  :account,         :integer
    add_column :users,  :sales_money,     :integer 
    add_column :users,  :point,           :integer
    add_column :users,  :icon_image,      :string, default: nil
    add_column :users,  :address_number,   :string, null: false, default: nil
    add_column :users,  :address_ken,      :string, null: false, default: nil
    add_column :users,  :address_city,     :string, null: false, default: nil
    add_column :users,  :address_banch,    :string, null: false, default: nil
    add_column :users,  :building_name,    :string  
    add_column :users,  :evaluation,       :integer, default: 0
    add_column :users,  :exhibits_number,  :integer, default: 0
  end
end
