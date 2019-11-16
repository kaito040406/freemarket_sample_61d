(function() {
  "use strict";
  //エスケープ

  function calcFeeGain(){
    let product_fee_rate = 0.1;
    let product_price = $('#product_price').val();
    let product_fee = Math.floor(product_price * product_fee_rate);
    let product_gain = product_price - product_fee;
    $('#product-fee').html(product_fee);
    $('#product-gain').html(product_gain);
  }

  window.productsLib= window.productsLib|| {};
  window.productsLib.calcFeeGain = calcFeeGain;
})();