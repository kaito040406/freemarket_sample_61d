$(document).on('turbolinks:load', function(){
  $('#my_page_k').mouseover(function(){
    if($('.wrapper_user__icon').length){

    }else{
      parent_html = `
      <div class="wrapper">
        <div class="wrapper_user" id="mypage">
          <div class="wrapper_user__icon">
            <div class="opi">
            <figure>
              <img width="60" alt="" height="60" src="https://static.mercdn.net/images/member_photo_noimage_thumb.png">
            </figure>
            </div>
            <h2 class="name">
              ひじ
            </h2>
            <div class="mypage-number">
            <div>
              評価:
            <span>
              0
            </span>
            </div>
        <div>
        出品数:
        <span>
        0
        </span>
        </div>
        </div>
        </div>
        <div class="my-sold">
        <div class="my-sold__money">
        <p>売上金</p>
        <h1>¥0</h1>
        <i class="fa fa-chevron-right my"></i>
        </div>
        <div class="my-sold__point">
        <p>ポイント</p>
        <h1>P0</h1>
        <i class="fa fa-chevron-right my"></i>
        </div>
        <nav class="mypage-nav">
        <ul class="mypage-nav-list">
        <li>
        <div class="mypage-nav-list-item">
        <a href="">いいね！一覧</a>
        <div class="fa fa-chevron-right"></div>
        </div>
        </li>
        <li>
        <div class="mypage-nav-list-item">
        <a href="/users/progress">出品した商品 - 出品中</a>
        <div class="fa fa-chevron-right"></div>
        </div>
        </li>
        <li>
        <div class="mypage-nav-list-item">
        <a href="">出品した商品 - 取引中</a>
        <div class="fa fa-chevron-right"></div>
        </div>
        </li>
        <li>
        <div class="mypage-nav-list-item">
        <a href="">出品した商品 - 売却済み</a>
        <div class="fa fa-chevron-right"></div>
        </div>
        </li>
        <li>
        <div class="mypage-nav-list-item">
        <a href="">購入した商品 - 取引中</a>
        <div class="fa fa-chevron-right"></div>
        </div>
        </li>
        <li>
        <div class="mypage-nav-list-item">
        <a href="">購入した商品 - 過去の取引</a>
        <div class="fa fa-chevron-right"></div>
        </div>
        </li>
        </ul>
        </nav>
        </div>
        </div>
      </div>
      `
      $('#my_page_k').append(parent_html);
    }
  })

  $('#my_page_k').mouseleave(function(){
    $('#mypage').remove()
  })
})



