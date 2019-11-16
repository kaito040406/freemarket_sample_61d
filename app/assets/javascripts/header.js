$(document).on('turbolinks:load', function(){
  $('#ct_box_h_k').mouseover(function() {
    if($('.category_inner_box_k').length){
      
    }else{
      parent_html = `
      <div class="category_box_k" id="parent_box">
        <div class="category_inner_box_k" id="1">
          レディース
        </div>
        <div class="category_inner_box_k" id="200">
          メンズ
        </div>
        <div class="category_inner_box_k" id="345">
          ベビー・キッズ
        </div>
        <div class="category_inner_box_k" id="480">
          インテリア・住まい・小物
        </div>
        <div class="category_inner_box_k" id="623">
          本・音楽・ゲーム
        </div>
        <div class="category_inner_box_k" id="683">
          おもちゃ・ホビー・グッズ
        </div>
        <div class="category_inner_box_k" id="796">
          コスメ・香水・美容
        </div>
        <div class="category_inner_box_k" id="896">
          家電・スマホ・カメラ
        </div>
        <div class="category_inner_box_k" id="982">
          スポーツ・レジャー
        </div>
        <div class="category_inner_box_k" id="1091">
          ハンドメイド
        </div>
        <div class="category_inner_box_k" id="1143">
          チケット
        </div>
        <div class="category_inner_box_k" id="1202">
          自動車・オートバイ・
        </div>
        <div class="category_inner_box_k" id="1264">
          その他
        </div>
        <div class="category_inner_box_k" id="nothing">
          カテゴリー一覧
        </div>
      </div>
      `
      $('#ct_box_h_k').append(parent_html);
  
    }
  })

  $('#ct_box_h_k').mouseleave(function() {
    $('#parent_box').remove()
  })

  
})



$(function() {
$(document).on('mouseover', '.category_inner_box_k', function(e){
  parent_id = $(this).attr("id")

  $(".category_inner_box_k").css({
    backgroundColor: "",
    color: ""
  })

  $("#"+ parent_id).css({
    backgroundColor: "rgb(234, 53, 45)",
    color: "white"
  })
  user_id = 1
  $.ajax({
    type: 'GET',
    url: "/users/" + user_id + "/api/products/child",
    data: {id: parent_id},
    dataType: 'json'
})
.done(function(categories){
  $('#grand_box').remove()
  $('#child_box').remove()
  haild_htmls =""
  chaild_html_1 = `
              <div class="category_box_c_k" id="child_box">
              `
  chaild_htmls = chaild_html_1
  categories.forEach(function(category){
    
    chaild_html_2 =`      
                  <div class="category_inner_box_c_k" id = "${category.id}" value = "${category.name}">
                    ${category.name}
                  </div>
                  `
    chaild_htmls = chaild_htmls + chaild_html_2
  })
  chaild_html_3 = `</div>`
  chaild_html = chaild_htmls + chaild_html_3
  $('#ct_box_h_k').append(chaild_html);

})

$('#ct_box_h_k').mouseleave(function() {
  $('#child_box').remove()
  $('#grand_box').remove()
})

})
})

$(function() {
$(document).on('mouseleave', '.category_inner_box_k', function(e){
  $("#"+ parent_id).css({
      color: "",
      backgroundColor: ""
  })
})
})


$(function() {
$(document).on('mouseover', '.category_inner_box_c_k', function(e){
  ct_id = $(this).attr("id")

  $(".category_inner_box_c_k").css({
    backgroundColor: "",
  })

  $("#"+ parent_id).css({
    backgroundColor: "rgb(234, 53, 45)",
    color: "white"
  })
  chaild_id = $(this).attr("value")
  $("#"+ ct_id).css({
    backgroundColor: "rgb(204, 204, 204)",
  })
  user_id = 1
  $.ajax({
    type: 'GET',
    url: "/users/" + user_id + "/api/products/grand_child",
    data: {id: chaild_id},
    dataType: 'json'
})
.done(function(categories){
  $('#grand_box').remove()
  g_haild_htmls =""
  grand_html_1 = `
              <div class="category_box_g_k" id="grand_box" value = "${ct_id}">
              `
  grand_htmls = grand_html_1
  categories.forEach(function(category){
    
    grand_html_2 =`      
                  <div class="category_inner_box_g_k" id = "${category.id}" value = "${category.id}">
                    ${category.name}
                  </div>
                  `
    grand_htmls = grand_htmls + grand_html_2
  })
  grand_html_3 = `</div>`
  grand_html = grand_htmls + grand_html_3
  $('#ct_box_h_k').append(grand_html);

})

$('#ct_box_h_k').mouseleave(function() {
  $('#grand_box').remove()
})
})

$(function() {
  if($('.category_inner_box_c_k').length){

  }else{
    $('#child_box').remove()
    $('#grand_box').remove()
  }
})
})

$(function() {
  $(document).on('mouseleave', '.category_inner_box_c_k', function(e){
    $("#"+ ct_id).css({
        color: "",
        backgroundColor: ""
    })
  })
})


$(function() {
  $(document).on('mouseover', '.category_box_g_k', function(e){
    ctt_id = $(this).attr("value")
    $("#"+ ctt_id).css({
        backgroundColor: "rgb(204, 204, 204)"
    })
  })
})


$(function() {
  $(document).on('mouseover', '.category_inner_box_g_k', function(e){
    cttt_id = $(this).attr("value")
    $("#"+ cttt_id).css({
        backgroundColor: "rgb(204, 204, 204)"
    })
  })
})


$(function() {
  $(document).on('mouseleave', ".category_inner_box_g_k", function(e){
    $("#"+ cttt_id).css({
      backgroundColor: ""
    })
  })
})