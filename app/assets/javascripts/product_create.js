$(document).on('turbolinks:load', function(){
  //手数料と利益の計算
  $('#product_price').on('keyup', function(e){
    let product_fee_rate = 0.1
    let product_price = $('#product_price').val();
    let product_fee = Math.floor(product_price * product_fee_rate);
    let product_gain = product_price - product_fee;
    $('#product-fee').html(product_fee);
    $('#product-gain').html(product_gain);
  });  

  $('#product_categry').change(function() {
    let selection = $('option:selected').val();
    console.log(selection);
    if (!selection) {
      console.log('default');
    }
  });
});