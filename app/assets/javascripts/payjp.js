document.addEventListener("DOMContentLoaded",function(){
  var select_month = $("#payment_card_expire_mm");
  var select_year = $("#payment_card_expire_yy");
  select_month.attr("selected","selected");
  select_year.attr("selected","selected");


  var form = $("#add-card-form");
    Payjp.setPublicKey("pk_test_51c77c8e0cd7bb394b466375");

  $("#submit_btn").on("click",function(e){
    e.preventDefault();
    var card = {
      number: $("#payment_card_no").val(),
      cvc: $("#payment_card_security_code").val(),
      exp_month: $("#payment_card_expire_mm").val(),
      exp_year: $("#payment_card_expire_yy").val()
    };
    Payjp.createToken(card,function(status,response){
      form.find("input[type=button]").prop("disabled", true);
      if(status == 200){
        $("#payment_card_no").removeAttr("name");
        $("#payment_card_security_code").removeAttr("name");
        $("#payment_card_expire_mm").removeAttr("name");
        $("#payment_card_expire_yy").removeAttr("name"); //データを自サーバにpostしないように削除
        var payjphtml = `<input type="hidden" name="payjpToken" value=${response.id}>`
        form.append(payjphtml);
        document.inputForm.submit();
      }else{
        alert("カード情報が正しくありません。");
      }
    });
  });
  false;
});
