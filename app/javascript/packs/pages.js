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