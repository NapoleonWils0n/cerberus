{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
    extraPolicies = {
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFirefoxAccounts = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      OffertosaveloginsDefault = false;
      PasswordManagerEnabled = false;
      };
    };
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      multi-account-containers
      ublock-origin
      vimium
      violentmonkey
    ];
      profiles = {
        default = {
          isDefault = true;
          extraConfig = ''
          // beacon = false
          user_pref("beacon.enabled", false);
          // about config warning = false
          user_pref("browser.aboutConfig.showWarning", false); 
          // strictcontent blocking
          user_pref("browser.contentblocking.category", "strict");
          // download dont open panel in toolbar
          user_pref("browser.download.alwaysOpenPanel", false);
          // downloads button
          user_pref("browser.engagement.downloads-button.has-used", true);
          // tab manager = false
          user_pref("browser.tabs.tabmanager.enabled", false);
          // safebrowsing = false
          user_pref("browser.safebrowsing.appRepURL", "");
          user_pref("browser.safebrowsing.malware.enabled", false);
          // browser search
          user_pref("browser.search.hiddenOneOffs", "Google,Yahoo,Bing,Amazon.com,Twitter");
          // browser search suggest = false
          user_pref("browser.search.suggest.enabled", false);
          // search bar in toolbar
          user_pref("browser.search.widget.inNavBar", true);
          // browser send pings = false
          user_pref("browser.send_pings", false);
          // homepage blank
          user_pref("browser.startup.homepage", "about:blank");
          // startup page
          user_pref("browser.startup.page", "3");
          // startup homepage = blank
          user_pref("browser.startup.homepage", "about:blank");
          // tabs firefox view = false
          user_pref("browser.tabs.firefox-view", false);
          // tabmanager = false
          user_pref("browser.tabs.tabmanager.enabled", false);
          // newtab = false
          user_pref("browser.newtabpage.enabled", false);
          // activity stream
          user_pref("browser.newtabpage.activity-stream.showSeach", false);
          user_pref("browser.newtabpage.activity-stream.showSponsored", false);
          user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
          user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
          // bookmarks toolbar visibility = never
          user_pref("browser.toolbars.bookmarks.visibility", "never");
          // browser ui density
          user_pref("browser.uidensity", "1");
          // urlbar speculativeconnect = false
          user_pref("browser.urlbar.speculativeConnect.enabled", false);
          // urlbar bookmarks = false
          user_pref("browser.urlbar.shortcuts.bookmarks", false);
          // urlbar history = false
          user_pref("browser.urlbar.shortcuts.history", false);
          // urlbar shortcuts tabs = false
          user_pref("browser.urlbar.shortcuts.tabs", false);
          // urlbar show search suggestions first = false
          user_pref("browser.urlbar.showSearchSuggestionsFirst", false);
          // urlbar suggest bookmarks = false
          user_pref("browser.urlbar.suggest.bookmark", false);
          // urlbar suggest engines = false
          user_pref("browser.urlbar.suggest.engines", false);
          // urlbar suggest history = false
          user_pref("browser.urlbar.suggest.history", false);
          // urlbar suggest open page = false
          user_pref("browser.urlbar.suggest.openpage", false);
          // urlbar suggest searches = false
          user_pref("browser.urlbar.suggest.searches", false);
          // urlbar suggest topsites = false
          user_pref("browser.urlbar.suggest.topsites", false);
          // firefox healthreport upload = false
          user_pref("datareporting.healthreport.uploadEnabled", false);
          // dont let sites disable copy and paste
          user_pref("dom.event.clipboardevents.enabled", false);
          // https mode = true
          user_pref("dom.security.https_only_mode", true);
          // experiments = false
          user_pref("experiments.activeExperiment", false);
          user_pref("experiments.enabled", false);
          user_pref("experiments.supported", false);
          // remove unifiedextensions
          user_pref("extensions.unifiedExtensions.enabled", false);
          // pocket show on home screen = false
          user_pref("extensions.pocket.enabled", false);
          user_pref("extensions.pocket.showHome", false);
          user_pref("extensions.pocket.onSaveRecs", false);
          user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.section.highlights.includePocket", false);
          user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
          // creditcards autofill = false
          user_pref("extensions.formautofill.creditCards.available", false);
          // smoothscroll = false
          user_pref("general.smoothScroll", false);
          // geo = false
          user_pref("geo.enabled", false);
          // general
          user_pref("gfx.webrender.all", true);
          user_pref("layout.css.devPixelsPerPx", "1");
          // media autoplay = 5
          user_pref("media.autoplay.default", "5");
          user_pref("media.navigator.enabled", false);
          user_pref("media.video_stats.enabled", false);
          // show punycode in the urlbar
          user_pref("network.IDN_show_punycode", true);
          // network
          user_pref("network.allow-experiments", false);
          user_pref("network.dns.disablePrefetch", true);
          user_pref("network.http.referer.XOriginPolicy", "2");
          user_pref("network.http.referer.XOriginTrimmingPolicy", "2");
          user_pref("network.http.referer.trimmingPolicy", "1");
          user_pref("network.prefetch-next", false);
          // magnet links
          user_pref("network.protocol-handler.expose.magnet", false);
          // default shortcuts
          user_pref("permissions.default.shortcuts", "2");
          // privacy dont track = true
          user_pref("privacy.donottrackheader.enabled", true);
          user_pref("privacy.donottrackheader.value", "1");
          user_pref("privacy.firstparty.isolate", true);
          user_pref("signon.rememberSignons", false);
          // css stylesheets = true
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          // theme
          user_pref("widget.content.gtk-theme-override", "Adwaita:dark");
          '';
          userChrome = ''
          /* userChrome.css */
          
          @namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"); /* only needed once */
          
          /* hide close, minimize window buttons */
          .titlebar-min {display:none!important;}
          .titlebar-max {display:none!important;}
          .titlebar-restore {display:none!important;}
          .titlebar-close {display:none!important;}
          
          /* Adjust tab corner shape, optionally remove space below tabs */
          #tabbrowser-tabs {
              --user-tab-rounding: 6px;
          }
          
          @media (-moz-proton) {
              .tab-background {
                  border-radius: var(--user-tab-rounding) var(--user-tab-rounding) 0px 0px !important;
                  margin-block: 1px 0 !important;
              }
              #scrollbutton-up, #scrollbutton-down { /* 6/10/2021 */
                  border-top-width: 1px !important;
                  border-bottom-width: 0 !important;
              }
              /* Container color bar visibility */
              .tabbrowser-tab[usercontextid] > .tab-stack > .tab-background > .tab-context-line {
                  margin: 0px max(calc(var(--user-tab-rounding) - 3px), 0px) !important;
              }
          }
          
          /* remove the bookmark star in the url bar */
          #star-button-box {display: none !important}
          
          /* Remove items from Firefox menu */
          #context-sendimage, /* email */
          #context-bookmarklink, /* bookmark link */
          /* #context-savelink, save link */
          #context-copyimage-contents, /* copy image */
          #context-take-screenshot, /* take screenshot */
          /* #context-openlinkintab, open link in tab */
          /* #context-openlink, open link in new window */
          #context-openlinkprivate, /* open link in private window */
          #context-searchselect, /* search for */
          #context-searchselect-private, /* search for private */
          #context-inspect-a11y, /* accessability */
          #context-savepage, /* save page */
          #context-selectall, /* select all */
          #context-viewsource, /* view source */
          #context-back, /* back */
          #context-forward, /* forward */
          #context-reload, /* reload */
          #context-bookmarkpage,/* edit this bookmark */
          #context-media-playbackrate, /* speed in video menu */
          #context-media-loop, /* loop video */ 
          #context-sendvideo, /* email video */
          #context-sendaudio, /* email audio */
          #context-sendimage, /* email image */
          #context-undo, /* undo */
          #context-redo, /* redo */
          #context-cut, /* cut */
          #context-copy, /* copy */
          #context-paste, /* paste */
          #context-delete, /* delete */
          #context-keywordfield, /* add a keyword for this search */
          #context-selectall /* select all */
          {display: none !important;}
          '';
         };
        };
      };
}
