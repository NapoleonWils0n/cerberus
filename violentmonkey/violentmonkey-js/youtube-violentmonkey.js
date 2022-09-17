// ==UserScript==
// @name         avoid Youtube's "before you continue"
// @namespace   Violentmonkey Scripts
// @match       https://www.youtube.com/*
// @grant       none
// @version     1.0
// @author      jonas
// @description  How to block the annoying “Before you continue” popup on Youtube?
// @run-at       document-start
// @downloadURL  https://raw.githubusercontent.com/NapoleonWils0n/cerberus/master/violentmonkey/violentmonkey-js/youtube-violentmonkey.js
// @homepageURL  https://github.com/NapoleonWils0n/cerberus/blob/master/violentmonkey/violentmonkey-js/youtube-violentmonkey.js
// ==/UserScript==

// This will remove the popup but there are some problems:
// Buttons and menus like 'More', 'Tools', and many others will not work
const style = document.createElement('style');
style.innerHTML = /* css */ `
  div[dialog] {
    display: none !important;
  }
`;
document.head.append(style);

// This solves the previous problems but it's probably not that great for privacy
const consentMatch = document.cookie.match(/CONSENT=(PENDING|YES)\+(\d+)/);
document.cookie=`CONSENT=YES+${consentMatch ? consentMatch[2] : '0'}; domain=.youtube.com`;
