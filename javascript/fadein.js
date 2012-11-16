<script>
$(function() { 
if ($.browser.msie){}
	else {
	$(".some-class, .another-class").css({ "opacity": "0" });
	$(".some-class").animate({"opacity": "1"}, 500);
	$(".another-class").delay(1000).animate({"opacity": "1"}, 500);
	}
});
</script>