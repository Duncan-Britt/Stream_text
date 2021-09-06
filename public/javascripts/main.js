// window.setInterval(function() {
//   let article = document.getElementById("stream");
//   article.scrollTop = article.scrollHeight - article.clientHeight;
// }, 5000);

// $('#DebugContainer').stop().animate({
//   scrollTop: $('#DebugContainer')[0].scrollHeight
// }, 800);

window.setInterval(function() {
  $("html, body").animate({ scrollTop: $(document).height() }, "slow");
}), 5000;
