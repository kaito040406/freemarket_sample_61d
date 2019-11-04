$(document).on('turbolinks:load', function(){
  $('#product_price').on('keyup', function(e){
    let product_fee_rate = 0.1
    let product_price = $('#product_price').val();
    let product_fee = product_price * product_fee_rate;
    let product_gain = product_price - product_fee;
    $('.product-fee').html(product_fee);
    $('.product-gain').html(product_gain);
  });
});