let bonus = null;

guard = () => {
  const url = window.location.pathname.match('pages\/(.*?)\/success')[1];
  const username = localStorage.getItem('username');
  if (!username) {
    window.location.href = `/pages/${url}/welcome`;
  }

  fetch(`/pages/${url}/get_bonus?name=${username}`).then(res =>
    res.json().then(resp => {
      if (resp.access === true) {
        document.getElementById('success-page').classList.remove('hidden')
        bonus = resp.bonus
        return
      }
      window.location.href = `/pages/${url}/welcome`;
    }));
}

getBonus = () => {
  window.open(bonus, '_blank').focus();
}

updateGuestStatus = (status) => {
  const value = localStorage.getItem('hashid')
  if (!value) { return; }
  fetch(`/api/v1/statistics/set_status?hashid=${value}&status=${status}`).then();
}

guard()