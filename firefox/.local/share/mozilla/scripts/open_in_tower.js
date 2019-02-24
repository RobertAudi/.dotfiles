// ==UserScript==
// @name        Open in Tower
// @homepage    https://github.com/gdelmas/GithubTower
// @author      Gerard Delmàs
// @namespace   Violentmonkey Scripts
// @icon        https://github.githubassets.com/pinned-octocat.svg
// @grant       none
// @run-at      document-end
// @include     https://github.com/*
// ==/UserScript==
(function() {
    var buttonElement = document.querySelector("a.get-repo-btn");

    if ( buttonElement === null ) {
        return;
    }

    buttonElement.removeAttribute('href');
    buttonElement.innerText = 'Open in Tower';
    buttonElement.setAttribute('aria-label', buttonElement.getAttribute('aria-label').replace('GitHub Desktop', 'Tower'));
    buttonElement.removeAttribute('data-open-app');

    buttonElement.addEventListener('click', function(event) {
        event.preventDefault();

        var repoModalElement = buttonElement.parentElement.parentElement;
        var inputElements = repoModalElement.querySelectorAll('input[type="text"]');
        var isSSH = repoModalElement.classList.contains('on');

        var activeInputElement = inputElements[isSSH ? 1 : 0];

        window.location.href = 'gittower://openRepo/' + encodeURI(activeInputElement.value);
    });
}());
