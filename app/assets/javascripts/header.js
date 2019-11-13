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
        console.log("ok")
        $('#parent_box').remove()
      })

    
})

