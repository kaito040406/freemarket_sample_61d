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
    style="display: none;">
  </div>`;
$('.img-uploader-dropbox').append(ProductImageInputHTML);
}
//labelのfor属性の属性値内の番号（＝クリックで起動するinputの番号）を引数に更新
function updateNextImageNum(inputIndex){
  let updatedFor = 'product_product_images_attributes_'+inputIndex+'_product_image';
  //書き換え
  $("[for ^='product_product_images_attributes_']").attr('for', updatedFor);
}

let imgFormCount = 0;
function countImgForm(){
  $('.img-uploader-dropbox input').each(function(){
    imgFormCount++;
  });
}

$(document).on('turbolinks:load', function(){
  //画像アップロードフォームを全て取得、非表示に
  let fileForms = $("[type=file]");
  $(fileForms).hide();
  console.log(imgFormCount);

  $('.img-uploader-dropbox').on('change', 'input[type="file"]', function(e) {
    let file = e.target.files[0];
    let reader = new FileReader();
    let changedInput = $(e.target);

    reader.onload = function(e) {
      // 領域の中にロードした画像を表示するimageタグを追加
      let imageThumbnail =`
      <img src="${e.target.result}" width="114px" height="116px" 
        class="thumbnail" title="${file.name}" >
      <div class="btn-box" height ="15px">
        <a href ="" >編集</a>
        <a href ="" >削除</a>
      </div>
      `;//タグは生成されてるが表示されない。。css見直し要
      $(changedInput).after(imageThumbnail);
    };

    reader.readAsDataURL(file);
    // 画像ファイル以外なら中断
    if(file.type.indexOf("image") < 0){
        return false;
    }

    //hidden属性でproduct_image: count:の値を付与
    //アップロードされたinputタグのidから数字部分を取り出す
    productImgIndex = $(e.target).attr('id').replace(/[^0-9]/g, '');//数字でない部分を空白へ置換=削除
    productImgIndex = Number(productImgIndex);//数値型へ変換
    //product_image: count:のhtml生成
    let ProductImageCountAttrHTML = `
    <input type="hidden" 
    name="product[product_images_attributes][${productImgIndex}][count]" 
    value=${productImgIndex}>
    `;
    $(e.target).after(ProductImageCountAttrHTML); //hiddenタグ書き込み


    //ドロップボックスのラベルが指すアップローダーを更新
    if (productImgIndex <= 9){
      let incrementedProductImgIndex = productImgIndex + 1;
      updateNextImageNum(incrementedProductImgIndex);
    }
    appendProductImageForm(10);
      //$(e.target).show(); //表示する
      $('.img-uploader-dropbox pre').hide();
      //imgがなければ
      //$('.img-uploader-dropbox pre').show();
    
  });

  $('#product_categry').change(function() {
    let selection = $('option:selected').val();
    console.log(selection);
    $('#product_categry').after(CategorySelectBoxHTML);
    if (!selection) {
      console.log('default');
    }
  });

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