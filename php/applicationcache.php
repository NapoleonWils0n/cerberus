<!DOCTYPE html>
<html lang="en-GB" manifest="manifest.php">
<head> 	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Offline Dropbox</title>
  <meta name="description" content="offline html5 storage with dropbox" />  
  	<meta name="keywords" content="html5 manifest dropbox" /> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
	<link rel="apple-touch-icon" href="apple-touch-icon.png"/>
<style>
	html {background: rgba(70,167,240,1); margin: 0; padding: 0;}	
	body {height: 100%; margin: 0; padding: 0; font: 12px/1.5 "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; background: rgba(70,167,240,1); color: rgba(255,255,255,1);}
	article {display: block; margin: 0; padding: 0;}
	aside {display: block; margin: 0; padding: 0;}
	header {display: block; margin: 0; padding: 0;}
	hgroup {display: block; margin: 0; padding: 0;}
	figure {display: block;}
	figcaption {
		display: block;
		margin: 0;
		padding: 4px 0 0 0;
		}
	section {display: block; margin: 0; padding: 0;}
	
	footer {display: block;}
	nav {display: block;}
	dialog {display: block;}
	time {display: inline-block;}
	h1 {font-size: 18px; margin: 0 0 .75em 0;}
	h2 {font-size: 14px; margin: 0 0 .5em 0;}
	h3 {font-size: 13px; margin: 0 0 .5em 0; text-transform: none;}
	h4 {font-size: 11px; margin: 0 0 .5em 0; letter-spacing: 1px; font-variant: small-caps; text-transform: none;}
	h5, h6 {font-size: 10px; margin: 0 0 .5em 0;}
	a, a:link, a:visited {
		text-decoration: none; 
		word-wrap: break-word; 
		color: rgba(235,235,235,1);
		transition: color 1s linear;  
		-o-transition: color 1s linear; 
		-moz-transition: color 1s linear; 
		-webkit-transition: color 1s linear; 
		transition-timing-function:ease-out,cubic-bezier(0.5,0.2,0.3, 1.0);
		-o-transition-timing-function:ease-out,cubic-bezier(0.5,0.2,0.3, 1.0);
		-moz-transition-timing-function:ease-out,cubic-bezier(0.5,0.2,0.3, 1.0);
		-webkit-transition-timing-function:ease-out,cubic-bezier(0.5,0.2,0.3, 1.0);
		}
	a:hover {text-decoration: none; color: rgba(142,18,18,1);}
	a:active {text-decoration: none; color: rgba(142,18,18,1);}
	menu {display: block;}
	ul {position: relative;}
	ol {position: relative;}
	li {line-height: 1.6; }
	dl {margin: 12px 0 12px 6px; padding: 0; line-height: 1.5; position: relative;}
	dlfn {}
	dl dt {margin: 0 0 2px 0; padding: 0;}
	dl dd {margin: 0 12px 6px 18px; padding: 0;}
	form {margin: 0; padding: 0;}
	fieldset {margin: 0 0 12px 0; padding: 6px 12px; border: solid 1px rgba(204,204,204,1);}
	legend {}
	button {}
	input[type="text"], input[type="password"] {font: -webkit-small-control;}
	input[type="text"]:hover, input[type="text"]:focus, input[type="password"]:hover, input[type="password"]:focus {}
	input[type="button"], input[type="submit"] {}
	label {margin: 0; padding: 0;}
	textarea {margin: 0; line-height: 1.2; outline: 0; resize: none; cursor: auto; -webkit-appearance: textarea; -webkit-rtl-ordering: logical; -webkit-user-select: text; -webkit-box-orient: vertical;}
	textarea:hover, textarea:focus {}
	select {}
	optgroup {}
	option {}
	table {border: 1px solid rgba(204,204,204,1); border-collapse: collapse; width: 100%;}
	tbody {}
	thead {background: rgba(229,230,232,1);}
	thead th {border-bottom: 1px solid rgba(204,204,204,1); padding: 7px; text-align: left;}
	th {margin: 0; padding: 7px;}
	td {border-bottom: 1px solid rgba(204,204,204,1); margin: 0; padding: 7px;}
	tr.even {background: rgba(241,245,250,1);}
	tr.odd {background: rgba(255,255,255,1);}
	tfoot {}
	caption {}
	col {}
	colgroup {}
	address {margin: 10px 0 10px 0; padding: 0;}
	br {}
	div {margin: 0; padding: 0;}
	cite {}
	code {margin: 0; padding: 0;}
	hr {background: rgba(153,153,153,1); margin: 6px 0 20px 0; padding: 0; border: none; height: 1px;}
	iframe {margin: 0; padding: 0;}
	span {}
	script {}
	abbr {}
	b {font-weight: bold;}
	blockquote {background: rgba(239,239,239,.5); margin: 0 16px 16px 16px; padding: 8px; -moz-border-radius: 3px; -webkit-border-radius: 3px; border-radius: 3px;}
	blockquote > table {border: none;}
	blockquote > table > tbody > tr > td {border-bottom: none; padding: 0;}
	em {}
	i {font-style: italic;}
	p {font-size: 13px; margin: 0 0 1em 0; padding: 0;}
	pre {}
	q {}
	small {}
	strong {font-weight: bold;}
	sub {}
	sup {}
	area {}
	a img {padding: 0; margin: 0; border: 0; text-decoration: none;}
	img {padding: 0; margin: 0; border: 0;}
	audio {margin: 0; padding: 0;}
	embed {margin: 0; padding: 0; display: block; max-width: 100%;}
	map {}
	object {margin: 0; padding: 0;}
	noscript {}
	video {margin: 0; padding: 0; max-width: 100%; display: block;}
	p::first-letter {}
	p::first-line {}
	p:first-child {}
	p:last-child {}
	p:nth-child(odd) {}
	p:nth-child(even) {}
	p:nth-child(2n) {}
	p:nth-child(2n+3) {}
	p:nth-last-child(2n) {}
	p::selection {background: rgba(204,204,204,1);}
	li:only-child {}
	li:first-of-type {}
	li:last-of-type {}
	
/* Manifest Loader ***********************************************************************/	
	
	#loader { display: none; position: absolute; width: 100%; height: 100%; z-index: 2000000; background-color: rgba(0,0,0,0.7); -webkit-transition-property: background-color color; -webkit-transition-duration: 550ms; -webkit-transition-timing-function: ease-out, cubic-bezier(0.5, 0.2, 0.3, 1.0); }
	#loader .loader{ display: table-cell; vertical-align: middle; text-align: center; color: rgba(255,255,255,1); }
	#loader img { width: 31px; height: 31px; padding: 10px; -webkit-border-radius: 3px; background-color: rgba(96,96,97,1); }
	#loader .loader hgroup h1, #loader .loader hgroup h2 { color: rgba(255,255,255,1); font-size: 20px; }
	#loader .loader p {color: rgba(255,255,255,1);}
	
/* Media Queries ***********************************************************************/
	
	@media screen and (min-device-width: 1025px) {}
	
	@media screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait) {
		html {-webkit-text-size-adjust: none;}
	}	
		
	@media screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape) {
		html {-webkit-text-size-adjust: none;}
	}
		
	@media only screen and (max-device-width: 480px) {
		html {-webkit-text-size-adjust: none;}
		}
	
	@media only screen and (-webkit-min-device-pixel-ratio: 2) {}
</style>
<script src="script/jquery-1.4.4.min.js"></script>
<script src="script/applicationcache.js"></script>
</head>
<body>
<div id="loader">
	<div class="loader">
	<hgroup><h1>Offline application cache updating</h1><h2>please wait a few seconds</h2></hgroup>
	<p>This cache allows you to view the site when you aren't connected to the internet, in offline mode</p>
	<img src="data:image/gif;base64,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" height="31" width="31" alt="Loading cache..." />
	</div>
</div>

<h1>html5 offline dropbox storage</h1>
<?php
  $dir = new RecursiveDirectoryIterator("files");
  foreach(new RecursiveIteratorIterator($dir) as $file) {
    if ($file->IsFile() &&
        $file != "./manifest.php" &&
        !preg_match('/.php$/', $file) &&
        substr($file->getFilename(), 0, 1) != ".")
    {
   	  echo "<ul>";
      echo "<li><a href=\"$file\">$file</a></li>";
      echo "</ul>";
    }
  }
?>
</body>
</html>