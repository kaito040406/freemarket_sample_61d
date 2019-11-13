let CategorySelectBoxHTML = `
<div class="select-wrap">
  <i class="icon-arrow-bottom"></i>
  <select class="select-default" name="product[categry]" id="product_categry"><option value="">---</option>
  <option value="レディース">レディース</option>
  <option value="メンズ">メンズ</option>
  <option value="ベビー・キッズ">ベビー・キッズ</option>
  <option value="インテリア・住まい・小物">インテリア・住まい・小物</option>
  <option value="本・音楽・ゲーム">本・音楽・ゲーム</option>
  <option value="おもちゃ・ホビー・グッズ">おもちゃ・ホビー・グッズ</option>
  <option value="コスメ・香水・美容">コスメ・香水・美容</option>
  <option value="家電・スマホ・カメラ">家電・スマホ・カメラ</option>
  <option value="スポーツ・レジャー">スポーツ・レジャー</option>
  <option value="ハンドメイド">ハンドメイド</option>
  <option value="チケット">チケット</option>
  <option value="自動車・オートバイ">自動車・オートバイ</option>
  <option value="その他">その他</option></select>
</div>`

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

function appendProductImageForm(inputIndex){
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
//画像inputフォームの識別数字（削除で通し番号ではなくなる）
//と思ったがproduct_imgオブジェクトが10個、それに対応するフォームが10個までインデックスで9まで、であるため
//結局番号の振り直し必須、10個のフォームには区別要かもしれない
//labelのfor属性の属性値内の番号（＝クリックで起動するinputの番号）を引数に更新
function overwriteLabel(inputIndex){
  let updatedFor = 'product_product_images_attributes_'+inputIndex+'_product_image';
  $("[for ^='product_product_images_attributes_']").attr('for', updatedFor);
}

function youngestInputIndex(){
  let inputIndex;
  inputIndex = countImgForm();
  return inputIndex;
}
function countImgForm(){//今アップロード候補に入ってる画像の総数を数える
  let imgFormCount = 0;//並べる時の順番作成にも必要と思われる
  $('.img-uploader-dropbox input[type="file"]').each(function(){
    imgFormCount = imgFormCount + 1;
  });
  return imgFormCount;//DBに記録される画像の総数);
}

function getLabelForIndex(){
  let labelForIndex = $('label').attr('for').replace(/[^0-9]/g, '');//数字でない部分を空白へ置換=削除
  labelForIndex = Number(labelForIndex);//数値型へ変換
  return labelForIndex;
  }
//updateImgCount()
//hidden属性で送られるcountの値を今あるimgの連番で振り直し（途中のイメージを削除された時のため）

/////////////////////////////////////
/////本体ここから//////////////////////
/////////////////////////////////////

$(document).on('turbolinks:load', function(){
  let labelForIndex = getLabelForIndex(); //new.html.hamlで定義される"0"
  appendProductImageForm(labelForIndex);

  $('.img-uploader-dropbox').on('change', 'input[type="file"]', function(e) {
    //inputタグのインデックスを取得する
    let labelForIndex = getLabelForIndex();
    // 11枚目なら中断
    if(labelForIndex >= 10){//inputタグで検出するのでダイアログは表示される
      return false;
    }
    let file = e.target.files[0];
    // 画像ファイル以外なら中断
    if(file.type.indexOf("image") < 0){
      return false;
    }

    //サムネイルと編集削除ボタン生成//
    //(関数として切り出すとサムネイルが表示されなくなったため保留)//
    let reader = new FileReader();
    let changedInput = $(e.target);
    //hidden属性でproduct_image:[:count]の値を付与
    reader.onload = function (e){
      let imageThumbnail =`
        <img src="${e.target.result}" width="114px" height="116px" 
        class="thumbnail" title="${file.name}" >
        <input type="hidden" 
          name="product[product_images_attributes][${labelForIndex}][count]" 
        value=${labelForIndex}>
        <div class="btn-box">
          <div class="img-edit-btn">編集</div>
          <div class="img-delete-btn">削除</div>
        </div>
        `;
      $(changedInput).after(imageThumbnail);
    };
    reader.readAsDataURL(file);
    //サムネイルと編集削除ボタン生成ここまで//

    //次のchangeイベントでのinputタグ(product_model)を更新
    labelForIndex = youngestInputIndex();
    overwriteLabel(labelForIndex);
    appendProductImageForm(labelForIndex);

    //プレースホルダの表示・非表示処理
    $('.img-uploader-dropbox pre').hide();
    if(labelForIndex== 0){
      $('.img-uploader-dropbox pre').show();
    }
  });
  //画像選択により生成された要素の削除
  $('.product_image_box').on('click', '.img-delete-btn', function(e) {
    e.preventDefault();
    let box =e.target.closest('.product_image_box');
    $(box).remove();
    let labelForIndex = youngestInputIndex();
    overwriteLabel(labelForIndex);
    console.log(labelForIndex);
    if(labelForIndex== 0){

      $('.img-uploader-dropbox pre').show();
    }
  });

  $('#product_categry').change(function() {
    let selection = $('option:selected').val();
    $('#product_categry').after(CategorySelectBoxHTML);
    if (!selection) {
      //
    }
  });

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