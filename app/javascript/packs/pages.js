save = () => {
  const value = document.getElementById('name').value;
  localStorage.setItem('name', value);
}
check = (url) => {
  const value = localStorage.getItem('name')
  fetch(`/pages/${url}/check_login_follow?name=${value}`).then(res =>
    res.json().then(resp => {
      if (resp.is_follow) alert('вы подписаны')
      if (resp.is_follow == false) alert('вы не подписаны')
    }));
}

getAccess = (username, url) => {
  if (!username) {
    alert('введите никнейм');
    return;
  }
  setChecking();
  fetch(`/pages/${url}/check_login_follow?name=${username}`).then(res =>
    res.json().then(resp => {
      unSetChecking();
      if (resp.is_follow) alert('вы подписаны')
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

setChecking = () => {
  const checkBtn = document.getElementById('check-btn');
  const checkingBtn = document.getElementById('checking-btn');
  checkBtn.classList.remove("d-flex");
  checkBtn.classList.add("hidden");
  checkingBtn.classList.remove("hidden");
  checkingBtn.classList.add("d-flex");
}

unSetChecking = () => {
  const checkBtn = document.getElementById('check-btn');
  const checkingBtn = document.getElementById('checking-btn');
  checkBtn.classList.add("d-flex");
  checkBtn.classList.remove("hidden");
  checkingBtn.classList.add("hidden");
  checkingBtn.classList.remove("d-flex");
}






