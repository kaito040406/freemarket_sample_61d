document.addEventListener("DOMContentLoaded",function(){
  var select_month = $(".select--item--month[value=12]");
  var select_year = $(".select--item--year[value=2020]");
  select_month.attr("selected","selected");
  select_year.attr("selected","selected");


  var form = $("#card__form");
  Payjp.setPublicKey("pk_test_f7605539c63c593a5b5ebfed");

  $("#submit_btn").on("click",function(e){
    e.preventDefault();
    var card = {
      number: $("#card_number").val(),
      cvc: $("#card_cvc").val(),
      exp_month: $("#card_month").val(),
      exp_year: $("#card_year").val()
    };
    Payjp.createToken(card,function(status,response){
      form.find("input[type=submit]").prop("disabled", true);
      if(status == 200){
        $("#card_number").removeAttr("name");
        $("#card_cvc").removeAttr("name");
        $("#card_month").removeAttr("name");
        $("#card_year").removeAttr("name"); //データを自サーバにpostしないように削除
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
