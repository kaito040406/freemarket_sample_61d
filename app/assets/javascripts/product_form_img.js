$(function(){
  console.log('form');
  // editフォームからは実行されない
  pathSelf =location.pathname;
  if (pathSelf.match(/edit/) != null) {
      return false;
  }
  //hidden属性で送られるcountの値を今あるimgの連番で振り直し（途中のイメージを削除された時のため）
  //画像が何枚あるか何枚目かはこの値で管理
  function overwriteHiddenCountAll(){
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
    //サムネイルとセットのhiddenCount要素を全て取得
    let allImgs = $('.hiddenCount');
    let nextIndex = $(allImgs).length;
    //10ならば最大枚数アップ済、labelが機能しなくなる値""を返す
    if (nextIndex == 10){
      return "";//
    }
    //0ならばプレースホルダを再表示し0を返す
    //最後の1枚削除によりアップローダーが空になった場合
    else if(nextIndex ==0){
      $('.dropbox__placeholder').show();
      return nextIndex;
    }
    //この時点でnextIndexは返り値の取りうる最大値
    //Whileを最大値->0へと回しinputが空白だったもので一番小さな値にセット
    let inputTagCounter = nextIndex;
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
  //labelのfor属性内の数値を返す、他所でも起動しているらしくDOMセレクタ見直し
  //応急処置（たぶん）
  function readLabelIndexCreate(){
    let labelIndex = $('label').attr('for').replace(/[^0-9]/g, '');//数字でない部分を空白へ置換=削除
    labelIndex = Number(labelIndex);//数値型へ変換
    return labelIndex;
  }
  function overwriteLabel(inputIndex){
    let updatedFor = 'product_product_images_attributes_'+inputIndex+'_product_image';
    $("[for ^='product_product_images_attributes_']").attr('for', updatedFor);
  }
  //削除ボタンを押した時の処理///////発火しない、原因がわからない修理要//////
  $(document).off('click');
  $(document).on('click', '.added-img-delete-btn', function(e) {//なぜ$()->$(document)だといけたのか未理解
    console.log('added-img-delete-btn was clicked');
    e.preventDefault();
    let btnBox =e.target.closest('.thumbnail__sub');
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
  let labelIndex = readLabelIndexCreate(); //new.html.hamlで定義される"0"
  $('.image-form').on('change', 'input[type="file"]', function(e) {
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
    // let changedInput = $(e.target);
    //を付与
    reader.onload = function (e){
      let imageThumbnail =`
        <div class="product-img-box added-img">
          <img src="${e.target.result}" width="114px" height="116px" 
            class="thumbnail" title="${file.name}" >
          <input type="hidden" 
            name="product[product_images_attributes][${labelIndex}][count]" 
            value="${labelIndex}"
            id = "hiddenCount${labelIndex}"
            class = "hiddenCount">
          <div class="thumbnail__sub">
            <div class="thumbnail__sub__btn">編集</div>
            <div class="added-img-delete-btn thumbnail__sub__btn">削除</div>
          </div>
        </div>
        `;
      $('.create-dropbox__label').before(imageThumbnail);
      $('.create-dropbox__label').ready(function(){ //  この記述でDOM要素読み込まれるまで待つらしい
        //次のchangeイベントでのinputタグ(product_model)を更新
        labelIndex = youngestInputIndex();
        overwriteLabel(labelIndex);
        overwriteHiddenCountAll();
        //プレースホルダ非表示
        $('.dropbox__placeholder').hide();
        
      });
    };
    ///ファイル読み込み 上記サムネイル・編集削除ボタン・count値のhidden input生成等が行われる
    reader.readAsDataURL(file);
    //サムネイルと編集削除ボタン生成ここまで//

  });
});
