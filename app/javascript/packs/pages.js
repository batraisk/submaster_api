save = () => {
  const value = document.getElementById('name').value;
  localStorage.setItem('name', value);
}
check = (url) => {
  const value = localStorage.getItem('name')
  fetch(`/pages/${url}/check_login_follow?name=${value}`).then(res =>
    res.json().then(resp => {
      if (resp.is_follow) {
        alert('вы подписаны')
      }
      if (resp.is_follow == false) alert('вы не подписаны')
    }));
}

isSubscribeHandler = (username, url) => {
  localStorage.setItem('username', username);
  window.location.href = `/pages/${url}/success`;
}

isValidNickname = (username) => {
  let valid = true;
  ['@', '*', ' '].forEach(sym => {
    if (username.includes(sym)) {
      valid = false
    }
  })
  return valid
}
getAccess = (username, url) => {
  if (!isValidNickname(username)) {
    const modal = document.getElementById("validateModal");
    modal.style.display = "block";
    return;
  }
  if (!username) {
    alert('введите никнейм');
    return;
  }
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

setChecking = () => {
  const checkBtn = document.getElementById('check-btn');
  const checkingBtn = document.getElementById('checking-btn');
  checkBtn.classList.remove("d-flex");
  checkBtn.classList.add("hidden");
  checkingBtn.classList.remove("hidden");
  checkingBtn.classList.add("d-flex");
}
// https://www.instagram.com/user/?__a=1
unSetChecking = () => {
  const checkBtn = document.getElementById('check-btn');
  const checkingBtn = document.getElementById('checking-btn');
  checkBtn.classList.add("d-flex");
  checkBtn.classList.remove("hidden");
  checkingBtn.classList.add("hidden");
  checkingBtn.classList.remove("d-flex");
}

function iframeLoaded() {
  let iFrameID = document.getElementsByClassName('youtube-frame')[0];
  let container = document.getElementsByClassName('youtube-container')[0];
  if (iFrameID && getComputedStyle(container, null).display === 'none') {
    container = document.getElementsByClassName('youtube-container')[1];
    iFrameID = document.getElementsByClassName('youtube-frame')[1];
  }
  if (iFrameID) {
    if (container) {
      iFrameID.width = container.offsetWidth + "px"
      iFrameID.height = container.offsetHeight + "px";
    } else {
      iFrameID.width = document.body.scrollWidth + "px";
      iFrameID.height = document.body.scrollHeight + "px";
    }
  }
}

iframeLoaded()


goToInsta = (login, page_url) => {
  const value = localStorage.getItem('hashid');
  fetch(`/pages/${page_url}/run_deferred_events?hashid=${value}&login=${login}`).then();

  const link = `https://www.instagram.com/${login}/`
  const modal = document.getElementById("myModal");
  modal.style.display = "hidden";
  window.open(link, '_blank').focus();
}

saveId = (id) => {
  localStorage.setItem('hashid', id)
}

updateGuestStatus = (status) => {
  const value = localStorage.getItem('hashid');
  if (!value) { return; }
  fetch(`/api/v1/statistics/set_status?hashid=${value}&status=${status}`).then();
}

preparedTime = (time) => {
  return new Date(time * 1000).toISOString().substr(14, 5);
}

runTimer = (time) => {

  let localtime = time;
  const timerEl = document.getElementById('timer');
  const progressEl = document.getElementById('progress');

  if (!timerEl || !progressEl) {
    return;
  }
  timerEl.classList.remove('hidden');
  // return
  const timeEl = document.getElementById('time');
  timeEl.innerHTML = preparedTime(localtime);
  let timerId = setInterval(() => {
    localtime -= 1;
    timeEl.innerHTML = preparedTime(localtime);
  }, 1000);

  let width = 100;
    const path = Math.round(100 / time) / 10
  let progressId = setInterval(() => {

    width -= path
    progressEl.setAttribute("style",`width: ${width}%`)
  }, 100);

  setTimeout(() => {
    progressEl.setAttribute("style",`width: 0%`)
    clearInterval(timerId);
    clearInterval(progressId)
  }, localtime * 1000 + 100);
}
