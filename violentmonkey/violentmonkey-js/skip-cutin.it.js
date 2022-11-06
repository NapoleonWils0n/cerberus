// ==UserScript==
// @name         Skip cutin.it
// @namespace    Violentmonkey Scripts
// @version      1.0
// @description  Skip tinyurl.is redirects
// @author       Luke Pothier <lukepothier@gmail.com>
// @match        https://cutin.it/*
// @grant        none
// @run-at       document-start
// @downloadURL  https://raw.githubusercontent.com/NapoleonWils0n/cerberus/master/violentmonkey/violentmonkey-js/skip-cutin.it.js
// @homepageURL  https://github.com/NapoleonWils0n/cerberus/blob/master/violentmonkey/violentmonkey-js/skip-cutin.it.js
// ==/UserScript==

(function() {
    'use strict';

    docReady(function() {
        document.getElementsByClassName('btn-success')[0].click();
    });
})();

function docReady(fn) {
    if (document.readyState === "complete" || document.readyState === "interactive") {
        setTimeout(fn, 1);
    } else {
        document.addEventListener("DOMContentLoaded", fn);
    }
}
