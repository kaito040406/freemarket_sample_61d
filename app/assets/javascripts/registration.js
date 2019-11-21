$(function () {
  var birthday_year = [];
  var birthday_manth = [];
  var months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  var date = new Date();
  var this_year = date.getFullYear();
  var oldest_year = 1900;

  // 誕生年月の配列を自動生成
  for (var i = this_year; i >= oldest_year; i--) {
    var year = { var: i, txt: String(i) };
    birthday_year.push(year);
  }
  for (var i = 1; i <= 12; i++) {
    var month = { var: i, txt: String(i) };
    birthday_manth.push(month);
  }
  // hamlの年と月のセレクトボックスに配列内容を反映させる
  for (var i = 0; i < birthday_year.length; i++) {
    $("<option>", {
      value: birthday_year[i].var,
      text: birthday_year[i].txt
    }).appendTo('#user_birthday_year');
  }
  for (var i = 0; i < birthday_manth.length; i++) {
    $("<option>", {
      value: birthday_manth[i].var,
      text: birthday_manth[i].txt
    }).appendTo('#user_birthday_manth');
  }

  // 年、もしくは月のセレクトボックスの中身に変更があったら日の内容を変更する
  $('#user_birthday_year, #user_birthday_manth').change(function () {
    // 日が入っているセレクトボックスの中身を空っぽにする
    $('#user_birthday_day').empty();
    // 日が入るセレクトボックスにデフォルト値の'--'を入れる
    $("<option>", {
      text: '--'
    }).appendTo('#user_birthday_day');
    // ２月の日にち、すなわちmonths[1]を28にセットし直す
    months[1] = 28;
    //　年と月に入力されている情報を取得する
    var year = $('#user_birthday_year').val();
    var month = $("#user_birthday_manth").val();
    // yearとmonth共に数字が入力されている、すなわち共に'--'でないときに実行
    if (year != '--' && month != '--') {
      // monthに２月が選択されている時実行
      if (month == 2) {
        // yearが閏年の時、2月の日付が格納されているmonths[1]の値を29にする
        if (year % 4 == 0 && year % 100 == 0 && year % 400 == 0) {
          months[1] = 29;
        }
      }
      // 日を入れる配列を宣言し、閏年を考慮したデータを格納してhamlの日の
      // セレクトボックスに反映させる
      var user_birthday_day = []
      for (var i = 1; i <= months[month - 1]; i++) {
        var day = { var: i, txt: String(i) };
        user_birthday_day.push(day);
      }
      for (var i = 0; i < user_birthday_day.length; i++) {
        $("<option>", {
          value: user_birthday_day[i].var,
          text: user_birthday_day[i].txt
        }).appendTo('#user_birthday_day');
      };
    };
  });
});