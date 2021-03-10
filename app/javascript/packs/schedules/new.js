document.addEventListener('DOMContentLoaded', () => {
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  // 他のメソッドを実行できるようになるための作業
  liff.init({
    liffId: "1655665365-robLXJ1P"
  })
  .then(() => {
    if (!liff.isLoggedIn()) {
      liff.login();
    }
  })
  // idTokenからユーザーIDを取得し、userテーブルに保存するための処理
  .then(() => {
    const idToken = liff.getIDToken()
    const body =`idToken=${idToken}`
    const request = new Request('/users', {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
        'X-CSRF-Token': token
      },
      method: 'POST',
      body: body
    });

    fetch(request)
    .then(response => response.json())
    .then(data => {
      data_id = data.id
    })
  })

  // フォームの内容をpostしてokが返ってきたらshareTargetPickerを開く
  const postFormElm = document.querySelector('#form')
  postFormElm.addEventListener('ajax:success', (e) => {

    // ここでshared target pickerを呼び出す
    const redirect_url = `https://liff.line.me/1655665365-robLXJ1P/schedules/${e.detail[0].token}`
    liff.shareTargetPicker([
      message = {
        "type": "template",
        "altText": "デートのおさそいが届いています",
        "template": {
            "thumbnailImageUrl": "https://res.cloudinary.com/dr1peiwz2/image/upload/v1613642190/girl_ymjnoj.jpg",
            "type": "buttons",
            "title": "デートのおさそい",
            "text": "大好きなあなたとデートに行きたいです！",
            "actions": [
                {
                  "type": "uri",
                  "label": "デートの詳細はここから確認してね！",
                  "uri": redirect_url
                }
            ]
        }
      }
    ]).then((res) => {
      if (res) {
        // TargetPickerが送られたら
        liff.closeWindow();
      } else {
        // TargetPickerを送らずに閉じたら
        console.log('TargetPicker was closed!')
        liff.closeWindow();
      }
    }).catch(function (res) {
      alert("送信に失敗しました…")
    });
  })
})