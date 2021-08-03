const modal = document.getElementById("myModal");
// const btn = document.getElementById("myBtn");
const cancel = document.getElementsByClassName("cancel")[0];

// btn.onclick = function() {
//   modal.style.display = "block";
// }

cancel.onclick = function() {
  modal.style.display = "none";
}

window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}