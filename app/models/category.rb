class Category < ApplicationRecord
  has_ancestry
  acts_as_tree
  has_many :products
end
