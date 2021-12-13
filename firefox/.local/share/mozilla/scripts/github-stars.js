// ==UserScript==
// @name        GitHub Stars
// @version     1.0.7
// @description Creates a link to your starred repositories on GitHub's navigation bar.
// @license     MIT
// @author      Robert Audi
// @namespace   https://github.com/RobertAudi
// @include     https://github.com/*
// @include     https://gist.github.com/*
// @grant       none
// @run-at      document-end
// @icon        https://github.githubassets.com/pinned-octocat.svg
// ==/UserScript==

/**
 * This userscript is a modified version of the GitHub Stars WebExtension by Jorge Gonzalez (@jorgegonzalez)
 * https://github.com/jorgegonzalez/github-stars
 */

// Get username
const username = document.querySelector('meta[name="user-login"]').getAttribute("content");

// Create elements
const nav = document.querySelector("header.Header .Header-item nav");
const a = document.createElement("a");
const text = document.createTextNode("Stars");

// Append to document
a.href = `https://github.com/${username}?tab=stars`;
a.appendChild(text);
a.className += "js-selected-navigation-item Header-link mr-3";
nav.appendChild(a);
