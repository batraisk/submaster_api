guardHashId = () => {
  if (!localStorage.getItem('hashid')) {
    const url = window.location.pathname.match('pages\/(.*?)\/enter_login')[1];
    window.location.href = `/pages/${url}/welcome`;
  }
}

checkAccess = (url) => {
  const urlSearchParams = new URLSearchParams(window.location.search);
  const params = Object.fromEntries(urlSearchParams.entries());
  const username = localStorage.getItem('username')
  if (!username || !params.action || params.action !== 'check') { return; }
  // check(url)
  // isSubscribeHandler(username, url)
  setChecking();
  fetch(`/pages/${url}/check_login_follow?name=${username}`).then(res =>
    res.json().then(resp => {
      unSetChecking();
      if (resp.is_follow === true) {
        isSubscribeHandler(username, url)
      }
      if (resp.is_follow == false) {
        const modal = document.getElementById("myModal");
        modal.style.display = "block";
        const modalNickname = document.getElementById('modal-nickname')
        modalNickname.innerText = username;
      }
    }, ()=>{
      unSetChecking();
    }));
}

guardHashId()