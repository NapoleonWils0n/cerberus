if ( (navigator.userAgent.indexOf('iPad') != -1)) {
  document.addEventListener('DOMContentLoaded', function() {
	document.ontouchmove = function(e){ e.preventDefault(); };
  }, false);
}