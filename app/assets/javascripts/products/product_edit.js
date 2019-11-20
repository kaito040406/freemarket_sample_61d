$(function(){
  // editフォームからは実行されない
  pathSelf =location.pathname;
  if (pathSelf.match(/create/) != null) {
      console.log('create doesnt work');
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
    <div class="form-input-t" id="product_delivery_method">
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
    console.log('here is createjs overwriteLabel');
    let updatedFor = 'product_product_images_attributes_'+inputIndex+'_product_image';
    $("[for ^='product_product_images_attributes_']").attr('for', updatedFor);
  }
    //hidden属性で送られるcountの値を今あるimgの連番で振り直し（途中のイメージを削除された時のため）
    //画像が何枚あるか何枚目かはこの値で管理
  function overwriteHiddenCountAll(){
    console.log('here is createjs overwriteHiddenCountAll');
    let count = 1;
    $('.hiddenCount').each(function(){
      $(this).attr('value', count);
      count = count + 1;
    });
  }
  //次の画像のインデックスとしてlabelタグのForに入れるべき番号を取得する
  //（はずだったが他の処理も一部まとめた
  //"画像枚数が変化する(しようとする)際の処理"としてまとめた方がいいかもしれない）
  function youngestInputIndex(){
    console.log('here is createjs youngestInputIndex');
    //サムネイルとセットのhidden要素を全て取得
    let allImgs = $('.hiddenCount');
    //返り値の取りうる最大値
    let nextIndex = $(allImgs).length;
    //10ならば最大枚数アップ済、labelが機能しなくなる値""を返す
    if (nextIndex == 10){
      return "";//
    }
    //0ならばプレースホルダを再表示し0を返す
    //最後の1枚削除によりアップローダーが空になった場合
    else if(nextIndex ==0){
      $('.img-uploader-dropbox pre').show();
      return nextIndex;
    }
  
    //Whileを最大値-1->0へと回しinputが空白だったもので一番小さな値にセット
    let inputTagCounter = nextIndex-1;
      while(0 <= inputTagCounter){
        //hidden要素にはidに`hiddenCount${inputのインデックス番号}`が付けられている
        let filledInputSelecter = "#hiddenCount" + inputTagCounter;
          //lengthメソッドの返り値が0なら要素が存在しない
          console.log('filledInputSelecter');
          console.log(filledInputSelecter);
        if ($(filledInputSelecter).length ==0){
          //サムネイルの無い番号だったならその値へ更新
          nextIndex = inputTagCounter;
          console.log('rewritten');
          console.log($(filledInputSelecter));
          console.log($('#hiddenCount0'));
        }
        inputTagCounter = inputTagCounter -1;
      }
    console.log('last of YII, nextIndex is');
    console.log(nextIndex);
    return nextIndex;
  }
  //labelのfor属性内の数値を返す、他所でも起動しているらしくDOMセレクタ見直し
  //応急処置（たぶん）
  function readLabelIndexCreate(){
      let labelIndex = $('label').attr('for').replace(/[^0-9]/g, '');//数字でない部分を空白へ置換=削除
      labelIndex = Number(labelIndex);//数値型へ変換
      return labelIndex;
  }
  console.log('create');
  //カテゴリーセレクトボックス関連処理
  //ct_no_1＝親カテゴリ、ct_no_2＝子カテゴリ、ct_no_3＝孫カテゴリ
  $('#category_parent').change(function() {
    console.log("ok")
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
                    <div class="form-input-t_2" id="ct_no_2" value="ct_no_2">
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
        console.log(data.responseText);  //レスポンス文字列を表示
      })
  });
  //孫カテゴリセレクトボックス生成
  $(this).on("change", "#category_child", function() {
    child_name = $(this).val();
    if(child_name != "---"){
    console.log(child_name)
      $.ajax({
          type: 'GET',
          url: "/users/" + user_id + "/api/products/grand_child",
          data: {id: child_name},
          dataType: 'json'
      })
      .done(function(categories) {
        //孫カテゴリここでも重複防止必要
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
    //子セレクトボックスがプレースホルダ状態の場合
    if(child_name == "---"){
      $('#ct_no_3').remove();
    }
  });
  //カテゴリーセレクトボックス関連処理ここまで

  //////ここからイメージボックス関連
  let labelIndex = readLabelIndexCreate(); //new.html.hamlで定義される"0"
  $('.img-uploader-dropbox').on('change', 'input[type="file"]', function(e) {
    //inputタグのインデックスを取得する
    labelIndex = readLabelIndexCreate();
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
        console.log('yougestwillcalled');
        labelIndex = youngestInputIndex();
        console.log('labelIndex');
        console.log(labelIndex);
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

  //既存画像の削除ボタンがクリックされた時の処理
  $(document).off('click');//イベント多重化防止
  $(document).on('click', '.exist-img .img-delete-btn', function(e) {//なぜ$()->$(document)だといけたのか未理解
    e.preventDefault();
    console.log($(this).closest('.btn-box').prev().attr('value'));
    if ($(this).closest('.btn-box').prev().attr('value') == 0){
      $(this).closest('.btn-box').prev().attr({'value': 1});
      console.log('delete selected');
    }else{
      $(this).closest('.btn-box').prev().attr({'value': 0});
      console.log('delete cancel');
    }
  });
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