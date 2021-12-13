// ==UserScript==
// @name        Paddle Invoice Print Style
// @namespace   Violentmonkey Scripts
// @match       https://my.paddle.com/invoice/*
// @grant       GM_addStyle
// @version     1.0
// @author      -
// @description Update invoice styles to no suck when printed
// @run-at      document-idle
// ==/UserScript==
(() => {
  "use strict";

  GM_addStyle(`
    body { background-color: white; }
    header.c-header, #add-edit-address-container, .u-tac { display: none; }
    main.c-main { padding-top: 0; }
    main.c-main > .c-container { margin: 0; }
    main.c-main > .c-container > .c-sheet { box-shadow: 0 0 0 0 transparent; }
  `);
})();
