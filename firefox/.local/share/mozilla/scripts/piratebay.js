// ==UserScript==
// @name         Hide Fake Torrents on The Pirate Bay
// @namespace    https://www.reddit.com/r/Piracy/comments/4w0qix/now_that_kat_is_gone_i_wrote_a_small_script_that/
// @version      2.0
// @description  Hide Fake Torrents on The Pirate Bay with Conditional Logic
// @author       https://www.reddit.com/user/nicobelic
// @match        https://thepiratebay.org/*
// @match        https://pirateproxy.be/*
// @match        https://pirateproxy.bz/*
// @match        https://pirateproxy.id/*
// @match        https://pirateproxy.nl/*
// @match        https://tpb3.ukpass.co/*
// @match        https://thepiratebay.tips/*
// @match        https://thepiratebay-org.prox1.info/*
// @match        https://thepiratebay.vip/*
// @match        https://piratebayblocked.com/*
// @match        https://thepiratebay.unblockthe.net/*
// @match        https://thepiratebay.myunblock.com/*
// @match        https://piratebae.co.uk/*
// @match        https://thepiratebay.to/*
// @grant        none
// @locale       English
// ==/UserScript==

(function() {
  // Change the values below if you want
  maxSeedsWithoutTrust = 9000
  trustedTorrentsOnly = false
  dontHideJustWarn = true

  // Don't touch anything past this point
  function hide(badtorrent) {
    if (dontHideJustWarn) {
      badtorrent.style.background = '#fbbdbd';
    } else {
      badtorrent.style.display = "none";
    }
  }

  var torrents = Array.from(document.querySelectorAll('#searchResult tbody tr'));
  torrents.forEach(function(torrent) {
    if (typeof torrent == 'undefined') {
      return;
    }

    // Hide porn
    torrentCategoryElement = torrent.querySelectorAll('td:nth-child(1)')[0];
    if (typeof torrentCategoryElement !== 'undefined') {
      if (torrentCategoryElement.innerText.search('Porn') != -1) {
        hide(torrent);
      }
    }

    // Hide TS and Cam
    torrentTitleElement = torrent.querySelectorAll('td .detLink')[0];
    if (typeof torrentTitleElement !== 'undefined') {
      torrentTitle = torrentTitleElement.innerText.toLowerCase();
      if (
        torrentTitle.search('hdcam') != -1 ||
        torrentTitle.search(' cam ') != -1 ||
        torrentTitle.search('hd-ts') != -1 ||
        torrentTitle.search('hdts') != -1 ||
        torrentTitle.search('camrip') != -1
      ) {
        hide(torrent);
      }
    }

    // Hide untrusted
    if (torrent.innerHTML.search(/alt="VIP"|alt="Trusted"/) == -1) {
      if (trustedTorrentsOnly) {
        hide(torrent);
      } else {
        // Max seeds exceeded
        torrentSeedsElement = torrent.querySelectorAll('td:nth-child(3)')[0];
        if (typeof torrentSeedsElement !== 'undefined') {
          torrentSeeds = parseInt(torrentSeedsElement.innerText);
          if (torrentSeeds >= maxSeedsWithoutTrust) {
            hide(torrent);
          }
        }
      }
    }
  });
})();
