
$(document).on('turbolinks:load', function(){
 $(document).ready(function(){
    path = location.pathname
    product_id = $(".select-wrap").attr("id")
    if(path == "/products/" + product_id + "/edit"){
      pics = $(".thumbnail").attr("src")
      $(".img-uploader-dropbox").empty()
      img_box_html = ``
      pics.forEach(function(image){
        pic = image.product_image
        img_box_htmls = 
          `
            <div class="product_image_box">
              <img width="114px" height="116px" class="thumbnail" src="${pic}">
            </div>
          `
        img_box_html = img_box_html + img_box_htmls
        })
      $(".img-uploader-dropbox").append(img_box_html)
       
      }
    })
 })
