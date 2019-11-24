$(document).on('turbolinks:load', function(){
  // editフォームからは実行されない
  pathSelf =location.pathname;
  if (pathSelf.match(/edit/) != null) {
      return false;
  }
  //値段に合わせ手数料と利益を更新する関数
  function calcFeeGain(){
    let product_fee_rate = 0.1
    let product_price = $('#product_price').val();
    let product_fee = Math.floor(product_price * product_fee_rate);
    let product_gain = product_price - product_fee;
    $('#product-fee').html(product_fee);
    $('#product-gain').html(product_gain);
  }
  function appendCategory(ct){//valueは子カテゴリの名前でajaxでの孫カテゴリ取得に用いられる
    var html = `
                <option value="${ct.name}" id = "${ct.id}">${ct.name}</option>
                `
    return html;
  }
  function appendCategory_g(ct){//valueは孫カテゴリのcategoriesテーブルでのidでproductsレコードに保存される
    var html = `
                <option value="${ct.id}" id = "${ct.id}">${ct.name}</option>
                `
    return html;
  }
  let DeliveryMethodSelectBoxHTML = `
    <div class="form-input" id="product_delivery_method">
      <label>
        配送の方法
        <span class="must-filled-input">
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

  //カテゴリーセレクトボックス関連処理
  //ct_no_1＝親カテゴリ、ct_no_2＝子カテゴリ、ct_no_3＝孫カテゴリ
  $(document).on("change", "#category_parent", function() {
      //選択された親カテゴリのDB categoriesテーブル上のidである parent_idを用意
      var parent_name = $(this).val();
      user_id = $(".select-wrap").attr("id");
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
      .done(function (categories){//返り値categories:渡された親カテゴリに属する子カテゴリ群
        //////子、孫カテゴリのセレクトボックスがあれば消去（重複防止）
        if($('#ct_no_2').val() != null){
          $('#ct_no_2').remove();
        }
        if($('#ct_no_3').val() != null){
          $('#ct_no_3').remove();
        }
        html_head = `
                    <div class="form-input_2" id="ct_no_2" value="ct_no_2">
                      <div class="select-wrap" id="1">
                      <i class="fa fa-chevron-down"></i>
                    <select class="category_child" id="category_child" name="child">
                    <option value="---" id = "---">---</option>
                    `
        ap_html = html_head //子カテゴリセレクトボックス前半部分が入る
        categories.forEach(function(category){ //取得されたjsonデータを用いセレクトボックスのoption群生成・htmlに付加
          ct_html = appendCategory(category)
          ap_html = ap_html + ct_html;
        })
        html_foot=`
                    </select>
                    </div>
                    </div>
                  `
        html = ap_html + html_foot;//後半部分html追加
        $('.ct_box_k').append(html);//子カテゴリセレクトボックス書き込み
      })
      .fail((data) => {
        //失敗した場合の処理
        // console.log(data.responseText);  //レスポンス文字列を表示
      })
  });
  //孫カテゴリセレクトボックス生成
  $(this).on("change", "#category_child", function() {
    child_name = $(this).val();
    if(child_name != "---"){
      $.ajax({
          type: 'GET',
          url: "/users/" + user_id + "/api/products/grand_child",
          data: {id: child_name},
          dataType: 'json'
      })
      .done(function(categories) {
        //孫カテゴリ重複防止
        if($('#ct_no_3').val() != null){
          $('#ct_no_3').remove();
        }
        html_head_g = `
                    <div class="form-input_3" id="ct_no_3" value="ct_no_3">
                      <div class="select-wrap" id="1">
                      <i class="fa fa-chevron-down"></i>
                    <select class="category_grand_child" id="category_grand_child" name="grand" >
                    <option value="---" id = "---">---</option>
                    `
        ap_html_g = html_head_g
        categories.forEach(function(category){
          ct_html_g = appendCategory_g(category)
          ap_html_g = ap_html_g + ct_html_g
        })
        html_foot_g=`
                    </select>
                    </div>
                    </div>
                  `
        html_g = ap_html_g + html_foot_g;
        $('.ct_box_k').append(html_g);
      })
      .fail(function() {
      });
    }
    //子セレクトボックスがプレースホルダなら孫セレクトボックスは表示しない
    if(child_name == "---"){
      $('#ct_no_3').remove();
    }
  });
  //カテゴリーセレクトボックス関連処理ここまで

  $('#product_delivery_fee').change(function() {
    $('#product_delivery_method').remove();
    let selection = $(this).val();
    if (selection!="") {
      $('#product_delivery_fee').after(DeliveryMethodSelectBoxHTML);
    }
  });
  //出品価格が変化したら手数料と利益を更新
  $('#product_price').on('keyup', function(e){
    calcFeeGain();
  });
});
