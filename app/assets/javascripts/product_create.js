// let CategorySelectBoxHTML = `
// <div class="select-wrap">
//   <i class="fa fa-chevron-down"></i>
//   <select class="category_parent">
//   <option value="0">---</option>
//   <option value="1">レディース</option>
//   <option value="200">メンズ</option>
//   <option value="345">ベビー・キッズ</option>
//   <option value="480">インテリア・住まい・小物</option>
//   <option value="623">本・音楽・ゲーム</option>
//   <option value="683">おもちゃ・ホビー・グッズ</option>
//   <option value="796">コスメ・香水・美容</option>
//   <option value="896">家電・スマホ・カメラ</option>
//   <option value="982">スポーツ・レジャー</option>
//   <option value="1091">ハンドメイド</option>
//   <option value="1143">チケット</option>
//   <option value="1202">自動車・オートバイ</option>
//   <option value="1264">その他</option>
//   </select>
// </div>`



// カテゴリ選択


$(document).on('turbolinks:load', function () {
  function appendCategory(name){
    var html = `
                <option value="${name}">${name}</option>
                `
    return html;
    }



  $('#category_parent').change(function() {
      var parent_name = $(this).val();
      var user_id = $(".select-wrap").attr("id");
      if(parent_name == "レディース"){
        parent_id = 1;
      }
      if(parent_name == "メンズ"){
        parent_id = 200;
      }
      if(parent_name == "ベビー・キッズ"){
        parent_id = 345;
      }
      if(parent_name == "インテリア・住まい・小物"){
        parent_id = 480;
      }
      if(parent_name == "本・音楽・ゲーム"){
        parent_id = 623;
      }
      if(parent_name == "おもちゃ・ホビー・グッズ"){
        parent_id = 683;
      }
      if(parent_name == "コスメ・香水・美容"){
        parent_id = 796;
      }
      if(parent_name == "家電・スマホ・カメラ"){
        parent_id = 896;
      }
      if(parent_name == "スポーツ・レジャー"){
        parent_id = 982;
      }
      if(parent_name == "チケット"){
        parent_id = 1143;
      }
      if(parent_name == "自動車・オートバイ"){
        parent_id = 1202;
      }
      if(parent_name == "その他"){
        parent_id = 1264;
      }
      $.ajax({
          type: 'GET',
          url: "/users/" + user_id + "/api/products/child",
          dataType: 'json',
          data: {id: parent_id}
      })
      .done(function(categories){
        if($('#ct_no_2').val() != null){
          $('#ct_no_2').remove();
        }
        html_head = `
                    <div class="form-input-t" value="ct_no_2">
                      <label for="product_category_id">カテゴリー</label>
                      <div class="select-wrap" id="1">
                      <i class="fa fa-chevron-down"></i>
                    <select class="category_child" id="category_child">
                    `
        ap_html = html_head
        categories.forEach(function(category){
          ct_html = appendCategory(category.name)
          ap_html = ap_html + ct_html
        })
        html_foot=`
                    </select>
                    </div>
                    </div>
                  `
        html = ap_html + html_foot;
        $('.ct_box_k').append(html);
      })
      .fail((data) => {
        //失敗した場合の処理
        console.log(data.responseText);  //レスポンス文字列を表示
      })
  });
  
  $(this).on("change", "#child", function() {
      var child_id = $("#child").val();
      $.ajax({
          type: 'GET',
          url: '/api/grand_child',
          data: {id: child_id},
          dataType: 'json'
      })
      .done(function(categories) {
          $('.grand_child').css('display', 'block');
          $('#grand_child').empty();
          $('#grand_child').append(buildPrompt);
          categories.forEach(function(cat) {
              var html_option = buildHtmlOption(cat);
              $('#grand_child').append(html_option);
          });
      })
      .fail(function() {
      });
  });
let DeliveryMethodSelectBoxHTML = `
<div class="form-input-t">
  <label>
    配送の方法
    <span class="must-filled-mark-t">
      必須
    </span>
  </label>
  <div class="select-wrap">
    <i class="icon-arrow-bottom"></i>
    <select class="select-default" name="product[delivery_method]" id="product_delivery_method">
    <option value="未定">未定</option>
    <option value="らくらくメルカリ便">らくらくメルカリ便</option>
    <option value="ゆうメール">ゆうメール</option>
    <option value="レターパック">レターパック</option>
    <option value="普通郵便(定形、定形外)">普通郵便(定形、定形外)</option>
    <option value="クロネコヤマト">クロネコヤマト</option>
    <option value="ゆうパック">ゆうパック</option>
    <option value="クリックポスト">クリックポスト</option>
    <option value="ゆうパケット">ゆうパケット</option></select>
  </div>
</div>`


$(document).on('turbolinks:load', function(){
  let fileForms = $("[type=file]");
  $(fileForms).hide();

//画像がアップローダされたらhidden属性でproduct_image: count:の値を付与
  $("[id ^='product_product_images_attributes_']").change(function() {
    //アップロードされたinputタグのidから数字部分を取り出す
    let productImageNum = $(this).attr('id').replace(/[^0-9]/g, '');//数字でない部分を空白へ置換=削除
    productImageNum = Number(productImageNum);//文字列型なので数値型へ変換
    let labelIdValue = 'product_product_images_attributes_'+productImageNum+'_product_image';
    let ProductImageCountAttrHTML = `
    <input type="hidden" 
    name="product[product_images_attributes][${productImageNum}][count]" 
    value=${productImageNum}>
    `;

    $(labelIdValue).show();
    $(this).show();
    $(this).after(ProductImageCountAttrHTML);
    //ラベルが指すアップローダーを変更
    if (productImageNum <= 9){
      //let label = $("[for ^='product_product_images_attributes_']");
      let incrementedProductImageNum = productImageNum + 1;
      let incrementedFor = 'product_product_images_attributes_'+incrementedProductImageNum+'_product_image';
      //書き換え
      $("[for ^='product_product_images_attributes_']").attr('for', incrementedFor);
    }
    
  });

  // $('#product_categry').change(function() {
  //   let selection = $('option:selected').val();
  //   console.log(selection);
  //   $('#product_categry').after(CategorySelectBoxHTML);
  //   if (!selection) {
  //     console.log('default');
  //   }
  // });

  $('#product_delivery_fee').change(function() {
    let selection = $('option:selected').val();
    console.log(selection);
    $('#product_delivery_fee').after(DeliveryMethodSelectBoxHTML);
    if (!selection) {
      console.log('default');
    }
  });

  //手数料と利益の計算
  $('#product_price').on('keyup', function(e){
    let product_fee_rate = 0.1
    let product_price = $('#product_price').val();
    let product_fee = Math.floor(product_price * product_fee_rate);
    let product_gain = product_price - product_fee;
    $('#product-fee').html(product_fee);
    $('#product-gain').html(product_gain);
  });

});
});