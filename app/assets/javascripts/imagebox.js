
$(document).on('turbolinks:load', function(){
 $(document).ready(function(){
    path = location.pathname
    product_id = $(".select-wrap").attr("id")
    console.log(product_id)
    if(path == "/products/" + product_id + "/edit"){
      
    }
  })
 })
