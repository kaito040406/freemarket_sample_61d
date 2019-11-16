json.array! @images do |image|
  json.id image.id
  json.product_image image.product_image
  json.product_id image.product_id
end