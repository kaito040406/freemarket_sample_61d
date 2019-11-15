$(document).on('turbolinks:load', function(){
  //newフォームからは実行されない
  let pathSelf =location.pathname;
  if (pathSelf.match(/new/) != null) {
    // console.log('edit doesnt work');
    return false;
  }
  
  //1枚以上の画像はあるため最初はプレースホルダ非表示
  $('.img-uploader-dropbox pre.edit-form').hide();

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

function overwriteLabel(inputIndex){
  let updatedFor = 'product_product_images_attributes_'+inputIndex+'_product_image';
  $("[for ^='product_product_images_attributes_']").attr('for', updatedFor);
}

//出品ごとの画像の通し番号
//inputタグのインデックス（=product_image配列のインデックス）は削除で途中が抜けたりするので
//画像が何枚目か全部で何枚あるかこちらで管理
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

//候補画像枚数が変化した時に呼び出され、labelタグの番号を取得・更新する
//（はずだったが他の処理も一部まとめた
//"画像枚数が変化する際の処理"としてまとめた方がいいかもしれない）
function youngestInputIndex(){
  //サムネイルとセットのhidden要素を全て取得
  let allImgs = $('.hiddenCount');
  //youngestInputIndexの最大値
  let nextIndex = $(allImgs).length;
  //10ならば最大枚数アップされている
  if (nextIndex == 10){
    return "";//labelが機能しないようにする
  }
  //0ならばプレースホルダを再表示し、終了
  //最後の1枚削除によりアップローダーが空になった場合
  else if(nextIndex ==0){
    $('.img-uploader-dropbox pre').show();
    return nextIndex;
  }

  //Whileを最大値-1->0へと回しinputが空白だったもので一番小さな値にセット
  let inputTagCounter = nextIndex - 1;
    while(0 <= inputTagCounter){
      //hidden要素にはidに`hiddenCount${inputのインデックス番号}`が付けられている
      let filledInputSelecter = "#hiddenCount" + inputTagCounter;
        //lengthメソッドの返り値が0なら要素が存在しない
      if ($(filledInputSelecter).length ==0){
        //サムネイルの無い番号だったならその値へ更新
        nextIndex = inputTagCounter;
      }
      inputTagCounter = inputTagCounter -1;
    }
  return nextIndex;
}
function readLabelIndex(){
  path = location.pathname
  product_id = $(".form-sub-t").attr("value")
  if(path == "/products/" + product_id + "/edit"){




    
    let labelIndex = $('label').attr('for').replace(/[^0-9]/g, '');//数字でない部分を空白へ置換=削除
    labelIndex = Number(labelIndex);//数値型へ変換
    return labelIndex;
  }
}
//hidden属性で送られるcountの値を今あるimgの連番で振り直し（途中のイメージを削除された時のため）


////////ここからイメージボックス関連
  let labelIndex = readLabelIndex(); //new.html.hamlで定義される"0"
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

    //ファイルリーダーがファイルを読み終わったら行うサムネイル生成などの関連処理
    //(関数として切り出すとサムネイルが表示されなくなったため保留//
    //e.target.resultを変数に代入もできないためそのあたりの影響とかんがえられる)
    let reader = new FileReader();
    let changedInput = $(e.target);
    //を付与
    reader.onload = function (e){
      let imageThumbnail =`
        <img src="${e.target.result}" width="114px" height="116px" 
          class="thumbnail" title="${file.name}" >
        <input type="hidden" 
          name="product[product_images_attributes][${labelIndex}][count]" 
          value="${labelIndex}"
          id = "hiddenCount${labelIndex}"
          class = "hiddenCount">
        <div class="btn-box">
          <div class="img-edit-btn">編集</div>
          <div class="img-delete-btn">削除</div>
        </div>
        `;
      $(changedInput).after(imageThumbnail);
      $(changedInput).ready(function(){ //  この記述でDOM要素読み込まれるまで待つらしい
        //次のchangeイベントでのinputタグ(product_model)を更新
        labelIndex = youngestInputIndex();

        overwriteLabel(labelIndex);
        overwriteHiddenCountAll();
        //プレースホルダ非表示
        $('.img-uploader-dropbox pre').hide();
        
      });
    };
    ///ファイル読み込み 上記サムネイル・編集削除ボタン・count値のhidden input生成等が行われる
    reader.readAsDataURL(file);
    //サムネイルと編集削除ボタン生成ここまで//

  });

  //削除ボタンを押した時の処理
  $(document).off('click');//イベント多重化防止
  $(document).on('click', '.img-delete-btn', function(e) {//なぜ$()->$(document)だといけたのか未理解
    e.preventDefault();
    let btnBox =e.target.closest('.btn-box');
    let inputHidden =$(btnBox).prev();
    let imgThumbnail = $(inputHidden).prev();
    let inputFile = $(inputHidden).prev();
    $(inputFile).val(null); // TODO:アップロードされたファイルの削除 countをnull許可にすると途中で削除した画像も保存されてしまう
    $(imgThumbnail).remove();
    $(inputHidden).remove();
    $(btnBox).remove();
    labelIndex = youngestInputIndex();
    overwriteLabel(labelIndex);
    overwriteHiddenCountAll();
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
