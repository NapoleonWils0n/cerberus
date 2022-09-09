// ==UserScript==
// @name         avoid youtube "before you continue"
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  How to block the annoying “Before you continue” popup on youtube
// @author       NapoleonWils0n
// @match        https://www.youtube.com/*
// @grant        none
// @run-at       document-start
// ==/UserScript==

// modified Jonas google script
// This will remove the popup but there are some problems:
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
