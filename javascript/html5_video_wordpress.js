// Jquery prefix so $ sign doesnt clash with protype script included with wordpress  //
jQuery(document).ready(function($) { 
 if ($.browser.msie && $.browser.version <= 8 ){
	var video = document.getElementsByTagName("video")[0];
	var videoSrc = $('source').attr('src');
	var poster = $('video').attr('poster');
	 var flash = $('<embed type="application/x-shockwave-flash" src="http://www.kpcsl.com/player.swf" width="640" height="270" allowscriptaccess="always" allowfullscreen="true" wmode="transparent" /></embed>').attr('flashvars', 'file='+videoSrc+'&image='+poster+'&stretching=fill');
	$('video').replaceWith(flash);
}
});
jQuery(document).ready(function($) { 
 if ($.browser.opera ){
	var video = document.getElementsByTagName("video")[0];
	var videoSrc = $('source').attr('src');
	var poster = $('video').attr('poster');
	 var flash = $('<embed type="application/x-shockwave-flash" src="http://www.kpcsl.com/player.swf" width="640" height="270" allowscriptaccess="always" allowfullscreen="true" wmode="transparent" /></embed>').attr('flashvars', 'file='+videoSrc+'&image='+poster+'&stretching=fill');
	$('video').replaceWith(flash);
}
});
jQuery(document).ready(function($) { 
	if ((screen.width>=321) && (screen.height>=481)) {
	var video = document.getElementsByTagName("video")[0];
	var videoSrc = $('source').attr('src');
	var videoWidth = $('video').attr('width');
	var videoHeight = $('video').attr('height')+16;
	var qt = $('<embed type="video/quicktime" pluginspage="http://www.apple.com/quicktime/download/" width="'+videoWidth+'px" height="'+videoHeight+'px" controller="true" scale="aspect" autoplay="false" showlogo="true" cache="false" src='+videoSrc+' />');
	if ( !video.play ) { $('video').replaceWith(qt); }
	var quicktime = video.canPlayType("video/mp4");
	if (quicktime == "" in navigator.plugins){ $('video').replaceWith(qt); }
	if ( video.play ) { 
	video.addEventListener("play", function() { video.play(); }, true);
	video.addEventListener("pause", function() { video.pause(); }, true);
	video.addEventListener("canplaythrough", function() { video.play(); }, true);
	}
	}
});


