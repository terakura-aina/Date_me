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
  .then(() => {

    // partnerのline_user_idを保存するための処理
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
      dataId = data.id
    })
    .then(() => {
      const postForm = document.querySelector('#ng')
      postForm.addEventListener('ajax:success', () => {
        liff.closeWindow();
      })
      const postFormElm = document.querySelector('#ok')
      postFormElm.addEventListener('ajax:success', (e) => {
        console.log(e.detail[0])
        const scheduleToken = e.detail[0].token

        // make_plansテーブルに保存するための処理
          const data =`idToken=${idToken}&dataId=${dataId}&scheduleToken=${scheduleToken}`
          const req = new Request('/make_plans', {
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
              'X-CSRF-Token': token
            },
            method: 'POST',
            body: data
          });

          fetch(req)
          .then(response => response.json())
          .then(data => {
            data_id = data.id
          })
        .then(() => {
          liff.closeWindow();
        })
        .catch((err) => {
          console.log(err.code, err.message);
        });
      })
    })
  })
})
