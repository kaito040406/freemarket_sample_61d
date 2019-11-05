class ProductImage < ApplicationRecord
  belongs_to :product
  mount_uploader :product_image, ImageUploader # mount_uploader :product_image"s", ImageUploaderとなる可能性あり
end
