document.addEventListener('DOMContentLoaded', () => {
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  // 他のメソッドを実行できるようになるための作業
  liff.init({
    liffId: "1655665365-robLXJ1P"
  })
  // idTokenからユーザーIDを取得し、userテーブルに保存するための処理
  .then(() => {
    const idToken = liff.getIDToken();
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
  })
  .then(() => {
    if (!liff.isLoggedIn()) {
      liff.login();
    }
  })
  .then(() => {
    const params = new URLSearchParams(window.location.search);
    const schedule_token = params.get('token')
    const redirect_url = `https://liff.line.me/1655665365-robLXJ1P/schedules/${schedule_token}`
    window.location = redirect_url
  })
})
