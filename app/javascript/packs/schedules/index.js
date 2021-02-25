document.addEventListener('DOMContentLoaded', () => {
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  // 他のメソッドを実行できるようになるための作業
  liff.init({
    liffId: "1655665365-robLXJ1P"
  })
  // idTokenからユーザーIDを取得し、userテーブルに保存するための処理
  .then(() => {
    const idToken = liff.getIDToken()
    console.log(idToken)
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
      data_id = data
      console.log(data_id)
    })
  })
  .then(() => {
    if (!liff.isLoggedIn()) {
      liff.login();
    }
  })
})
