document.addEventListener("DOMContentLoaded", (event) => {
  const btn_close_toast = document.getElementById('btn-close-toast');
  const toast_notice = document.getElementById('toast-notice');
  if (toast_notice.style.display == "block"){
      btn_close_toast.addEventListener('click', function(){
        toast_notice.style.opacity = "0"
        toast_notice.addEventListener("transitionend", () => {
        toast_notice.style.display = "none";
      })
    });
  }
  setTimeout(() => {
    if (toast_notice.style.display == "block"){
      toast_notice.style.opacity = "0"
      toast_notice.addEventListener("transitionend", () => {
        toast_notice.style.display = "none";
      })
    }
  }, 5000);


  const btn_close_toast_alert = document.getElementById('btn-close-toast-alert');
  const toast_alert = document.getElementById('toast-alert');
  if (toast_alert.style.display == "block"){
      btn_close_toast_alert.addEventListener('click', function(){
        toast_alert.style.opacity = "0"
        toast_alert.addEventListener("transitionend", () => {
        toast_alert.style.display = "none";
      })
    });
  }
  setTimeout(() => {
    if (toast_alert.style.display == "block"){
      toast_alert.style.opacity = "0"
      toast_alert.addEventListener("transitionend", () => {
        toast_alert.style.display = "none";
      })
    }
  }, 5000);
});