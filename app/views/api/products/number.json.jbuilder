json.array! @images do |image|
  json.id image.id
  json.product_image category.product_image
  json.product_id category.product_id
end