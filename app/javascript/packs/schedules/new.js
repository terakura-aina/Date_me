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
  // .then(() => {
  //   const idToken = liff.getIDToken()
  //   console.log(idToken)
  //   const body =`idToken=${idToken}`
  //   const request = new Request('/users', {
  //     headers: {
  //       'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
  //       'X-CSRF-Token': token
  //     },
  //     method: 'POST',
  //     body: body
  //   });

  //   fetch(request)
  //   .then(response => response.json())
  //   .then(data => {
  //     data_id = data.id
  //   })
  // })

  // フォームの内容をpostしてokが返ってきたらshareTargetPickerを開く
  const postFormElm = document.querySelector('#form')
  postFormElm.addEventListener('ajax:success', (e) => {
    console.log(e.detail[0])

    // ここでshared target pickerを呼び出す
    const redirect_url = `https://liff.line.me/1655592642-mxP7Mkkp/schedules/${e.detail[0].token}`
    liff.shareTargetPicker([
      {
      'type': 'text',
      'text': 'デートのお誘いです'
      },
      {
      'type': 'text',
      'text': redirect_url
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