// ==UserScript==
// @name         Skip tinyurl.is
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Skip tinyurl.is redirects
// @author       Luke Pothier <lukepothier@gmail.com>
// @match        https://tinyurl.is/*
// @grant        none
// ==/UserScript==

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
