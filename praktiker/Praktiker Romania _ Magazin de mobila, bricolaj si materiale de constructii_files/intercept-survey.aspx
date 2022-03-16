var _____WB$wombat$assign$function_____ = function(name) {return (self._wb_wombat && self._wb_wombat.local_init && self._wb_wombat.local_init(name)) || self[name]; };
if (!self.__WB_pmw) { self.__WB_pmw = function(obj) { this.__WB_source = obj; return this; } }
{
  let window = _____WB$wombat$assign$function_____("window");
  let self = _____WB$wombat$assign$function_____("self");
  let document = _____WB$wombat$assign$function_____("document");
  let location = _____WB$wombat$assign$function_____("location");
  let top = _____WB$wombat$assign$function_____("top");
  let parent = _____WB$wombat$assign$function_____("parent");
  let frames = _____WB$wombat$assign$function_____("frames");
  let opener = _____WB$wombat$assign$function_____("opener");

(function (cfg) {
    function Loader(url) {
        this._url = url;

        this._loading = false;
        this._ready = false;
        this._handlers = [];
    }

    Loader.prototype = {
        load: function (handler) {
            try {
                if (this._ready) {
                    handler();
                    return;
                }

                this._handlers.push(handler);
                this._load();
            }
            catch (e) {
                console.warn('Unable to load Confirmit Intercept Survey', e);
            }
        },

        _load: function () {
            if (this._loading)
                return;

            this._loading = true;

            var script = document.createElement('script');
            script.type = 'text/javascript';
            script.src = this._url;
            script.async = true;
            script.addEventListener('load', this._onLoadComplete.bind(this), false);

            var firstScriptOnPage = document.getElementsByTagName('script')[0];
            firstScriptOnPage.parentNode.insertBefore(script, firstScriptOnPage);
        },

        _onLoadComplete: function () {
            this._loading = false;
            this._ready = true;

            this._handlers.forEach(function (handler) {
                handler();
            });
        }
    };

    var cf = window.ConfirmitIntercept || (window.ConfirmitIntercept = {});
    var loader = cf.loader || (cf.loader = new Loader(cfg.url));

    loader.load(function () {
        cf.survey(cfg.intercept);
    });
})({"url":"https://web.archive.org/web/20180912142058/https://survey.euro.confirmit.com/cf_clientutil/se/intercept-survey/intercept-survey.js?v=73","intercept":{"control":{"displayRate":5,"triggerAfterPagesVisited":3,"delaySeconds":10,"cookieName":"Confirmit_InterceptSurvey_p1866929724","cookieExpirationDays":60,"reinviteIncomplete":false,"promptEnabled":true,"customInitScript":""},"prompt":{"closeOnAccept":true,"html":"\u003cdiv id=\"cf_prompt_p1867041151\" class=\"cf-prompt-container\"\u003e\n\n    \u003cdiv class=\"cf-survey-prompt cf-survey-prompt--bottom-right\"\u003e\n        \u003cstyle\u003e#cf_prompt_p1867041151 .cf-survey-prompt {\n    box-sizing: border-box;\n}\n\n#cf_prompt_p1867041151 .cf-survey-prompt {\n    position: fixed;\n    z-index: 101;\n\n    font: 14px Arial;\n    background: rgb(246, 247, 248);\n    border: 1px solid  #383d45;\n    border-radius: 2px;\n    box-shadow: 0 0 4px #383d45;\n}\n\n#cf_prompt_p1867041151 .cf-survey-prompt--title,\n#cf_prompt_p1867041151 .cf-survey-prompt--text,\n#cf_prompt_p1867041151 .cf-survey-prompt--buttons {\n    padding: 10px 20px;\n}\n\n#cf_prompt_p1867041151 .cf-survey-prompt--title {\n    background:  #0053a0;\n    font-weight: bold;\n    color: #fff;\n}\n\n#cf_prompt_p1867041151 .cf-survey-prompt--accept {\n   border: none;\n    display: inline-block;\n    font-weight: bold;\n    border-radius: 2px;\n    color: #fff;\n    text-align: center;\n    padding: 4px 30px;\n    line-height: normal;\n    height: 33px;\n    cursor: pointer;\n}\n\n#cf_prompt_p1867041151 .cf-survey-prompt--decline {\n    -webkit-appearance: none;\n    border: none;\n    display: inline-block;\n    font-weight: bold;\n    border-radius: 2px;\n    color: #000000;\n    text-align: center;\n    padding: 4px 30px;\n    line-height: normal;\n    height: 33px;\n    cursor: pointer;\n}\n\n#cf_prompt_p1867041151 .cf-survey-prompt--accept {\n    background-color: #0053a0;\n    border-bottom: 1px solid #3c74b5;\n}\n\n#cf_prompt_p1867041151 .cf-survey-prompt--decline {\n    background-color: #ffff00;\n    border-bottom: 1px solid #383d45;\n}\n\n#cf_prompt_p1867041151 .cf-survey-prompt--close {\n    position: absolute;\n    top: 0;\n    width: 24px;\n    height: 24px;\n    cursor: pointer;\n}\n\n#cf_prompt_p1867041151 .cf-survey-prompt--close circle {\n    fill: #fff;\n    stroke:#383d45;\n    stroke-width:2px;\n    stroke-linecap: round;\n}\n\n#cf_prompt_p1867041151 .cf-survey-prompt--close path {\n    stroke-width:2px;\n    stroke-linecap: round;\n    fill:none;\n    stroke: #383d45;\n}\n\n#cf_prompt_p1867041151 .cf-survey-prompt--bottom-right {\n    bottom: 20px;\n    right: 20px;\n}\n\n#cf_prompt_p1867041151 .cf-survey-prompt--bottom-left {\n    bottom: 20px;\n    left: 20px;\n}\n\n#cf_prompt_p1867041151 .cf-survey-prompt--top-right {\n    top: 20px;\n    right: 20px;\n}\n\n#cf_prompt_p1867041151 .cf-survey-prompt--top-left {\n    top: 20px;\n    left: 20px;\n}\n\n#cf_prompt_p1867041151 .cf-survey-prompt--centered .cf-survey-prompt--close,\n#cf_prompt_p1867041151 .cf-survey-prompt--top-left .cf-survey-prompt--close,\n#cf_prompt_p1867041151 .cf-survey-prompt--bottom-left .cf-survey-prompt--close {\n    left: auto;\n    right: -30px;\n}\n\n#cf_prompt_p1867041151 .cf-survey-prompt--top-right .cf-survey-prompt--close,\n#cf_prompt_p1867041151 .cf-survey-prompt--bottom-right .cf-survey-prompt--close {\n    left: -30px;\n    right: auto;\n}\n\n#cf_prompt_p1867041151 .cf-survey-prompt--centered {\n    left: 0;\n    right: 0;\n    top: 0;\n    bottom: 0;\n    width: 305px;\n    height: 130px;\n    margin: auto;\n}\u003c/style\u003e\n        \u003cdiv class=\"cf-survey-prompt--title\"\u003e\n            \u003cdiv class=\"cf-survey-prompt--title-text\"\u003eVă mulțumim ca vizitați site-ului nostru!\u003c/div\u003e\n            \u003cdiv class=\"cf-survey-prompt--close\"\u003e\n                \u003csvg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 24 24\"\u003e\n                    \u003ccircle cx=\"12\" cy=\"12\" r=\"11\"\u003e\u003c/circle\u003e\n                    \u003cpath d=\"M7.5 16.5l9-9M16.5 16.5l-9-9\"\u003e\u003c/path\u003e\n                \u003c/svg\u003e\n            \u003c/div\u003e\n        \u003c/div\u003e\n        \u003cdiv class=\"cf-survey-prompt--text\"\u003eVrem să fim siguri că sunteți încântat/ă de interacțiunea cu site-ul nostru. \r\n\u003cp\u003eAți vrea să luați parte la un sondaj scurt și să ne spuneți ce părere aveți despre el? \u003c/div\u003e\n        \u003cdiv class=\"cf-survey-prompt--buttons\"\u003e\n            \u003cbutton class=\"cf-survey-prompt--accept\"\u003eDa, vă rog\u003c/button\u003e\n            \u003cbutton class=\"cf-survey-prompt--decline\"\u003eNu, mulțumesc\u003c/button\u003e\n        \u003c/div\u003e\n    \u003c/div\u003e\n    \n\u003c/div\u003e"},"overlay":{"projectId":"p1867041151","url":"https://web.archive.org/web/20180912142058/https://survey.euro.confirmit.com/wix/p1867041151.aspx","siteDataCapture":[],"html":"\u003cdiv id=\"cf_overlay_p1867041151\" class=\"cf-survey-overlay-container\"\u003e\n    \u003cstyle\u003ebody.cf-has-survey-overlay {\n    overflow: hidden;\n}\n\n#cf_overlay_p1867041151 .cf-survey-overlay {\n    position: fixed;\n    z-index: 101;\n    left: 0;\n    right: 0;\n    top: 0;\n    bottom: 0;\n    width: 960px;\n    height: 600px;\n    margin: auto;\n    border: 1px solid  #383d45;\n    box-shadow: 0 0 2px #383d45;\n    background: #fff;\n}\n\n#cf_overlay_p1867041151 .cf-survey-overlay-content {\n    width: 100%;\n    height: 100%;\n}\n\n#cf_overlay_p1867041151 .cf-survey-overlay-shim {\n    position: fixed;\n    z-index: 100;\n    left: 0;\n    top: 0;\n    right: 0;\n    bottom: 0;\n    background-color: #383d45;\n    opacity: 0.4;\n}\n\n#cf_overlay_p1867041151 .cf-survey-overlay--close {\n    position: absolute;\n    top: 0;\n    right: -60px;\n    width: 48px;\n    height: 48px;\n    cursor: pointer;\n}\n\n#cf_overlay_p1867041151 .cf-survey-overlay--close circle {\n    stroke-width:2px;\n    stroke-linecap: round;\n    fill: #fff;\n    stroke:#383d45;\n}\n\n#cf_overlay_p1867041151 .cf-survey-overlay--close path {\n    stroke-width:2px;\n    stroke-linecap: round;\n    fill:none;\n    stroke: #383d45;\n}\n\n@keyframes cf-loading-animation {\n    0% {\n        opacity: 0;\n    }\n\n    50% {\n        opacity: .8;\n    }\n\n    100% {\n        opacity: 0;\n    }\n}\n\n#cf_overlay_p1867041151 .cf-survey-loading {\n    position: absolute;\n    left: 0;\n    top: 0;\n    right: 0;\n    bottom: 0;\n    width: 100px;\n    height: 50px;\n    margin: auto;\n}\n\n#cf_overlay_p1867041151 .cf-survey-loading-items {\n    font-size: 60px;\n    display: -webkit-inline-box;\n    display: -webkit-inline-flex;\n    display: -ms-inline-flexbox;\n    display: inline-flex;\n    -webkit-box-align: center;\n    -webkit-align-items: center;\n    -ms-flex-align: center;\n    align-items: center;\n}\n\n#cf_overlay_p1867041151 .cf-survey-loading-items--item {\n    animation: cf-loading-animation 1.8s infinite;\n    animation-play-state: inherit;\n    border-radius: 50%;\n    opacity: 0;\n    width: .4em;\n    height: .4em;\n    background: #777;\n}\n\n#cf_overlay_p1867041151 .cf-survey-loading-items--item:nth-child(1) {\n    animation-delay: 0s;\n}\n\n#cf_overlay_p1867041151 .cf-survey-loading-items--item:nth-child(2) {\n    animation-delay: .3s;\n    margin: 0.6ex;\n}\n\n#cf_overlay_p1867041151 .cf-survey-loading-items--item:nth-child(3) {\n    animation-delay: .6s;\n}\n    \n#cf_overlay_p1867041151 .cf-survey-frame {\n    display: block;\n    width: 100%;\n    height: 100%;\n    border: none;\n}\u003c/style\u003e\n    \u003cdiv class=\"cf-survey-overlay-shim\"\u003e\u003c/div\u003e\n    \u003cdiv class=\"cf-survey-overlay\"\u003e\n        \u003cdiv class=\"cf-survey-overlay--close\"\u003e\n            \u003csvg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 24 24\"\u003e\n                \u003ccircle cx=\"12\" cy=\"12\" r=\"11\"\u003e\u003c/circle\u003e\n                \u003cpath d=\"M7.5 16.5l9-9M16.5 16.5l-9-9\"\u003e\u003c/path\u003e\n            \u003c/svg\u003e\n        \u003c/div\u003e\n        \u003cdiv class=\"cf-survey-loading\"\u003e\n            \u003cdiv class=\"cf-survey-loading-items\"\u003e\n                \u003cdiv class=\"cf-survey-loading-items--item\"\u003e\u003c/div\u003e\n                \u003cdiv class=\"cf-survey-loading-items--item\"\u003e\u003c/div\u003e\n                \u003cdiv class=\"cf-survey-loading-items--item\"\u003e\u003c/div\u003e\n            \u003c/div\u003e\n        \u003c/div\u003e\n        \u003cdiv class=\"cf-survey-overlay-content\"\u003e\n            \u003ciframe class=\"cf-survey-frame\" frameborder=\"0\"\u003e\u003c/iframe\u003e\n        \u003c/div\u003e\n    \u003c/div\u003e\n\u003c/div\u003e"}}});

}
/*
     FILE ARCHIVED ON 14:20:58 Sep 12, 2018 AND RETRIEVED FROM THE
     INTERNET ARCHIVE ON 17:57:40 Mar 16, 2022.
     JAVASCRIPT APPENDED BY WAYBACK MACHINE, COPYRIGHT INTERNET ARCHIVE.

     ALL OTHER CONTENT MAY ALSO BE PROTECTED BY COPYRIGHT (17 U.S.C.
     SECTION 108(a)(3)).
*/
/*
playback timings (ms):
  captures_list: 342.304
  exclusion.robots: 0.189
  exclusion.robots.policy: 0.181
  RedisCDXSource: 7.143
  esindex: 0.01
  LoadShardBlock: 315.813 (3)
  PetaboxLoader3.datanode: 201.266 (4)
  CDXLines.iter: 17.011 (3)
  load_resource: 114.009
  PetaboxLoader3.resolve: 44.573
*/