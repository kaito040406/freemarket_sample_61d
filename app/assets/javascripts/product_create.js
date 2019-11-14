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




$(function(){
  function appendCategory(ct){
    var html = `
                <option value="${ct.name}" id = "${ct.id}">${ct.name}</option>
                `
    return html;
    }



  $('#category_parent').change(function() {
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
      .done(function(categories){
        if($('#ct_no_2').val() != null){
          $('#ct_no_2').remove();
        }
        if($('#ct_no_3').val() != null){
          $('#ct_no_3').remove();
        }
        html_head = `
                    <div class="form-input-t_2" id="ct_no_2" value="ct_no_2">
                      <div class="select-wrap" id="1">
                      <i class="fa fa-chevron-down"></i>
                    <select class="category_child" id="category_child" name="child">
                    <option value="---" id = "---">---</option>
                    `
        ap_html = html_head
        categories.forEach(function(category){
          ct_html = appendCategory(category)
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
  
  $(this).on("change", "#category_child", function() {
    var child_name = $(this).val();
    if(child_name != "---"){
    console.log(child_name)
      $.ajax({
          type: 'GET',
          url: "/users/" + user_id + "/api/products/grand_child",
          data: {id: child_name},
          dataType: 'json'
      })
      .done(function(categories) {
        if($('#ct_no_3').val() != null){
          $('#ct_no_3').remove();
        }
        html_head_g = `
                    <div class="form-input-t_3" id="ct_no_3" value="ct_no_3">
                      <div class="select-wrap" id="1">
                      <i class="fa fa-chevron-down"></i>
                    <select class="category_grand_child" id="category_grand_child" name="grand" >
                    <option value="---" id = "---">---</option>
                    `
        ap_html_g = html_head_g
        categories.forEach(function(category){
          ct_html_g = appendCategory(category)
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
    if(child_name == "---"){
      $('#ct_no_3').remove();
    }
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

function generateProductImageForm(inputIndex){
  let ProductImageInputHTML = `
    <div class="product_image_box">
      <input type="file" 
      name="product[product_images_attributes][${inputIndex}][product_image]" 
      id="product_product_images_attributes_${inputIndex}_product_image" 
      style="display:none;"
      >
    </div>`;

  $('.img-uploader-dropbox').append(ProductImageInputHTML);
  $(ProductImageInputHTML).hide();
}
function overwriteLabel(inputIndex){
  let updatedFor = 'product_product_images_attributes_'+inputIndex+'_product_image';
  $("[for ^='product_product_images_attributes_']").attr('for', updatedFor);
}

//出品ごとの画像の通し番号
//inputタグのインデックス（=product_image配列のインデックス）は画像の削除で途中が抜けたりするので
//画像が何枚目か、全部で何枚あるかはこちらで管理
function overwriteHiddenCountAll(){
  let count = 1;
  $('.img-uploader-dropbox input[type="hidden"]').each(function(){
    overwriteHiddenCountEach(this, count)
    count = count + 1;
  });
}
function overwriteHiddenCountEach(hiddenTag, count){
  $(hiddenTag).attr('value', count);
}

//inputタグのインデックス（=product_image配列のインデックス）にの処理はこちら
//
function youngestInputIndex(){
  //選択済み画像のDOM要素を全て取得
  let allImgs = $('.hiddenCount');
  //アップロード画像群の通し番号に抜けがなければ
  //今の最大インデックス数+1(サムネイル数)がlabelが指す空インプットのインデックス
  let nextIndex = $(allImgs).length;
  //サムネイル＝選択されてる画像の数
  let ImgsCount = $(allImgs).length;
  //(10ならば最大枚数アップされている)

  //(Whileを最大値->最小値へと回す
  //
  let inputTagCounter = ImgsCount - 1;
    //できるだけ小さい、空いてるinputIndexを探しindexを取得
    while(0 <= inputTagCounter){
      let filledInputSelecter = "#hiddenCount" + inputTagCounter;
      if ($(filledInputSelecter).length ==0){
        nextIndex = inputTagCounter;
      }
      inputTagCounter = inputTagCounter -1;
    }
  console.log('EndOfyoungestInputIndex');
  console.log(nextIndex);
  return nextIndex;
}
function readLabelIndex(){
  let labelIndex = $('label').attr('for').replace(/[^0-9]/g, '');//数字でない部分を空白へ置換=削除
  labelIndex = Number(labelIndex);//数値型へ変換
  return labelIndex;
}
//updateImgCount()
//hidden属性で送られるcountの値を今あるimgの連番で振り直し（途中のイメージを削除された時のため）

/////////////////////////////////////
/////本体ここから//////////////////////
/////////////////////////////////////
// $(document).on('turbolinks:load', function(){
  let labelIndex = readLabelIndex(); //new.html.hamlで定義される"0"
  generateProductImageForm(labelIndex);

  $('.img-uploader-dropbox').on('change', 'input[type="file"]', function(e) {
    //inputタグのインデックスを取得する
    labelIndex = readLabelIndex();
    // 11枚目なら中断
    if(labelIndex >= 10){//inputタグで検出するのでダイアログは表示される
      return false;
    }
    let file = e.target.files[0];
    // 画像ファイル以外なら中断
    if(file.type.indexOf("image") < 0){
      return false;
    }

    //サムネイル・編集削除ボタン・hidden属性によるcount値生成//
    //(関数として切り出すとサムネイルが表示されなくなったため保留)//
    //e.target.resultを変数に代入もできないためそのあたりの影響とかんがえられる//
    let reader = new FileReader();
    let changedInput = $(e.target);
    //を付与
    reader.onload = function (e){
      let imageThumbnail =`
        <img src="${e.target.result}" width="114px" height="116px" 
        class="thumbnail" title="${file.name}" >
        <input type="hidden" 
          name="product[product_images_attributes][${labelIndex}][count]" 
          value=${labelIndex} 
          id = "hiddenCount${labelIndex}"
          class = "hiddenCount">
        <div class="btn-box">
          <div class="img-edit-btn">編集</div>
          <div class="img-delete-btn">削除</div>
        </div>
        `;
      $(changedInput).after(imageThumbnail);

      $(changedInput).ready(function(){ //  この記述でDOM要素読み込まれるまで待つらしい
        console.log("imageThumbnailonready");
        labelIndex = youngestInputIndex();
        console.log(labelIndex);
        overwriteLabel(labelIndex);
        generateProductImageForm(labelIndex);
        overwriteHiddenCountAll();
        //プレースホルダの表示・非表示処理
        $('.img-uploader-dropbox pre').hide();
        
      });
    };
    //次のchangeイベントでのinputタグ(product_model)を更新

    reader.readAsDataURL(file);
    //サムネイルと編集削除ボタン生成ここまで//

  });

  //削除ボタンを押した時の処理
  $(document).off('click');//イベント多重化防止
  $(document).on('click', '.img-delete-btn', function(e) {//なぜ$(document)だといけたのか未理解
    e.preventDefault();
    let box =e.target.closest('.product_image_box');
    $(box).remove();
    //削除によりアップローダーが空になった場合
    //（一旦最大までアップロードしてから0まで削除）はindex0のものを生成
    if($('.img-uploader-dropbox input[type="file"]').length == 0){
      $('.img-uploader-dropbox pre').show();
      generateProductImageForm(0);
    }
    labelIndex = youngestInputIndex();
    overwriteLabel(labelIndex);
    overwriteHiddenCountAll();
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
    $('#product_delivery_fee').after(DeliveryMethodSelectBoxHTML);
    if (!selection) {
      //
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