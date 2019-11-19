$(function() {
  $('#brand_ky').mouseover(function() {
    if($('.brand_inner_box').length) {

    }else{
      parent_html = `
      <div class="brand_box" id="box">
        <div class="brand_inner_box" >
        シャネル
        </div>
        <div class="brand_inner_box">
        ナイキ
        </div>
        <div class="brand_inner_box">
        ルイヴィトン
        </div>
        <div class="brand_inner_box">
        シュプリーム
        </div>
        <div class="brand_inner_box">
        アディダス
        </div>
        <div class="brand_inner_box">
        ブランド一覧
        </div>
      </div>
      `
      $('#brand_ky').append(parent_html);
    }
  })

  $('#brand_ky').mouseleave(function() {
    $('#box').remove()
  })
})