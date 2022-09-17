// ==UserScript==
// @name         Skip tinyurl.is
// @namespace    Violentmonkey Scripts
// @version      1.2
// @description  Skip tinyurl.is redirects
// @author       Luke Pothier <lukepothier@gmail.com>
// @match        https://tinyurl.is/*
// @grant        none
// @run-at       document-start
// @downloadURL  https://raw.githubusercontent.com/NapoleonWils0n/cerberus/master/violentmonkey/violentmonkey-js/skip-tinyurl.si.js
// @homepageURL  https://github.com/NapoleonWils0n/cerberus/blob/master/violentmonkey/violentmonkey-js/skip-tinyurl.si.js
// ==/UserScript==

// comments
(function() {
    'use strict';

    docReady(function() {
        document.getElementsByClassName('btn-secondary')[0].click();
    });
})();

function docReady(fn) {
    if (document.readyState === "complete" || document.readyState === "interactive") {
        setTimeout(fn, 1);
    } else {
        document.addEventListener("DOMContentLoaded", fn);
    }
}
