!function(t){if("object"==typeof exports&&"undefined"!=typeof module)module.exports=t();else if("function"==typeof define&&define.amd)define([],t);else{var e;e="undefined"!=typeof window?window:"undefined"!=typeof global?global:"undefined"!=typeof self?self:this,e.navbar=t()}}(function(){return function t(e,o,i){function n(r,s){if(!o[r]){if(!e[r]){var c="function"==typeof require&&require;if(!s&&c)return c(r,!0);if(a)return a(r,!0);var l=new Error("Cannot find module '"+r+"'");throw l.code="MODULE_NOT_FOUND",l}var d=o[r]={exports:{}};e[r][0].call(d.exports,function(t){var o=e[r][1][t];return n(o?o:t)},d,d.exports,t,e,o,i)}return o[r].exports}for(var a="function"==typeof require&&require,r=0;r<i.length;r++)n(i[r]);return n}({1:[function(t,e,o){!function(t){"use strict";if("document"in t)if("classList"in document.createElement("_")&&(!document.createElementNS||"classList"in document.createElementNS("http://www.w3.org/2000/svg","svg").appendChild(document.createElement("g")))){var e=document.createElement("_");if(e.classList.add("c1","c2"),!e.classList.contains("c2")){var o=function(t){var e=DOMTokenList.prototype[t];DOMTokenList.prototype[t]=function(t){var o,i=arguments.length;for(o=0;o<i;o++)t=arguments[o],e.call(this,t)}};o("add"),o("remove")}if(e.classList.toggle("c3",!1),e.classList.contains("c3")){var i=DOMTokenList.prototype.toggle;DOMTokenList.prototype.toggle=function(t,e){return 1 in arguments&&!this.contains(t)==!e?e:i.call(this,t)}}e=null}else{if(!("Element"in t))return;var n="classList",a="prototype",r=t.Element[a],s=Object,c=String[a].trim||function(){return this.replace(/^\s+|\s+$/g,"")},l=Array[a].indexOf||function(t){for(var e=0,o=this.length;e<o;e++)if(e in this&&this[e]===t)return e;return-1},d=function(t,e){this.name=t,this.code=DOMException[t],this.message=e},u=function(t,e){if(""===e)throw new d("SYNTAX_ERR","An invalid or illegal string was specified");if(/\s/.test(e))throw new d("INVALID_CHARACTER_ERR","String contains an invalid character");return l.call(t,e)},f=function(t){for(var e=c.call(t.getAttribute("class")||""),o=e?e.split(/\s+/):[],i=0,n=o.length;i<n;i++)this.push(o[i]);this._updateClassName=function(){t.setAttribute("class",this.toString())}},v=f[a]=[],h=function(){return new f(this)};if(d[a]=Error[a],v.item=function(t){return this[t]||null},v.contains=function(t){return t+="",u(this,t)!==-1},v.add=function(){var t,e=arguments,o=0,i=e.length,n=!1;do t=e[o]+"",u(this,t)===-1&&(this.push(t),n=!0);while(++o<i);n&&this._updateClassName()},v.remove=function(){var t,e,o=arguments,i=0,n=o.length,a=!1;do for(t=o[i]+"",e=u(this,t);e!==-1;)this.splice(e,1),a=!0,e=u(this,t);while(++i<n);a&&this._updateClassName()},v.toggle=function(t,e){t+="";var o=this.contains(t),i=o?e!==!0&&"remove":e!==!1&&"add";return i&&this[i](t),e===!0||e===!1?e:!o},v.toString=function(){return this.join(" ")},s.defineProperty){var p={get:h,enumerable:!0,configurable:!0};try{s.defineProperty(r,n,p)}catch(g){g.number===-2146823252&&(p.enumerable=!1,s.defineProperty(r,n,p))}}else s[a].__defineGetter__&&r.__defineGetter__(n,h)}}("undefined"!=typeof window?window:{})},{}],2:[function(t,e,o){var i={TICK_MULTIPLIER:1/Math.cos(Math.PI/4),DEFAULT_ANIMATION_DURATION:200,DEFAULT_POPUP_DELAY:1e3,MAX_PROMOTION_LENGTH:100,KEY_PROMOTIONS_READ:"NavbarPromotionsRead",KEY_COOKIES_AGREED:"CookiesAgreed",DATA_PROMOTION_ID:"data-promotion-id",EXTERNAL_EVENTS:{CLOSE_ALL_MENUS:"navbarCloseAllMenus"},viewportWidth:0,viewportWidthFooter:0,calcViewportWidth:function(){return Math.max(document.documentElement.clientWidth,window.innerWidth||0)},init:function(t){if(!t.classList.contains("is-disabled")){t.addEventListener("click",i.rootClickHandler.bind(t)),i.forEach(t.querySelectorAll(".Navbar-overlay"),function(e){e.addEventListener("click",i.closeModals.bind(t))}),window.addEventListener("resize",i.resize.bind(t)),i.setupExternalEventListeners(t),i.forEach(t.querySelectorAll(".Navbar-modalToggle"),function(e){e.addEventListener("click",i.toggleModal.bind({root:t,toggle:e}))}),i.forEach(t.querySelectorAll(".Navbar-modal"),function(e){e.classList.contains("is-animated")&&(e.addEventListener("animationend",i.setModalDisplayStateAfterAnimation.bind(e)),e.addEventListener("transitionend",i.setModalDisplayStateAfterAnimation.bind(e))),i.forEach(e.querySelectorAll(".Navbar-modalClose, .Navbar-modalCloseGutter"),function(o){o.addEventListener("click",i.toggleModal.bind({root:t,target:e}))})}),i.forEach(t.querySelectorAll(".Navbar-expandable"),function(e){e.querySelector(".Navbar-expandableToggle").addEventListener("click",i.toggleExpandable.bind(t,e))}),t.hasAttribute("data-ajax")&&i.authenticate(t),setTimeout(function(){i.showCookieCompliance(t),i.checkPromotions.call(i,t)},i.DEFAULT_POPUP_DELAY),t.classList.contains("is-authenticated")&&(t.getAttribute("data-notification-count")?i.setSupportNotificationCount.call(i,t,{total:parseInt(t.getAttribute("data-notification-count"))}):i.checkSupportNotifications(t));var e=t.getAttribute("data-current-site");if(e){var o=t.querySelector('.Navbar-desktop .Navbar-item[data-name="'+e+'"]');o&&o.classList.add("is-current")}var n=navigator.userAgent.toLowerCase(),a=n.indexOf("iphone")>=0||n.indexOf("ipad")>=0;a&&(t.addEventListener("touchmove",i.touchMoveHandler),t.addEventListener("touchend",i.touchEndHandler),i.forEach(t.querySelectorAll(".Navbar-accountModal .Navbar-modalContent, .Navbar-siteMenu .Navbar-modalContent"),function(t){i.forEach(t.querySelectorAll("a, .Navbar-expandableToggle"),function(t){t.addEventListener("click",i.touchClickHandler)})}))}},initFooter:function(t){if(t.querySelector(".NavbarFooter-selector")){var e=t.querySelector(".NavbarFooter-selectorToggle");e&&e.addEventListener("click",i.toggleLocaleSelector.bind(t));var o=t.querySelector(".NavbarFooter-selectorCloserAnchor");o&&o.addEventListener("click",i.closeLocaleSelector.bind(t));var n=t.querySelector(".NavbarFooter-overlay");n&&n.addEventListener("click",i.closeLocaleSelector.bind(t)),window.addEventListener("resize",i.resizeFooter.bind(t)),(t.classList.contains("is-region-limited")||t.classList.contains("is-region-hybrid"))&&i.forEach(t.querySelectorAll(".NavbarFooter-selectorRegion:not(.is-external)"),function(e){e.addEventListener("click",i.changeFooterRegionLimit.bind(t,e))})}},resize:function(){var t=i.calcViewportWidth();t!==i.viewportWidth&&(i.viewportWidth=t,this&&this.classList.contains("is-focused")&&i.closeModals.call(this))},setupExternalEventListeners:function(t){for(var e in i.EXTERNAL_EVENTS)window.addEventListener(i.EXTERNAL_EVENTS[e],i.handleExternalEvent.bind(t))},handleExternalEvent:function(t){switch(t.type){case i.EXTERNAL_EVENTS.CLOSE_ALL_MENUS:i.closeModals.call(this)}},rootClickHandler:function(){var t=this.querySelector(".Navbar-promotion.is-open");t&&i.dismissPromotion.call(t)},touchMoving:!1,touchMoveHandler:function(){i.touchMoving=!0},touchEndHandler:function(){i.touchMoving=!1},touchClickHandler:function(t){if(i.touchMoving)return t.stopPropagation(),t.preventDefault(),!1},toggleModal:function(t){var e=this.toggle,o=e?e.getAttribute("data-target"):null,n=!1;return i.forEach(this.root.querySelectorAll(".Navbar-modal"),function(t){var e=this.toggle;if(t===this.target||t.classList.contains(o))if(i.isOpen(t))i.close(t),t.classList.contains("is-scroll-blocking")&&i.unblockScrolling(),e&&e.classList.remove("is-active");else{i.open(t),t.classList.contains("is-scroll-blocking")&&i.blockScrolling(),e&&e.classList.add("is-active");var a=t.querySelector(".Navbar-tick");if(a){a.style.left="";var r=e.querySelector(".Navbar-dropdownIcon");r&&0!==r.offsetLeft||(r=e.querySelector(".Navbar-label")),r&&0!==r.offsetLeft||(r=e);var s=i.setTickOffset(r,a);if(!t.classList.contains("is-constrained")){var c=t.offsetWidth/2,l=s>c?s-c:c-s,d=t.offsetHeight/c,u=Math.atan(d),f=c/Math.cos(u);a.querySelector(".Navbar-tickInner").style.opacity=l/f}}n=!0}else i.close(t),i.forEach(this.root.querySelectorAll('.Navbar-modalToggle[data-name="'+t.getAttribute("data-toggle")+'"]'),function(t){t.classList.remove("is-active")})}.bind(this)),i.forEach(this.root.querySelectorAll(".Navbar-item"),function(t){n?t.getAttribute("data-target")===o?t.classList.remove("is-faded"):t.classList.add("is-faded"):t.classList.remove("is-faded")}.bind(this)),this.root.classList.toggle("is-focused",n),i.rootClickHandler.call(this.root),i.toggleExpandable.call(this.root),t.stopPropagation(),t.preventDefault(),!1},closeModals:function(){i.forEach((this||document).querySelectorAll(".Navbar .Navbar-item"),function(t){t.classList.remove("is-active"),t.classList.remove("is-faded")}),i.forEach((this||document).querySelectorAll(".Navbar .Navbar-modal.is-open"),function(t){i.close(t)}),this&&this.classList?this.classList.remove("is-focused"):i.forEach(document.querySelectorAll(".Navbar"),function(t){t.classList.remove("is-focused")}),this&&i.toggleExpandable.call(this),i.unblockScrolling()},isOpen:function(t){return t.classList.contains("is-open")},open:function(t){t.classList.add("is-open")},close:function(t){t.classList.remove("is-open")},blockScrolling:function(){document.body.classList.add("Navbar-blockScrolling")},unblockScrolling:function(){document.body.classList.remove("Navbar-blockScrolling")},setModalDisplayStateAfterAnimation:function(t){return i.isOpen(this)?i.showModal(this):i.hideModal(this),t.stopPropagation(),t.preventDefault(),!1},showModal:function(t){t.classList.add("is-displayed")},hideModal:function(t){t.classList.remove("is-displayed")},toggleExpandable:function(t){i.forEach(this.querySelectorAll(".Navbar-expandable"),function(e){var o=e.querySelector(".Navbar-expandableContainer");if(e!=t||i.isOpen(e))o.style.height="0px",e.NavbarAnimationTimeout=setTimeout(function(){i.close(e)}.bind(e),i.DEFAULT_ANIMATION_DURATION);else{e.NavbarAnimationTimeout&&clearTimeout(e.NavbarAnimationTimeout),o.style.height="0px",i.open(e);var n=e.querySelector(".Navbar-expandableContent");o.style.height=n.offsetHeight+"px"}})},checkDisabled:function(t){return t&&t.classList&&t.classList.contains("is-disabled")},checkPromotionId:function(t){if(localStorage){var e=localStorage.getItem(i.KEY_PROMOTIONS_READ)?JSON.parse(localStorage.getItem(i.KEY_PROMOTIONS_READ)):{};return!!e[t]}return!1},savePromotionId:function(t){if(localStorage){var e=localStorage.getItem(i.KEY_PROMOTIONS_READ)?JSON.parse(localStorage.getItem(i.KEY_PROMOTIONS_READ)):{};e[t]=!0,localStorage.setItem(i.KEY_PROMOTIONS_READ,JSON.stringify(e))}},checkPromotions:function(t){if(!i.checkDisabled(t)){var e=t.getAttribute("data-notification-url"),o=t.querySelector(".Navbar-cookieCompliance.is-open");o||i.get(e,function(e){if(e&&!i.checkDisabled(t)){var o={};try{o=JSON.parse(e);var n=o.notifications||o.notificationsList;if(o.totalNotifications&&n)for(var a in n){var r=n[a];if(!i.checkPromotionId(r.id)){var s=t.querySelector(".Navbar-promotion");i.showPromotion(s,r.id,r.img?r.img.url:null,r.title,r.content,r.httpLink?r.httpLink.content:"",r.httpLink?r.httpLink.link:""),s.querySelector(".Navbar-promotionLink").addEventListener("click",i.setPromotionAsRead.bind(s)),s.querySelector(".Navbar-toastClose").addEventListener("click",i.dismissPromotion.bind(s,!0));break}}}catch(c){}}},function(t){})}},showPromotion:function(t,e,o,n,a,r,s){if(e&&t.setAttribute(i.DATA_PROMOTION_ID,e),o&&(t.querySelector(".Navbar-promotionImage").src=o),n&&(t.querySelector(".Navbar-promotionLabel").innerHTML=n),a&&"string"==typeof a&&(a=a.trim(),t.querySelector(".Navbar-promotionText").innerHTML=a),r&&(t.querySelector(".Navbar-promotionLink").innerHTML=r),s){var c=t.querySelector(".Navbar-promotionLink");c.href=s,t.addEventListener("click",i.promotionClickHandler),c.addEventListener("click",i.promotionLinkClickHandler.bind(t))}t.classList.add("is-open"),t.addEventListener("click",i.promotionClickHandler);var l=t.querySelector(".Navbar-promotionLabel").innerHTML;i.pushGlobalNotificationAnalyticsEvent("Open - Automatic",e,l)},dismissPromotion:function(t){var e=i.hideToast.bind(this);this.hideToast=e,this.addEventListener("animationend",e),this.classList.add("is-dismissed");var o=parseInt(this.getAttribute(i.DATA_PROMOTION_ID)),n=this.querySelector(".Navbar-promotionLabel").innerHTML;t&&(i.setPromotionAsRead.call(this),event.stopPropagation(),event.preventDefault()),i.pushGlobalNotificationAnalyticsEvent(t?"Close - X":"Close - Background",o,n)},setPromotionAsRead:function(){var t=parseInt(this.getAttribute(i.DATA_PROMOTION_ID));i.savePromotionId(t)},hideToast:function(){this.hideToast&&this.removeEventListener("animationend",this.hideToast),this.classList.remove("is-dismissed"),this.classList.remove("is-open")},promotionClickHandler:function(){return event.stopPropagation(),!1},promotionLinkClickHandler:function(){var t=parseInt(this.getAttribute(i.DATA_PROMOTION_ID)),e=this.querySelector(".Navbar-promotionLabel").innerHTML;try{i.pushGlobalNotificationAnalyticsEvent("Click - Button",t,e)}catch(o){}return!0},showCookieCompliance:function(t){var e=t.querySelector(".Navbar-cookieCompliance"),o=!0;if(e){if(localStorage&&(agreedMillis=localStorage.getItem(i.KEY_COOKIES_AGREED),agreedMillis)){var n=new Date((new Date).setFullYear((new Date).getFullYear()-1)).getTime();agreedMillis>n&&(o=!1)}o&&(e.classList.add("is-open"),e.querySelector("#cookie-compliance-agree").addEventListener("click",i.dismissCookieCompliance.bind(e)),e.querySelector(".Navbar-toastClose").addEventListener("click",i.dismissCookieCompliance.bind(e,!0)))}},dismissCookieCompliance:function(){var t=i.hideToast.bind(this);this.hideToast=t,this.addEventListener("animationend",t),this.classList.add("is-dismissed"),localStorage&&localStorage.setItem(i.KEY_COOKIES_AGREED,(new Date).getTime())},checkSupportNotifications:function(t){var e=t.getAttribute("data-support-url"),o="NavbarSupportTicketCallback"+(new Date).getTime()+"_"+Math.round(1e5*Math.random());window[o]=i.setSupportNotificationCount.bind(i,t);var n=document.createElement("script");n.src=e+"window."+o,document.getElementsByTagName("head")[0].appendChild(n)},setSupportNotificationCount:function(t,e){var o=e&&e.total?e.total:0;o&&o>0?(this.forEach(t.querySelectorAll(".Navbar-supportCounter, .Navbar-accountDropdownSupport .Navbar-accountDropdownCounter"),function(t){t.innerHTML=""+o}),t.classList.add("is-support-active")):(t.classList.remove("is-support-active"),this.forEach(t.querySelectorAll(".Navbar-supportCounter, .Navbar-accountDropdownSupport .Navbar-accountDropdownCounter"),function(t){t.innerHTML="0"}))},forEach:function(t,e){if(t&&t.length&&"function"==typeof e)for(var o=0;o<t.length;o++)e(t[o],o,t)},request:function(t,e,o,i){var n=new XMLHttpRequest;n.open(t,e),n.onreadystatechange=function(t,e){4===this.readyState&&(200===this.status?t(this.responseText):e(this.status))}.bind(n,o,i),n.send()},get:function(t,e,o){return i.request("GET",t,e,o)},authenticate:function(t){var e=t.getAttribute("data-auth-url");i.get(e,function(e){if(e){var o={};try{o=JSON.parse(e),i.login(t,o)}catch(n){}}},function(t){})},login:function(t,e){if(e){var o="",n="",a="",r=(e.email||"").toLowerCase();e.account&&e.account.battleTag?(o=n=e.account.battleTag.name||n,a=e.account.battleTag.code||a,a&&"#"!==a.charAt(0)&&(a="#"+a)):r&&(o=r.length>12?r.substring(0,12):r),t.classList.add("is-authenticated"),e.flags&&e.flags.employee&&t.classList.add("is-employee"),t.querySelector(".Navbar .Navbar-accountAuthenticated").innerHTML=o,i.forEach(t.querySelectorAll(".Navbar-accountDropdownLoggedIn"),function(t){t.querySelector(".Navbar-accountDropdownBattleTag").innerHTML=n,t.querySelector(".Navbar-accountDropdownBattleTagNumber").innerHTML=a,t.querySelector(".Navbar-accountDropdownEmail").innerHTML=r}),i.checkSupportNotifications(t)}},setTickOffset:function(t,e){e.style.left="";var o=t.offsetWidth/2+t.getBoundingClientRect().left-e.getBoundingClientRect().left-i.TICK_MULTIPLIER*e.offsetWidth/2;return e.style.left=o+"px",o},setVerticalTickOffset:function(t,e){e.style.top="";var o=e.offsetHeight+t.getBoundingClientRect().top-e.getBoundingClientRect().top-i.TICK_MULTIPLIER*e.offsetHeight/2;return e.style.top=o+"px",o},toggleLocaleSelector:function(){this.querySelector(".NavbarFooter-selector").classList.contains("is-open")?i.closeLocaleSelector.call(this):i.openLocaleSelector.call(this)},openLocaleSelector:function(){this.classList.add("is-focused"),this.querySelector(".NavbarFooter-selector").classList.add("is-open");var t=this.querySelector(".NavbarFooter-selectorToggleArrow"),e=this.querySelector(".NavbarFooter-selectorTick");i.setTickOffset(t,e),(this.classList.contains("is-region-limited")||this.classList.contains("is-region-hybrid"))&&i.changeFooterRegionLimit.call(this,this.querySelector(".NavbarFooter-selectorRegion.is-active"));var o=document.querySelector(".Navbar-promotion.is-open");o&&i.dismissPromotion.call(o,!1),i.blockScrolling()},closeLocaleSelector:function(){this.classList.remove("is-focused"),this.querySelector(".NavbarFooter-selector").classList.remove("is-open"),i.unblockScrolling()},resizeFooter:function(){var t=i.calcViewportWidth();t!==i.viewportWidthFooter&&(i.viewportWidthFooter=t,this&&this.classList.contains("is-focused")&&i.closeLocaleSelector.call(this))},changeFooterRegionLimit:function(t){var e=t.getAttribute("data-id");i.forEach(this.querySelectorAll(".NavbarFooter-selectorSectionPage.is-open:not([data-region='"+e+"'])"),function(t){t.classList.remove("is-open")}),this.querySelector(".NavbarFooter-selectorSectionPage[data-region='"+e+"']").classList.add("is-open"),i.forEach(this.querySelectorAll(".NavbarFooter-selectorRegion.is-selected:not([data-id='"+e+"'])"),function(t){t.classList.remove("is-selected")}),t.classList.add("is-selected");var o=this.querySelector(".NavbarFooter-selectorRegionTick"),n=i.setVerticalTickOffset(t,o),a=o.querySelector(".NavbarFooter-selectorRegionTickOverlay");a.style.opacity=n/this.querySelector(".NavbarFooter-selectorRegions").offsetHeight},getLocalDomainName:function(){var t,e=window.location.href;return t=e.indexOf("://")>-1?e.split("/")[2]:e.split("/")[0],t=t.split(":")[0]},pushAnalyticsEvent:function(t){window.dataLayer||(window.dataLayer=[]),window.dataLayer.push(t)},pushGlobalNotificationAnalyticsEvent:function(t,e,o){i.pushAnalyticsEvent({event:"globalNotification",analytics:{eventPlacement:t,eventPanel:"id:"+e+" || "+o}})}};!function(){i.forEach(document.querySelectorAll(".Navbar"),function(t){i.init(t)}),i.forEach(document.querySelectorAll(".NavbarFooter"),function(t){i.initFooter(t)})}(),e&&(e.exports=i)},{}]},{},[1,2])(2)});