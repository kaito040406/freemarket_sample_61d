class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    #add_column :users,  :piyo,            :string
    add_column :users,  :nick_name,       :string,  null: false 
    add_column :users,  :sur_name,        :string,  null: false 
    add_column :users,  :fr_name,         :string,  null: false 
    add_column :users,  :sur_name_yomi,   :string,  null: false 
    add_column :users,  :first_name_yomi, :string,  null: false 
    add_column :users,  :introduction,    :string
    add_column :users,  :birthday_year,   :string,    null: false 
    add_column :users,  :birthday_manth,  :string,    null: false 
    add_column :users,  :birthday_day,    :string,    null: false 
    #add_column :users,  :email,           :string,  null: false 
    #add_column :users,  :password,        :string,  null: false 
    add_column :users,  :tel_number,      :string,  null: false 
    add_column :users,  :account,         :integer
    add_column :users,  :sales_money,     :integer 
    add_column :users,  :point,           :integer
    add_column :users,  :icon_image,      :string 
  end
end
