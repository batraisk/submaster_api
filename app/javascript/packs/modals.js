const modal = document.getElementById("myModal");
const cancel = document.getElementsByClassName("cancel")[0];
const validateModal = document.getElementById("validateModal");
const cancelValidateModal = document.getElementsByClassName("cancelValidateModal")[0];


cancel.onclick = function() {
  modal.style.display = "none";
}

window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}

cancelValidateModal.onclick = function() {
  validateModal.style.display = "none";
}

window.onclick = function(event) {
  if (event.target == validateModal) {
    validateModal.style.display = "none";
  }
}