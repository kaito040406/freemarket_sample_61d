//関数群
/////カテゴリ生成
function appendCategory(ct){
  var html = `
              <option value="${ct.name}" id = "${ct.id}">${ct.name}</option>
              `
  return html;
}

function appendCategory_g(ct){
  console.log(ct.id)
  var html = `
              <option value="${ct.id}" id = "${ct.id}">${ct.name}</option>
              `
  return html;
}


//出品ごとの画像の通し番号
//inputタグのインデックス（=product_image配列のインデックス）は削除で途中が抜けたりするので
//画像が何枚目か全部で何枚あるかこちらで管理




  //////要素ごとのイベント応答群
  //画像サムネイルの削除ボタンを押した時の処理
  // $(document).off('click');//イベント多重化防止
  // $(document).on('click', '.thumbnail__sub__btn', function(e) {//なぜ$()->$(document)だといけたのか未理解
  //   e.preventDefault();
  //   let btnBox =e.target.closest('.thumbnail__sub');
  //   let inputHidden =$(btnBox).prev();
  //   let imgThumbnail = $(inputHidden).prev();
  //   let inputFile = $(inputHidden).prev();
  //   $(inputFile).val(null); // TODO:アップロードされたファイルの削除 countをnull許可にすると途中で削除した画像も保存されてしまう
  //   $(imgThumbnail).remove();
  //   $(inputHidden).remove();
  //   $(btnBox).remove();
  //   labelIndex = youngestInputIndex();
  //   overwriteLabel(labelIndex);
  //   overwriteHiddenCountAll();
  // });
  ///カテゴリセレクトボックス:親->子->孫と出現する
  $('#categry_parent').change(function() {

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
      if($('#kw_no_2').val() != null){
        $('#kw_no_2').remove();
      }
      if($('#kw_no_3').val() != null){
        $('#kw_no_3').remove();
      }
      html_head = `
                  <div class="form-input_2" id="kw_no_2" value="kw_no_2">
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
      // console.log(data.responseText);  //レスポンス文字列を表示
    })
  });

  $(this).on("change", "#category_child", function() {
    var child_name = $(this).val();
    if(child_name != "---"){
      $.ajax({
          type: 'GET',
          url: "/users/" + user_id + "/api/products/grand_child",
          data: {id: child_name},
          dataType: 'json'
      })
    };
  });
