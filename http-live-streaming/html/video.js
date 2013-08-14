function myAddListener(){
	 var myVideo = document.getElementsByTagName('video')[0];     	  		
	 myVideo.poster='poster.png';
         myVideo.addEventListener('loadedmetadata', removePoster, false);        	
	 myVideo.addEventListener('loadedmetadata', naturalSize, false);
	 myVideo.preload="none";
	 myVideo.autoplay="none";
}
function removePoster() {
         var myVideo = document.getElementsByTagName('video')[0];
	 myVideo.poster='';
	 myVideo.play();
}
function naturalSize() {
         var myVideo = document.getElementsByTagName('video')[0];
         myVideo.height = myVideo.videoHeight;
         myVideo.width = myVideo.videoWidth;
}
