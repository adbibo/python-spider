<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta property="qc:admins" content="27354635321361636375" />
<meta name="keywords" content="网易云音乐，音乐，播放器，网易，下载，播放，DJ，免费，明星，精选，歌单，识别音乐，收藏，分享音乐，音乐互动，高音质，320K，音乐社交，netease cloud music，cloudmusic，neteasemusic，neteasecloudmusic，music，netease，cloud" />
<meta name="description" content="网易云音乐是一款专注于发现与分享的音乐产品，依托专业音乐人、DJ、好友推荐及社交功能，为用户打造全新的音乐生活。cloud，netease cloud music，cloudmusic，neteasemusic，neteasecloudmusic，music，netease" />
<title>网易云音乐</title>
<script type="text/javascript">
var GDownloadLink="";
var GDevice = "phone";
var GFrom="";
var GClient="";
var GPlatform="other";
var GRef = '';
var GInApp = false;
var GMobile = false;
var GAbroad = false;
var GUser={};
var GAllowRejectComment = false;
var GEnc = true;
var GEnvType = "online";
var GWebpSupport = "1";
window.NEJ_CONF = {p_csrf:{cookie:'__csrf',param:'csrf_token'}};
//线上环境参数配置
window.MUSIC_CONFIG = {
pushHost:'web.push.126.net',
pushPort:'6003',
pushKey:'3b97981848064bbabeaaf2fb1eab7368'
};
GUtil = {
getBase:function(){
return location.protocol+'//'+location.hostname;
},
getPathAndHash:function(_url){//获取URL path 之后的所有内容,并将/#/替换成/m/使之成为path的一部分
if(!_url) return '';
var _reg0 = /^https?:\/\/.*?\//i,
_reg1 = /\/?#\/?/i;
return _url.replace(_reg0,'/').replace(_reg1,'/m/');
},
composeRefer:function(_url,_ref){//对所有的页面请求都加上ref参数表示被嵌套的来源
if(!_ref) return _url;
var _hi = _url.indexOf('#'),
_si = _url.indexOf('?');
if(_si>0&&(_si<_hi||_hi<0)){
return _url.substring(0,_si+1)+'ref='+_ref+'&'+_url.substring(_si+1);
}else if(_hi>0&&(_si<0||_si>_hi)){
return _url.substring(0,_hi)+'?ref='+_ref+_url.substring(_hi);
}else{
return _url+'?ref='+_ref;
}
}
};(function(){
var _ua = window.navigator.userAgent,
_isMobile = /(mobile|mobi|wap|iphone)/i.test(_ua),
_isAndroid = /android/i.test(_ua),
_isIpad = /(ipad)/i.test(_ua),
_igList = [/^\/xiami$/,/^\/live$/],//不需要以单页面打开的列表，比如某些活动页面
_pn = location.pathname,
_idx = _pn.lastIndexOf('/'),
_pReg = /\s*(\w+)\s*=\s*(\d+)\s*/,
_redirect2mobile = function(){
var _type,_murl,
_id = 0,
_hash = location.hash,
_mReg = /^#\/?m?\/(share|song|playlist|djradio|dj|program|album|mv|artist|topic|radio|zysf|drqp|qp|activity|store|user|event|discover\/toplist)(\/(\d+))?/,
_base = location.protocol+'//'+location.hostname,
_sindex = _hash.lastIndexOf('?'),
_search = _sindex>-1?_hash.substring(_sindex+1):'',
_match = _mReg.exec(_hash);
// 无hash || 不匹配 || 匹配但是商品之外不带参数 || 匹配且是活动 || 匹配且是排行榜
if (!_hash.length || !_match || (_match[1]!='store' && !_search) || _hash.indexOf('activity') >= 0 || _hash.indexOf('discover\/toplist')>=0) {
// 有hash && (没有参数 || 活动 || 排行榜)
if ((!_search || _hash.indexOf('activity') >= 0 || _hash.indexOf('discover\/toplist')>=0) && _hash.length) {
location.href = _base + '/' + _hash.replace('#','m');
} else {
location.href = _base+'/m/';
}
return;
}
_type = _match[1];
_id = _match[3];
if (_type == 'dj') _type = 'program';
if (_type == 'store') {
_murl = /^#\/store\/(product|concert)\/detail/.test(_hash) ? _hash.replace('#/store', '/store/m') : '/store/m/product/index';
} else {
_murl = '/' + _type + '?' + (_id ? 'id=' + _id + '&': '') + _search;
}
location.href = _base+_murl;
};
if(_isMobile || _isAndroid || _isIpad){
_redirect2mobile();
return;
}
if(!_pn||_pn=='/') return;
for(var i in _igList){
if(_igList[i].test(_pn)) return;
}
if(top==self){
location.href = '/#'+GUtil.getPathAndHash(location.href);
return;
}
//搜索引擎过来的内容页连接
if(top==self&&/^\/static\/(song|playlist|album|artist)/i.test(_pn)){
location.href = '/#'+_pn.substring(0,_idx).replace('/static/','/')+'?id='+_pn.substring(_idx+1);
}
})();
(function(){
var _addEvent = function(_node,_type,_cb){
if(_node.addEventListener){
_node.addEventListener(_type,_cb);
}else if(_node.attachEvent){
_node.attachEvent('on'+_type,_cb);
}
},
_onAnchorClick = function(_event){//截获所有<a>标签的点击事件，自定义页面的跳转
_event = _event||window.event;
var _el = _event.target||_event.srcElement,
_base = location.protocol+'//'+location.host;
while(_el&&_el!=document){
if(_el.tagName&&_el.tagName.toLowerCase()=='a'){
//fix ie6下有时javascript:;不能阻止默认事件的bug.
if(_el.href.indexOf('javascript:')>=0){
!!_event.preventDefault
? _event.preventDefault()
: _event.returnValue = !1;
return;
}
if(_event.button==2) return;//ff 右键会触发click事件
//商城有独立地顶栏了，排除掉。但会员、数字专辑、单曲的商品、订单页仍保持主站frame，
//这些url往往是通过/vip2, /payfee这样的地址跳转的，也没有问题，如果真的有，URL用#配置就好了
var _path = _el.href.replace(/^https?:\/\/.*?\//i, '/').split(/[?#]/)[0];
if(_path.indexOf('/store/')==0) return;
//新窗口打开的链接、云音乐单页面形式的链接、站外的链接不做拦截处理。
if(_el.target=='_blank'
||_el.target=='blank'
||_isNotSameHost(_el.href)
||_el.href==_base
||_el.href.indexOf(_base+'/#')>=0) return;
!!_event.preventDefault
? _event.preventDefault()
: _event.returnValue = !1;
location.dispatch2(_el.href);
break;
}else{
_el = _el.parentNode;
}
}
},
_isNotSameHost = function(_href){
var _same = true;
if(_href.charAt(0)!='/'){
var _index = _href.indexOf('//'+location.hostname);
if(_index > 0){
var _index2 = _href.indexOf('?');
if(_index2 > 0 && _index2 < _index){
_same = false;
}
}else{
_same = false;
}
}
return !_same;
};
_addEvent(document,'click',_onAnchorClick);
//扩展一个js中直接使用的页面跳转的方法，以拦截js中的页面跳转行为
location.dispatch2 = function(_url,_replace){
var delegate = false;
try{
delegate = !!top.GDispatcher;
}catch(e){
delegate = false;
}
if(delegate){
top.GDispatcher.dispatch(_url,_replace);
}else{
_url = GUtil.composeRefer(_url,GRef);
//邮箱音乐盒中，每次链接的跳转都要将proxy.html的地址合并到hash中
if(GRef&&GRef=='mail'){
var _hindex,_sindex,
_reg = /(https?:\/\/.+\/proxy.html)/,
_hreg = /#(.*?)$/,
_href = decodeURIComponent(location.href);
if(!_reg.test(decodeURIComponent(_url))&&_reg.test(_href)){
_hindex = _url.indexOf('#');
_sindex = _url.lastIndexOf('?');
if(_hindex>0){
_url = _url+(_sindex>_hindex?'&':'?')+'proxy='+encodeURIComponent(RegExp.$1);
}else{
_url = _url+'#proxy='+encodeURIComponent(RegExp.$1);
}
}
}
if(_replace){
location.replace(_url);
}else{
location.href = _url;
}
}
};
})();</script>
<link rel="shortcut icon" href="//s1.music.126.net/music.ico?v1" />
<link href="//s2.music.126.net/sep/s/2/core.css?23cf839af471c68a2f6b2b1cef8f3e4f" type="text/css" rel="stylesheet"/><link href="//s2.music.126.net/sep/s/2/pt_frame.css?1fc7f07ff663684d9762134c3cb4c848" type="text/css" rel="stylesheet"/>
<style>html,body{overflow:hidden;}</style>
<script>if(top!=self)top.location=self.location;</script>
</head>
<body>
<div id="g-topbar" class="g-topbar f-oys">
<div class="m-top">
<div class="wrap">
<h1 class="logo"><a hidefocus="true" href="/#">网易云音乐</a></h1>
<ul class="m-nav j-tflag">
<li class="fst">
<span><a hidefocus="true" href="/#" data-module="discover"><em>发现音乐</em><sub class="cor">&nbsp;</sub></a></span>
</li>
<li>
<span><a data-res-action="bilog" data-log-action="page" data-log-json='{"type":"my"}' hidefocus="true" href="/my/" data-module="my"><em>我的音乐</em><sub class="cor">&nbsp;</sub></a></span>
</li>
<li>
<span><a hidefocus="true" href="/friend" data-module="friend"><em>朋友</em><sub class="cor">&nbsp;</sub><i class="dot u-icn u-icn-68 f-alpha j-t" style="display:none;"></i></a></span>
</li>
<li>
<span><a hidefocus="true" href="/store/product" target="_blank" data-module="store"><em>商城</em></a></span>
</li>
<li>
<span><a hidefocus="true" href="/nmusician/web/recruit" target="_blank" data-module="musician"><em>音乐人</em></a></span>
</li>
<li class="lst">
<span><a id="topbar-download-link" data-res-action="bilog" data-log-action="page" data-log-json='{"type":"downloadapp"}' hidefocus="true" href="/download" data-module="download"><em>下载客户端</em><sub class="cor">&nbsp;</sub></a></span><sup class="hot">&nbsp;</sup>
</li>
</ul>
<div class="m-tophead f-pr j-tflag"></div>
<a class="m-msg f-pr j-tflag" href="/msg/#/at" style="display:none;"></a>
<div class="m-srch f-pr j-suggest" id="g_search">
<div class="srchbg">
<span class="parent">
<input type="text" class="txt j-flag" value=""/>
<label class="ph j-flag">单曲/歌手/专辑/歌单/MV/用户</label>
</span>
</div>
<div class="j-showoff u-showoff f-hide"><p>现在支持搜索MV啦~</p></div>
<span class="j-flag" style="display:none;">&nbsp;</span>
<div class="u-lstlay j-flag" style="display:none;"></div>
</div>
</div>
</div>
<div class="m-subnav m-subnav-up f-pr j-tflag">
<div class="shadow">&nbsp;</div>
</div>
<div id="g_nav2" class="m-subnav f-hide j-tflag">
<div class="wrap f-pr">
<ul class="nav">
<li><a hidefocus="true" data-module="discover" href="/discover"><em>推荐</em></a></li>
<li><a hidefocus="true" data-module="toplist" href="/discover/toplist"><em>排行榜</em></a></li>
<li><a hidefocus="true" data-module="playlist" href="/discover/playlist"><em>歌单</em></a></li>
<li><a hidefocus="true" data-module="djradio" href="/discover/djradio"><em>主播电台</em></a></li>
<li><a hidefocus="true" data-module="artist" href="/discover/artist"><em>歌手</em></a></li>
<li><a hidefocus="true" data-module="album" href="/discover/album"><em>新碟上架</em></a></li>
</ul>
</div>
</div>
</div>
<iframe name="contentFrame" id="g_iframe" class="g-iframe" scrolling="auto" frameborder="0" src="about:blank"></iframe>
<script type="text/javascript">
var GUserAcc={topic:1, reward:false};
(function(){
var topbar = document.getElementById('g-topbar'),
scrollBarWidth = document.body.clientWidth - topbar.clientWidth;
topbar.style.width = topbar.clientWidth+'px';
topbar.className = 'g-topbar';
if(window.addEventListener){
window.addEventListener('resize', onResize)
}else{
window.attachEvent('onresize', onResize)
}
function onResize(){
topbar.style.width = (document.body.clientWidth-scrollBarWidth)+'px';
};
})();/*!
* Copyright (c) 2009-2011 Andreas Blixt <andreas@blixt.org>
* Contributors: Aaron Ogle <aogle@avencia.com>,
* Matti Virkkunen <mvirkkunen@gmail.com>,
* Simon Chester <simonches@gmail.com>
* http://github.com/blixt/js-hash
* MIT License: http://www.opensource.org/licenses/mit-license.php
*
* Hash handler
* Keeps track of the history of changes to the hash part in the address bar.
*/
/* WARNING for Internet Explorer 7 and below:
* If an element on the page has the same ID as the hash used, the history will
* get messed up.
*
* Does not support history in Safari 2 and below.
*
* Example:
* function handler(newHash, initial) {
* if (initial)
* alert('Hash is "' + newHash + '"');
* else
* alert('Hash changed to "' + newHash + '"');
* }
* Hash.init(handler);
* Hash.go('abc123');
*
*
* Updated by Simon Chester (simonches@gmail.com) on 2011-05-16:
* - Removed the need for blank.html and the iframe argument by creating the
* iframe on initialization.
*
* Updated by Matti Virkkunen (mvirkkunen@gmail.com) on 2009-11-16:
* - Added second argument to callback that indicates whether the callback is
* due to initial state (true) or due to an actual change to the hash
* (false).
*
* Updated by Aaron Ogle (aogle@avencia.com) on 2009-08-11:
* - Fixed bug where Firefox automatically unescapes location.hash but no
* other browsers do. Always get the hash by parsing location.href and
* never use location.hash.
*/
var Hash = (function () {
var
// Import globals
window = this,
documentMode = document.documentMode,
history = window.history,
// Plugin variables
callback, hash,
// IE-specific
iframe,
getHash = function () {
// Internet Explorer 6 (and possibly other browsers) extracts the query
// string out of the location.hash property into the location.search
// property, so we can't rely on it. The location.search property can't be
// relied on either, since if the URL contains a real query string, that's
// what it will be set to. The only way to get the whole hash is to parse
// it from the location.href property.
//
// Another thing to note is that in Internet Explorer 6 and 7 (and possibly
// other browsers), subsequent hashes are removed from the location.href
// (and location.hash) property if the location.search property is set.
//
// Via Aaron: Firefox 3.5 (and below?) always unescape location.hash which
// causes poll to fire the hashchange event twice on escaped hashes. This
// is because the hash variable (escaped) will not match location.hash
// (unescaped.) The only consistent option is to rely completely on
// location.href.
var index = window.location.href.indexOf('#');
return (index == -1 ? '' : window.location.href.substr(index + 1));
},
// Used by all browsers except Internet Explorer 7 and below.
poll = function () {
var curHash = getHash();
if (curHash != hash) {
hash = curHash;
callback(curHash, false);
}
},
// From:
// http://perfectionkills.com/detecting-event-support-without-browser-sniffing/
isHashChangeSupported = function() {
var eventName = 'onhashchange';
var isSupported = (eventName in document.body);
if (!isSupported) {
document.body.setAttribute(eventName, 'return;');
isSupported = typeof document.body[eventName] == 'function';
}
// documentMode logic from YUI to filter out IE8 Compat Mode (which
// generates false positives).
return isSupported && (document.documentMode === undefined ||
document.documentMode > 7);
},
createIframe = function () {
var tempEl = document.createElement();
tempEl.innerHTML = '<iframe src="javascript:void(0)" tabindex="-1" ' +
'style="display: none;"></iframe>';
var frame = tempEl.childNodes[0];
document.body.appendChild(frame);
return frame;
},
// Used to create a history entry with a value in the iframe.
setIframe = function (newHash) {
try {
var doc = iframe.contentWindow.document;
doc.open();
doc.write('<html><body>' + newHash + '</body></html>');
doc.close();
hash = newHash;
} catch (e) {
setTimeout(function () { setIframe(newHash); }, 10);
}
},
// Used by Internet Explorer 7 and below to set up an iframe that keeps track
// of history changes.
setUpIframe = function () {
// Don't run until access to the body is allowed.
try {
iframe = createIframe();
} catch (e) {
setTimeout(setUpIframe, 10);
return;
}
// Create a history entry for the initial state.
setIframe(hash);
var data = hash;
setInterval(function () {
var curData, curHash;
try {
curData = iframe.contentWindow.document.body.innerText;
if (curData != data) {
data = curData;
window.location.hash = hash = curData;
callback(curData, true);
} else {
curHash = getHash();
if (curHash != hash) setIframe(curHash);
}
} catch (e) {
}
}, 50);
};
return {
init: function (cb) {
// init can only be called once.
if (callback) return;
callback = cb;
// Keep track of the hash value.
hash = getHash();
cb(hash, true);
if (isHashChangeSupported()) {
if (window.addEventListener){
window.addEventListener('hashchange', poll, false);
} else if (window.attachEvent){
window.attachEvent('onhashchange', poll);
}
} else {
// Run specific code for Internet Explorer.
if (window.ActiveXObject) {
if (!documentMode || documentMode < 8) {
// Internet Explorer 5.5/6/7 need an iframe for history
// support.
setUpIframe();
}
} else {
// Change Opera navigation mode to improve history support.
if (history.navigationMode) {
history.navigationMode = 'compatible';
}
setInterval(poll, 50);
}
}
},
go: function (newHash) {
// Cancel if the new hash is the same as the current one, since there
// is no cross-browser way to keep track of navigation to the exact
// same hash multiple times in a row. A wrapper can handle this by
// adding an incrementing counter to the end of the hash.
if (newHash == hash) return;
if (iframe) {
setIframe(newHash);
} else {
window.location.hash = hash = newHash;
callback(newHash, false);
}
}
};
})();var GDispatcher = (function(){
var _lastPage = '',
_igReg = /f=(.*?)/,
_hReg = /\/?#.*/,
_xssReg = /(java|vb)script/,//xss注入
_default = '/discover';
function _isIE10plus(){
var _ua = window.navigator.userAgent;
return (/msie\s+(.*?);/i.test(_ua)||/trident\/.+rv:([\d\.]+)/i.test(_ua))&&(parseInt(RegExp.$1)>=10);
};
function _onHashChange(_hash){
var _url,
_iframe = document.getElementById('g_iframe');
if(!_hash||_igReg.test(_hash)||_xssReg.test(_hash)){//忽略统计来源的hash
_url = _default;
}else{
_hash = _hash.replace(/\/+/g, '/');//#29664 http://music.163.com/#// 会死循环
var _midx = -1;
if((_midx=_hash.indexOf('store/m/'))>=0){
_url = _hash.substring(0, _midx+8)+(_hash.substring(_midx+8).replace('/m/','/#/'));
}else{
_url = _hash.replace('/m/','/#/');
}
}
if(_url.indexOf('http://')<0){
_url = location.protocol+'//'+location.hostname+_url;
}
//针对ie10+ location.replace的bug做特殊处理
if(_isIE10plus()){
if(_lastPage.replace(_hReg,'')==_url.replace(_hReg,'')){//只是hash的改变
_iframe.contentWindow.location.replace(_url);
} else{
_iframe.parentNode.removeChild(_iframe);
_iframe = document.createElement('iframe');
_iframe.id = 'g_iframe';
_iframe.src = 'about:blank';
_iframe.className = 'g-iframe';
document.body.insertAdjacentElement('afterBegin',_iframe);
_iframe.contentWindow.location.href = _url;
}
}else{
_iframe.contentWindow.location.replace(_url);
}
_lastPage = _url;
if(typeof window.onHashChange=='function'){
window.onHashChange(_hash);
}
};
Hash.init(_onHashChange);
return {
dispatch:function(_url,_replace){
var _ph = GUtil.getPathAndHash(_url);
if(!_ph) return;
if(_replace){
location.replace(GUtil.getBase()+'#'+_ph);
}else{
location.hash = _ph;
}
},
refreshIFrame:function(_url){
_onHashChange(_url);
}
};
})();</script>
<div class="g-btmbar">
<div class="m-playbar m-playbar-unlock" style="top:-53px;">
<div class="updn">
<div class="left f-fl"><a href="javascript:;" class="btn" hidefocus="true" data-action="lock"></a></div>
<div class="right f-fl"></div>
</div>
<div class="bg"></div>
<div class="hand" title="展开播放条"></div>
<div class="wrap" id="g_player">
<div class="btns">
<a href="javascript:;" hidefocus="true" data-action="prev" class="prv" title="上一首(ctrl+←)">上一首</a>
<a href="javascript:;" hidefocus="true" data-action="play" class="ply j-flag" title="播放/暂停(p)">播放/暂停</a>
<a href="javascript:;" hidefocus="true" data-action="next" class="nxt" title="下一首(ctrl+→)">下一首</a>
</div>
<div class="head j-flag"><img src="http://s4.music.126.net/style/web2/img/default/default_album.jpg"><a href="javascript:;" hidefocus="true" class="mask"></a></div>
<div class="play">
<div class="j-flag words"></div>
<div class="m-pbar" data-action="noop">
<div class="barbg j-flag">
<div class="rdy" style="width:0%;"></div>
<div class="cur" style="width:0%;"><span class="btn f-tdn f-alpha"><i></i></span></div>
</div>
<span class="j-flag time"><em>00:00</em> / 00:00</span>
</div>
</div>
<div class="oper f-fl">
<a href="javascript:;" hidefocus="true" data-action="like" class="icn icn-add j-flag" title="收藏">收藏</a>
<a href="javascript:;" hidefocus="true" data-action="share" class="icn icn-share" title="分享">分享</a>
</div>
<div class="ctrl f-fl f-pr j-flag">
<div class="m-vol" style="visibility:hidden;">
<div class="barbg"></div>
<div class="vbg j-t"><div class="curr j-t"></div>
<span class="btn f-alpha j-t"></span></div>
</div>
<a href="javascript:;" hidefocus="true" data-action="volume" class="icn icn-vol"></a>
<a href="javascript:;" hidefocus="true" data-action="mode" class="icn icn-shuffle" title="随机"></a>
<span class="add f-pr">
<span class="tip" style="display:none;">已添加到播放列表</span>
<a href="javascript:;" title="播放列表" hidefocus="true" data-action="panel" class="icn icn-list s-fc3">0</a>
</span>
<div class="tip tip-1" style="display:none;"></div>
</div>
</div>
</div>
</div>
<div id="template-box" style="display:none;"> <textarea name="ntp" id="ntp-login-nav" style="display:none;"><div class="lyct lyct-1">
<div class="n-log2 n-log2-1 f-cb">
<div class="u-main">
<div class="u-plt"></div>
<div class="f-mgt10">
<a href="javascript:;" class="u-btn2 u-btn2-2" data-action="login" data-type="mobile"><i>手机号登录</i></a>
</div>
<div class="f-mgt10">
<a href="javascript:;" class="u-btn2 u-btn2-1" data-action="reg"><i>注&#12288;册</i></a>
</div>
</div>
<div class="u-alt">
<ul>
<li><a href="http://music.163.com/api/sns/authorize?snsType=10&clientType=web2&callbackType=Login&forcelogin=true" target="_blank" data-action="login" data-type="thirdparty"><i class="u-mlg2 u-mlg2-wx"></i>微信登录</a></li>
<li><a href="http://music.163.com/api/sns/authorize?snsType=5&clientType=web2&callbackType=Login&forcelogin=true" target="_blank" data-action="login" data-type="thirdparty"><i class="u-mlg2 u-mlg2-qq"></i>QQ登录</a></li>
<li><a href="http://music.163.com/api/sns/authorize?snsType=2&clientType=web2&callbackType=Login&forcelogin=true" target="_blank" data-action="login" data-type="thirdparty"><i class="u-mlg2 u-mlg2-sn"></i>微博登录</a></li>
<li><a href="javascript:;" data-action="login" data-type="netease"><i class="u-mlg2 u-mlg2-wy"></i>网易邮箱帐号登录</a></li>
</ul>
</div>
</div>
</div>
</textarea>
<textarea name="ntp" id="ntp-login-mobile" style="display:none;"><div class="lyct lyct-1">
<div class="n-log2 n-log2-2">
<div>
<input type="text" class="js-input u-txt" placeholder="请输入手机号">
</div>
<div class="f-mgt10">
<input type="password" class="js-input u-txt" placeholder="请输入密码">
</div>
<div class="u-err" style="display:none;"><i class="u-icn u-icn-25"></i><span></span></div>
<div class="f-mgt10">
<label class="s-fc3"><input type="checkbox" checked="checked" class="u-auto">自动登录</label>
<a href="#" class="f-fr s-fc3" data-action="forget">忘记密码？</a>
</div>
<div class="f-mgt20">
<a class="js-primary u-btn2 u-btn2-2" hidefocus="true" href="#" data-action="login"><i>登&#12288;录</i></a>
</div>
</div>
<div class="js-btmbar n-loglink2 f-cb">
<a href="javascript:;" data-action="select" class="f-fl s-primary">&lt;&nbsp;&nbsp;其他登录方式</a>
<a href="javascript:;" data-action="reg" class="f-fr">没有帐号？免费注册&nbsp;&nbsp;&gt;</a>
</div>
</div>
</textarea>
<textarea name="ntp" id="ntp-login-netease" style="display:none;"><div class="lyct lyct-1 f-cb">
<div class="n-log2 n-log2-2">
<div class="f-pr" style="z-index:5;">
<input type="text" class="js-input u-txt" placeholder="请输入帐号">
<ul class="js-suggest u-fill" style="visibility:hidden;"></ul>
</div>
<div class="f-mgt10">
<input type="password" class="js-input u-txt" placeholder="请输入密码">
</div>
<div class="u-err" style="display:none;"><i class="u-icn u-icn-25"></i><span></span></div>
<div class="f-mgt10">
<label class="s-fc3"><input type="checkbox" checked="checked" class="u-auto">自动登录</label>
<a href="//reg.163.com/getpasswd/RetakePassword.jsp" target="_blank" class="f-fr s-fc3">忘记密码？</a>
</div>
<div class="f-mgt20">
<a class="js-primary u-btn2 u-btn2-2" hidefocus="true" href="#" data-action="login"><i>登&#12288;录</i></a>
</div>
</div>
<div class="n-loglink2"><a href="javascript:;" data-action="select" class="s-primary">&lt;&nbsp;&nbsp;其他登录方式</a></div>
</div>
</textarea>
<textarea name="jst" id="jst-login-suggest" style="display:none;">{list suggests as item}
<li class="f-thide"><a href="#" data-action="suggest" title="${item|escape}">${item|escape}</a></li>
{/list}
</textarea>
<textarea name="ntp" id="ntp-reg-mobile" style="display:none;"><div class="lyct lyct-1 f-cb">
<div class="n-log2 n-log2-2">
<div class="s-fc3"><label>手机号：</label></div>
<div class="f-mgt10">
<div class="u-txtwrap">
<span class="u-prefix">+86</span>
<input type="text" class="u-txt" placeholder="请输入手机号">
</div>
</div>
<div class="f-mgt10 s-fc3"><label>密码：</label></div>
<div class="f-mgt10">
<input type="password" class="u-txt f-mgt10" placeholder="设置登录密码，不少于6位">
</div>
<div class="u-err" class="f-hide"><i class="u-icn u-icn-25"></i><span></span></div>
<div class="f-mgt20">
<a class="u-btn2 u-btn2-2" hidefocus="true" href="#" data-action="ok"><i>下一步</i></a>
</div>
</div>
<div class="n-loglink2"><a href="javascript:;" data-action="back" class="s-primary">&lt;&nbsp;&nbsp;返回登录</a></div>
</div>
</textarea>
<textarea name="ntp" id="ntp-verifycaptcha" style="display:none;"><div class="lyct lyct-1 f-cb">
<div class="n-log2 n-log2-2">
<p class="js-tip f-hide u-tip">云音乐将不再支持 <strong class="s-fc1">腾讯微博</strong> 登录方式，<br/>请绑定手机号，以免后续无法使用该帐号</p>
<div class="js-mobwrap f-hide f-pdb20">
<p class="s-fc3">你的手机号：<strong class="js-mob s-fc1"></strong></p>
<p class="s-fc4 f-mgt5">为了安全，我们会给你发送短信验证码</p>
</div>
<div class="js-mobwrap f-hide f-pdb10">
<div class="s-fc3"><label class="js-lbl"></label></div>
<div class="f-mgt10">
<div class="u-txtwrap">
<span class="u-prefix">+86</span>
<input type="text" class="js-txt u-txt" placeholder="请输入手机号">
</div>
</div>
<div class="s-fc3 f-mgt10"><label>验证码：</label></div>
</div>
<div class="f-cb">
<input type="text" class="js-txt u-txt u-txt2" placeholder="请输入验证码" value="">
<span class="js-cd u-cd f-hide"></span>
<a href="#" class="js-send u-btn2 u-btn2-1 f-hide" data-action="send"><i>获取验证码</i></a>
</div>
<div class="u-err"><i class="u-icn u-icn-25"></i><span></span></div>
<div class="f-mgt20">
<a class="js-next u-btn2 u-btn2-2" hidefocus="true" href="#" data-action="next"><i></i></a>
</div>
</div>
<div class="js-btmbar n-loglink2 f-cb f-hide">
<a href="javascript:;" data-action="back" class="js-back f-hide f-fl s-primary">&lt;&nbsp;&nbsp;返回登录</a>
<a href="javascript:;" data-action="skip" class="js-skip f-hide f-fr">跳过&nbsp;&nbsp;&gt;</a>
</div>
</div>
</textarea>
<textarea name="ntp" id="ntp-setnickname" style="display:none;"><div class="lyct lyct-1 f-cb">
<div class="n-log2 n-log2-3">
<p class="s-fc1 f-tc">取一个昵称，让大家记住你</p>
<div class="f-mgt20">
<input type="text" class="js-flag u-txt" placeholder="昵称不少于4个字母或2个汉字">
</div>
<div class="f-cb ScapTcha js-flag" style="margin-top:10px;"></div>
<div class="u-err js-flag" class="f-hide"><i class="u-icn u-icn-25"></i><span></span></div>
<div class="f-mgt20">
<a class="u-btn2 u-btn2-2 js-flag" hidefocus="true" href="#" data-action="ok"><i>开启云音乐</i></a>
</div>
</div>
</div>
</textarea>
<textarea name="ntp" id="ntp-reg-setting" style="display:none;"><div class="lyct lyct-1 f-cb">
<div class="n-log2 n-log2-3">
<p class="js-tip s-fc1 f-tc f-mg20">取一个昵称，让大家记住你</p>
<div class="f-mgt20">
<input type="text" class="js-input u-txt" placeholder="昵称不少于4个字母或2个汉字">
</div>
<div class="u-err" class="f-hide"><i class="u-icn u-icn-25"></i><span></span></div>
<div class="f-mgt20">
<a class="js-primary u-btn2 u-btn2-2" hidefocus="true" href="#" data-action="ok"><i>开启云音乐</i></a>
</div>
</div>
</div>
</textarea>
<textarea name="ntp" id="ntp-setpassword" style="display:none;"><div class="lyct lyct-1 f-cb">
<div class="n-log2 n-log2-3">
<p class="js-tip u-tip f-hide">云音乐将不再支持 <strong class="s-fc1">腾讯微博</strong> 登录方式，<br/>设置登录密码，以后可以使用手机号登录</p>
<p class="js-tip s-fc3 f-hide">你的手机号：<strong class="js-mob s-fc1"></strong></p>
<p class="js-tip s-fc3 f-mg20 f-tc f-hide">设置密码后，可以直接用该手机号+密码登录</p>
<div class="f-mgt10">
<input type="password" class="js-input u-txt f-mgt10" placeholder="设置登录密码，不少于6位">
</div>
<div class="u-err"><i class="u-icn u-icn-25"></i><span></span></div>
<div class="f-mgt20">
<a class="js-primary u-btn2 u-btn2-2" hidefocus="true" href="#" data-action="ok"><i></i></a>
</div>
</div>
<div class="js-btmbar n-loglink2 f-cb f-hide">
<a href="javascript:;" data-action="skip" class="f-fr">跳过&nbsp;&nbsp;&gt;</a>
</div>
</div>
</textarea>
<textarea name="txt" id="txt-login-captcha" style="display:none;"><div class="f-mgt10">
<input id="captcha" type="text" class="u-txt u-code j-flag" placeholder="请输入验证码">
<img class="u-captcha j-flag" src="">
</div>
</textarea>
<textarea name="ntp" id="m-captcha-layer" style="display:none;"><div class="wrap">
<p class="s-fc3">如果你不是机器人输入验证码一定没问题！</p>
<p class="input f-cb j-flag">
</p>
<div class="u-err f-hide j-flag"><i class="u-icn u-icn-25"></i>帐号或密码错误</div>
<div class="btnwrap">
<a data-action="ok" class="u-btn2 u-btn2-2 u-btn2-w2" hidefocus="true" href="javascript:;"><i>确 定</i></a>
<a data-action="cc" class="u-btn2 u-btn2-1 u-btn2-w2" hidefocus="true" href="javascript:;"><i>取消</i></a>
</div>
</div>
</textarea>
<textarea name="jst" id="m-player-playinfo" style="display:none;"> <a hidefocus="true" href="${titleUrl}" class="f-thide name fc1 f-fl" title="${name}">${name}{if type=='program'}[电台节目]{/if}</a>
{if mvid > 0}
<a hidefocus="true" href="/mv?id=${mvid}" class="mv f-fl" title="MV"></a>
{/if}
<span class="by f-thide f-fl">
${artistHtml}
</span>
{if source}<a href="${source.link}" class="src" title="来自${source.title}"></a>{/if}
</textarea>
<textarea name="ntp" id="m-player-panel" style="display:none;"><div class="list" id="g_playlist">
<div class="listhd">
<div class="listhdc">
<h4>播放列表(<span class="j-flag">0</span>)</h4>
<a href="javascript:;" class="addall" data-action="likeall"><span class="ico ico-add"></span>收藏全部</a><span class="line"></span>
<a href="javascript:;" class="clear" data-action="clear"><span class="ico icn-del"></span>清除</a>
<p class="lytit f-ff0 f-thide j-flag"></p>
<span class="close" data-action="close">关闭</span>
</div>
</div>
<div class="listbd">
<img class="imgbg j-flag"/>
<div class="msk"></div>
<div class="listbdc j-flag">
</div>
<div class="bline j-flag"><span class="scrol" hidefocus="true"></span></div>
<div class="ask j-flag">
<a class="ico ico-ask"></a>
</div>
<div class="upload j-flag">
</div>
<div class="msk2"></div>
<div class="listlyric j-flag"></div>
<div class="bline bline-1 j-flag">
<span class="scrol scrol-1 j-flag" hidefocus="true"></span>
</div>
</div>
</div>
</textarea>
<textarea name="jst" id="m-player-lyric-ask" style="display:none;"> {if !nolyric}
{if sgc}
<a href="/lyric/up?id=${songId}">上传歌词</a>
{/if}
{if lrc&&lrc.lyric&&sfy}
<a href="/lyric/{if scrollable}translrc{else}trans{/if}?id=${songId}">翻译歌词</a>
{/if}
{/if}
<a data-action="close" href="/lyric/report?id=${songId}">{if !(lrc&&lrc.lyric)}歌曲{/if}报错</a>
</textarea>
<textarea name="jst" id="m-player-queue" style="display:none;">{if queue&&queue.length}
<ul class="f-cb">
{list queue as x}
<li {if current&&x.id==current.id}class="z-sel"{/if} data-id="${x.id}" data-action="play">
<div class="col col-1">{if current&&x.id==current.id}<div class="playicn"></div>{/if}</div>
<div class="col col-2">{if x.program}${x.program.name}{else}${x.name}{/if}</div>
<div class="col col-3">
<div class="icns">
<i class="ico icn-del" title="删除" data-id="${x.id}" data-action="delete">删除</i>
<i class="ico ico-dl" title="下载" data-id="${x.id}" data-action="download">下载</i>
<i class="ico ico-share" title="分享" data-id="${x.id}" data-action="share">分享</i>
{if !x.program}
<i class="j-t ico ico-add" title="收藏" data-id="${x.id}" data-action="like">收藏</i>
{/if}
</div>
</div>
<div class="col col-4">
{if x.program}
<a href="/djradio?id=${x.program.radio.id}" hidefocus="true">${x.program.radio.name}</a>
{else}
${x.artists|getArtistName}
{/if}
</div>
<div class="col col-5">${(x.duration/1000)|dur2time}</div>
<div class="col col-6">
{if x.source}
<a href="${x.source.link}" class="ico ico-src" title="来自${x.source.title}" data-action="link">来源</a>
{else}
<a href="javascript:;" class="ico ico-src ico-src-dis" title="暂无来源" data-action="link">来源</a>
{/if}
</div>
</li>
{/list}
</ul>
{else}
<div class="nocnt">
<i class="ico ico-face"></i> 你还没有添加任何歌曲<br>去首页<a href="/discover/" class="f-tdu">发现音乐</a>，或在<a href="/my/" class="f-tdu">我的音乐</a>收听自己收藏的歌单。
</div>
{/if}
</textarea>
<textarea name="ntp" id="m-player-lyric" style="display:none;"><div class="listlyric j-flag">
</div>
</textarea>
<textarea name="jst" id="m-lyric-line" style="display:none;"> {if !scrollable}
<p>*该歌词不支持自动滚动* <a class="s-fc11" data-id="${id}" data-action="feedLyric" data-code="8">求滚动歌词</a></p>
{/if}
{list lines as line}
<p class="j-flag" data-time="${line.time}">${line.lyric}</p>
{/list}
</textarea>
<textarea name="jst" id="m-topbar-user-login" style="display:none;"> <div class="head f-fl f-pr">
<img src="${avatarUrl}?param=30y30">
<a href="/user/home?id=${userId}" class="mask"></a>
<i class="icn u-icn u-icn-68 f-alpha" style="display:none;"></i>
</div>
<a href="/user/home?id=${userId}" class="name f-thide f-fl f-tdn f-hide">${nickname|escape}</a>
<div class="m-tlist m-tlist-lged j-uflag" style="display:none;">
<div class="inner">
<ul class="f-cb lb mg">
<li><a hidefocus="true" class="itm-1" href="/user/home?id=${userId}"><i class="icn icn-hm"></i><em>我的主页</em><i class="icon u-icn u-icn-68 f-alpha j-uflag" style="display:none;"></i></a></li>
<li><a href="/user/level" data-action="viewLevel" class="itm-2"><i class="icn icn-lv"></i><em>我的等级</em><i class="new u-icn u-icn-78 j-uflag f-vhide"></i></a></li>
<li><a href="/member" class="itm-2"><i class="icn icn-mbr"></i><em>会员中心</em></a></li>
</ul>
<ul class="f-cb ltb mg">
<li><a hidefocus="true" class="itm-2" href="/user/update"><i class="icn icn-st"></i><em>个人设置</em></a></li>
{if reward}<li><a hidefocus="true" class="itm-2" href="/web/reward/admin" target="_blank"><i class="icn icn-reward"></i><em>赞赏管理</em></a></li>{/if}
{if topic == 6}
<li><a hidefocus="true" class="itm-2" href="/my/#/music/series"><i class="icn icn-topic"></i><em>音乐专栏入口</em></a></li>
{elseif topic == 5}
<li><a hidefocus="true" class="itm-2" href="/topic/apply"><i class="icn icn-topic"></i><em>音乐专栏入口</em></a></li>
{/if}
{if djStatus >= 10}
<li><a hidefocus="true" class="itm-2" href="/radio/my/" target="_blank"><i class="icn icn-dj"></i><em>主播入口</em></a></li>
{/if}
<li><a hidefocus="true" class="itm-2" href="/import/kugou"><i class="icn icn-imt"></i><em>导入歌单</em></a></li>
</ul>
<ul class="f-cb lt">
<li><a hidefocus="true" class="itm-3" href="#" data-action="logout"><i class="icn icn-ex"></i><em>退出</em></a></li>
</ul>
</div>
<i class="arr"></i>
</div>
</textarea>
<textarea name="txt" id="m-topbar-user-unlogin" style="display:none;"><a hidefocus="true" href="#" class="link" data-action="login">登录</a>
<div class="m-tlist j-uflag" style="display:none;">
<div class="inner">
<ul class="f-cb">
<li><a hidefocus="true" class="itm-1" href="#" data-action="login" data-type="mobile"><i class="icn icn-mb"></i><em>手机号登录</em></a></li>
<li><a hidefocus="true" class="itm-2" href="http://music.163.com/api/sns/authorize?snsType=10&clientType=web2&callbackType=Login&forcelogin=true" target="_blank" data-action="login" data-type="tencent"><i class="icn icn-wx"></i><em>微信登录</em></a></li>
<li><a hidefocus="true" class="itm-2" href="http://music.163.com/api/sns/authorize?snsType=5&clientType=web2&callbackType=Login&forcelogin=true" target="_blank" data-action="login" data-type="tencent"><i class="icn icn-qq"></i><em>QQ登录</em></a></li>
<li><a hidefocus="true" class="itm-2" href="http://music.163.com/api/sns/authorize?snsType=2&clientType=web2&callbackType=Login&forcelogin=true" target="_blank" data-action="login" data-type="sina"><i class="icn icn-sn"></i><em>新浪微博登录</em></a></li>
<li><a hidefocus="true" class="itm-2" href="#" data-action="login" data-type="netease"><i class="icn icn-wy"></i><em>网易邮箱帐号登录</em></a></li>
</ul>
</div>
<i class="arr"></i>
</div>
</textarea>
<textarea name="jst" id="m-topbar-mesg-count" style="display:none;"><i class="bub u-bub {if count>99}u-bub-2{elseif count>9}u-bub-1{/if}"><b class="f-alpha">{if count>99}99+{else}${count}{/if}</b><em></em></i>
</textarea>
<textarea name="ntp" id="m-image-preview" style="display:none;"><div class="m-timelineslide f-sltnone">
<div class="mask f-alpha" style="_background:#000;"></div>
<div class="picbody j-flag">
<div class="fail fail-loading j-flag"></div>
<div class="picwrap f-pr">
<table>
<tbody>
<tr>
<td class="f-pr">
<img class="j-flag">
<button data-action="prev" class="btn btn-left f-curleft f-pa j-flag" title=""></button>
<button data-action="next" class="btn btn-right f-curright f-alpha f-pa j-flag" title=""></button>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<a class="btn btn-dld f-alpha f-pa j-flag" download target="_blank" title="下载原图">下载</a>
<button class="btn btn-cls f-alpha f-pa" data-action="close" title="关闭"></button>
</div>
</textarea>
<textarea name="ntp" id="m-wgt-selector" style="display:none;"><div class="u-slt f-pr"><span class="curr f-thide"></span><i class="btn"></i><ul></ul></div>
</textarea>
<textarea name="jst" id="m-wgt-selector-list" style="display:none;">{list data as x}<li class="f-thide"><a href="#" data-value="${x.v}" title="${x.t}">${x.t}</a></li>{/list}
</textarea>
<textarea name="ntp" id="m-wgt-create" style="display:none;"><div class="lyct m-crgd f-cb f-tc">
<p>歌单名：<input type="text" class="u-txt j-flag"></p>
<div class="u-err f-vhide j-flag"><i class="u-icn u-icn-25"></i>错误提示</div>
<p class="tip s-fc4">可通过“收藏”将音乐添加到新歌单中</p>
<div class="btn">
<a href="javascript:;" class="u-btn2 u-btn2-2 u-btn2-w2 j-flag" hidefocus="true"><i>新 建</i></a>
<a href="javascript:;" class="u-btn2 u-btn2-1 u-btn2-w2 j-flag" hidefocus="true"><i>取 消</i></a>
</div>
</div>
</textarea>
<textarea name="ntp" id="m-wgt-comment" style="display:none;"><div class="u-title u-title-1">
<h3><span class="f-ff2">评论</span></h3><span class="sub s-fc3">共<span class="j-flag">0</span>条评论</span>
</div>
<div class="m-cmmt">
<div class="iptarea">
<div class="head"><img src="http://s4.music.126.net/style/web2/img/default/default_avatar.jpg?param=50y50"></div>
<div class="j-flag"></div>
</div>
<div class="cmmts j-flag"></div>
<div class="j-flag"></div>
</div>
</textarea>
<textarea name="ntp" id="m-wgt-comment2" style="display:none;"><div class="m-dynamic">
<div class="dbox dbox-cmt">
<span class="darr"><i class="bd">◆</i><i class="bg">◆</i></span>
<div class="m-cmmt m-cmmt-s">
<div class="iptarea j-flag">
</div>
<div class="cmmts">
<div class="j-flag"></div>
<div class="dmore dmore-cmt f-cb">
<div class="dhas s-fc3">后面还有<span class="j-flag">0</span>条评论，<a data-type="viewmore" class="s-fc3 f-ff1" href="javascript:void(0)">查看更多&gt;</a></div>
<a data-type="cc" class="dtoggle" href="javascript:void(0)">收起<i data-type="cc" class="u-icn u-icn-61"></i></a>
</div>
</div>
</div>
</div>
</div>
</textarea>
<textarea name="ntp" id="m-wgt-comment3" style="display:none;"><div class="dcmt">
<p><span class="f-fw1">评论</span> (<span class="j-flag"></span>)</p>
<div class="m-cmmt m-cmmt-s">
<div class="iptarea j-flag">
</div>
<div class="cmmts j-flag">
</div>
<div class="j-flag">
</div>
</div>
</div>
</textarea>
<textarea name="jst" id="m-wgt-comment-item" style="display:none;"> {list beg..end as y}
{var x=xlist[y]}
{if !!x}
<div id="${x.commentId|seed}" class="itm" data-id="${x.commentId}">
<div class="head">
<a href="/user/home?id=${x.user.userId}"><img src="${x.user.avatarUrl}?param=50y50"></a>
</div>
<div class="cntwrap">
<div class="">
<div class="cnt f-brk">
<a href="/user/home?id=${x.user.userId}" class="s-fc7">${escape(x.user.nickname)}</a>
${getAuthIcon(x.user)}
{if !!x.beRepliedUser}
&nbsp;回复&nbsp;<a href="/user/home?id=${x.beRepliedUser.userId}" class="s-fc7">${escape(x.beRepliedUser.nickname)}</a>
{if x.beRepliedUser.userType==4}<sup class="icn u-icn2 u-icn2-music2"></sup>
{elseif x.beRepliedUser.authStatus==1}<sup class="u-icn u-icn-1"></sup>
{elseif x.beRepliedUser.expertTags && x.beRepliedUser.expertTags.length>0}<sup class="u-icn u-icn-84"></sup>{/if}
{/if}
：${getRichText(escape(x.content),'s-fc7')}
</div>
</div>
{if x.beReplied&&x.beReplied.length}
{var replied = x.beReplied[0]}
<div class="que f-brk f-pr s-fc3">
<span class="darr"><i class="bd">◆</i><i class="bg">◆</i></span>
{if replied&&replied.content&&replied.status!=-5}
<a class="s-fc7" href="/user/home?id=${replied.user.userId}">${replied.user.nickname}${getAuthIcon(replied.user)}</a>：${getRichText(escape(replied.content),'s-fc7')}
{else}
该评论已删除
{/if}
</div>
{/if}
<div class="rp">
<div class="time s-fc4">${timeformat(x.time)}</div>
{if x.topCommentId}<span class="top">音乐人置顶</span>{/if}
{if canTop()&&GUser&&GUser.userId&&(GUser.userId==x.user.userId)}
<span class="dlt">{if x.topCommentId}<a href="javascript:void(0)" class="s-fc3" data-id="${x.commentId}" data-tid="${x.topCommentId}" data-type="canceltop">解除置顶</a>{else}<a href="javascript:void(0)" class="s-fc3" data-id="${x.commentId}" data-type="gotop">置顶评论</a>{/if}<span class="sep">|</span></span>
{/if}
{if GUser&&GUser.userId&&(GUser.userId==x.user.userId||GUser.userId==resUserId)}
<span class="dlt"><a href="javascript:void(0)" class="s-fc3" data-id="${x.commentId}" {if x.topCommentId}data-tid="${x.topCommentId}" {/if}data-type="delete">删除</a><span class="sep">|</span></span>
{/if}
{if GAllowRejectComment}
{if hot||!x.isRemoveHotComment}
<span class="dlt"><a href="javascript:void(0)" class="s-fc3" data-id="${x.commentId}" data-type="reject">移除精彩评论</a><span class="sep">|</span></span>
{else}
<span class="s-fc3">已移除精彩评论</span><span class="sep">|</span>
{/if}
{/if}
{if !x.topCommentId}<a data-id="${x.commentId}" data-type="{if !x.liked}like{else}unlike{/if}" href="javascript:void(0)"><i class="zan u-icn2 u-icn2-{if x.liked}13{else}12{/if}"></i>{if x.likedCount} (${getPlayCount(x.likedCount)}){/if}</a>
<span class="sep">|</span>{/if}
<a href="javascript:void(0)" class="s-fc3" data-id="${x.commentId}" data-type="reply">回复</a>
</div>
</div>
</div>
{/if}
{/list}
</textarea>
<textarea name="jst" id="m-wgt-comment-item-2" style="display:none;"> {list beg..end as y}
{var x=xlist[y]}
<div class="itm" data-id="${x.commentId}">
<div class="head">
<a href="/user/home?id=${x.user.userId}"><img src="${x.user.avatarUrl}?param=50y50"></a>
</div>
<div class="cntwrap">
<div class="f-brk">
<a href="/user/home?id=${x.user.userId}" class="s-fc7">${escape(x.user.nickname)}</a>
{if x.user.userType==4}<sup class="icn u-icn2 u-icn2-music2"></sup>
{elseif x.user.authStatus==1}<sup class="u-icn u-icn-1"></sup>
{elseif x.user.expertTags && x.user.expertTags.length>0}<sup class="u-icn u-icn-84"></sup>{/if}
{if !!x.beRepliedUser}
&nbsp;回复&nbsp;<a href="/user/home?id=${x.beRepliedUser.userId}" class="s-fc7">${escape(x.beRepliedUser.nickname)}</a>
{if x.beRepliedUser.userType==4}<sup class="icn u-icn2 u-icn2-music2"></sup>
{elseif x.beRepliedUser.authStatus==1}<sup class="u-icn u-icn-1"></sup>
{elseif x.beRepliedUser.expertTags && x.beRepliedUser.expertTags.length>0}<sup class="u-icn u-icn-84"></sup>{/if}
{/if}
：${getRichText(escape(x.content),'s-fc7')}
</div>
{if x.beReplied&&x.beReplied.length}
{var replied = x.beReplied[0]}
<div class="que f-brk f-pr s-fc3">
<span class="darr"><i class="bd">◆</i><i class="bg">◆</i></span>
{if replied&&replied.content}
<a class="s-fc7" href="/user/home?id=${replied.user.userId}">${replied.user.nickname}${getAuthIcon(replied.user)}</a>：${getRichText(escape(replied.content),'s-fc7')}
{else}
该评论已删除
{/if}
</div>
{/if}
<div class="rp">
<div class="time s-fc4">${timeformat(x.time)}</div>
{if GUser&&GUser.userId&&(GUser.userId==x.user.userId||GUser.userId==resUserId)}
<span class="dlt">
<a href="javascript:void(0)" class="s-fc3" data-id="${x.commentId}" data-type="delete">删除</a><span class="sep">|</span>
</span>
{/if}
<a data-id="${x.commentId}" data-type="{if !x.liked}like{else}unlike{/if}" href="javascript:void(0)"><i class="zan u-icn2 u-icn2-{if x.liked}13{else}12{/if}"></i>{if x.likedCount} (${getPlayCount(x.likedCount)}){/if}</a>
<span class="sep">|</span>
<a href="javascript:void(0)" class="s-fc3" data-id="${x.commentId}" data-type="reply">回复</a>
</div>
</div>
</div>
{/list}
</textarea>
<textarea name="jst" id="m-wgt-input-1" style="display:none;"> <div class="m-cmmtipt f-cb f-pr">
<div class="u-txtwrap holder-parent f-pr">
<textarea class="u-txt area j-flag" placeholder="${placeholder}"><&#47;textarea>
</div>
<div class="btns f-cb f-pr">
<i class="icn u-icn u-icn-36 j-flag"></i><i class="icn u-icn u-icn-41 j-flag"></i>
<a href="javascript:void(0)" class="btn u-btn u-btn-1 j-flag">评论</a>
<span class="zs s-fc4 j-flag">110/120</span>
</div>
<div class="corr u-arr"><em class="arrline">◆</em><span class="arrclr">◆</span></div>
</div>
</textarea>
<textarea name="jst" id="m-wgt-input-2" style="display:none;"> <div class="rept m-quk m-quk-1 f-pr">
<div class="iner">
<div class="corr u-arr u-arr-1"><em class="arrline">◆</em><span class="arrclr">◆</span></div>
<div class="m-cmmtipt m-cmmtipt-1 f-cb f-pr">
<div class="u-txtwrap holder-parent f-pr j-wrap">
<textarea class="u-txt area j-flag" placeholder="${placeholder}"><&#47;textarea>
</div>
<div class="btns f-cb f-pr">
<i class="icn u-icn u-icn-36 j-flag"></i><i class="icn u-icn u-icn-41 j-flag"></i>
<a href="javascript:void(0)" class="btn u-btn u-btn-1 j-flag">回复</a>
<span class="zs s-fc4 j-flag">110/120</span>
</div>
</div>
</div>
</div>
</textarea>
<textarea name="jst" id="m-wgt-input-3" style="display:none;"> <div class="m-cmmtipt f-cb f-pr">
<div class="u-txtwrap holder-parent f-pr">
<textarea class="u-txt area j-flag" placeholder="${placeholder}"><&#47;textarea>
</div>
<div class="btns f-cb f-pr">
<i class="icn u-icn u-icn-36 j-flag"></i><i class="icn u-icn u-icn-41 j-flag"></i>
<a class="btn u-btn u-btn-1 j-flag" href="javascript:void(0)">回复</a>
<span class="zs s-fc4 j-flag">110/120</span>
</div>
</div>
</textarea>
<textarea name="jst" id="m-wgt-input-4" style="display:none;"> <div class="m-cmmtipt f-cb f-pr">
<div class="u-txtwrap f-pr">
<textarea class="u-txt area j-flag"><&#47;textarea>
</div>
<div class="btns f-cb f-pr">
<i class="icn u-icn u-icn-36 j-flag"></i><i class="icn u-icn u-icn-41 j-flag" style="display:none;"></i>
<a class="f-fr u-btn u-btn-1 j-flag" href="javascript:void(0)">发送</a><span class="zs s-fc4 j-flag">110/120</span>
</div>
</div>
</textarea>
<textarea name="jst" id="m-wgt-input-5" style="display:none;"> <div class="m-cmmtipt f-cb f-pr">
<div class="u-txtwrap holder-parent f-pr">
<textarea class="u-txt area j-flag" placeholder="${placeholder}"><&#47;textarea>
</div>
<div class="btns f-cb f-pr">
<i class="icn u-icn u-icn-36 j-flag"></i><i class="icn u-icn u-icn-41 j-flag"></i>
<a class="btn u-btn u-btn-1 j-flag" href="javascript:void(0)">评论</a>
<span class="zs s-fc4 j-flag">110/120</span>
</div>
</div>
</textarea>
<textarea name="ntp" id="m-wgt-subscribe" style="display:none;"><div class="lyct lyct-1 m-favgd f-cb">
<div class="tit j-flag"><i class="u-icn u-icn-33"></i>新歌单</div>
<div class="j-flag">
<div class="u-load s-fc4"><i class="icn"></i> 加载中...</div>
</div>
</div>
</textarea>
<textarea name="jst" id="m-wgt-subscribe-item" style="display:none;"><ul>
{list beg..end as y}
{var x=xlist[y]}
<li data-id="${x.id}" class="xtag {if x.trackCount+size>1000}dis{/if}">
<div class="item f-cb">
<div class="left">
<a href="javascript:void(0)" class="avatar" target="_blank">
<img alt="" src="${x.coverImgUrl}?param=40y40">
{if x.highQuality}<i class="u-jp u-icn2 u-icn2-jp5"></i>{/if}
</a>
</div>
<p class="name f-thide"><a class="s-fc0" href="javascript:void(0)" target="_blank">${escape(cutStr(x.name,40))}</a></p>
<p class="s-fc3">${x.trackCount}首</p>
</div>
</li>
{/list}
</ul>
</textarea>
<textarea name="ntp" id="m-wgt-forward" style="display:none;"><div class="lyct lyct-1 f-cb">
<div class="m-lyshare">
<div class="u-txtwrap f-pr">
<label style="display: block;" class="j-flag">说点什么</label>
<textarea class="u-txt area j-flag" text = ><&#47;textarea>
</div>
<div class="oper f-cb j-flag">
<div class="face f-fl f-pr">
<i class="u-icn u-icn-36 f-fl j-flag"></i>
<i class="u-icn u-icn-41 j-flag"></i>
</div>
<span class="zs f-fr s-fc3 j-flag">140</span>
</div>
<div class="btnwrap">
<a class="u-btn2 u-btn2-2 u-btn2-w2 j-flag" hidefocus="true" href="#"><i>转发</i></a>
<a class="u-btn2 u-btn2-1 u-btn2-w2 j-flag" hidefocus="true" href="#"><i>取消</i></a>
</div>
<div class="j-flag u-err"><i class="u-icn u-icn-25"></i><span></span></div>
</div>
</div>
</textarea>
<textarea name="ntp" id="m-import-ok" style="display:none;"><div class="lyct f-cb f-tc">
<p class="f-fs3 f-ff2"><i class="u-icn u-icn-76"></i>&nbsp;&nbsp;歌曲同步完成</p>
<div class="lybtn">
<a href="javascript:;" class="u-btn2 u-btn2-2 j-flag" hidefocus="true"><i>查看我的音乐</i></a>
</div>
</div>
</textarea>
<textarea name="jst" id="m-wgt-atlist" style="display:none;"> <div class="u-atlist">
{if suggests.length == 0}
<p>轻敲空格完成输入</p>
{else}
<p>选择最近@的人或直接输入</p>
{/if}
<div class="lst">
{list suggests as suggest}
<a href="javascript:;" data-index=${suggest_index} class="f-thide j-sgt">${suggest.nickname}</a>
{/list}
</div>
</div>
</textarea>
<textarea name="jst" id="m-wgt-receiverInput" style="display:none;"> <div class="ct f-pr">
<div class="u-txtwrap f-pr">
<div class="u-txt txtwrap j-flag">
{if receiver}
<div class="blk s-fc3 j-receiver">${receiver.nickname}<a href="#" class="cls" title="删除">&times;</a></div>
{/if}
<span class="holder-parent j-flag" style="float:left">
<input type="text" class="txt j-flag" />
<label class="holder j-flag">选择或输入好友昵称</label>
</span>
</div>
</div>
<ul class="full j-flag" style="_height:182px;display:none">
{list users as user}
<li class="j-item" data-userId=${user.userId} data-username=${user.nickname} data-index=${user_index}><a href="#"><img src=${user.avatarUrl}>${user.nickname}</a></li>
{/list}
</ul>
<div class="j-flag" style="position:absolute;left: -1000px;width:auto;"></div>
</div>
</textarea>
<textarea name="jst" id="m-wgt-receiverList" style="display:none;"> {list users as user}
<li class="j-item" data-userId=${user.userId} data-username=${user.nickname} data-index=${user_index}><a href="#"><img src=${user.avatarUrl}>${user.nickname}</a></li>
{/list}
</textarea>
<textarea name="ntp" id="m-wgt-sharewin" style="display:none;"><div class="lyct lyct-1 f-cb">
<div class="m-lyshare">
<ul class="m-tabs1 j-flag">
<li><a href="#"><em>分享给大家</em></a></li>
<li><a href="#"><em>私信分享</em></a></li>
</ul>
<div class="u-err j-flag" style="display:none">最多选择10位好友</div>
<div class="j-flag"></div>
<div class="j-slogan"></div>
<div class="u-txtwrap f-pr">
<textarea class="u-txt area j-flag" placeholder="说点什么吧" data-action="txt"><&#47;textarea>
<div class="info f-fs1 f-pr j-flag" data-action="search"></div>
</div>
<div class="oper f-cb">
<div class="face f-fl f-pr">
<i class="u-icn u-icn-36 f-fl j-flag" data-action="emot"></i>
<i class="u-icn u-icn-41 f-fl j-flag" data-action="at"></i>
<i class="u-icn u-icn-97 j-flag f-pr" data-action="upload" data-default></i>
</div>
<span class="f-fr s-fc4 j-flag">140/140</span>
</div>
<div class="f-cb j-flag"></div>
<div class="f-cb">
<div class="btnwrap f-fl">
<a class="u-btn2 u-btn2-2 u-btn2-w2 j-flag" hidefocus="true" href="#" data-action="share"><i>分享</i></a>
<a class="u-btn2 u-btn2-1 u-btn2-w2 j-flag" hidefocus="true" href="#" data-action="close"><i>取消</i></a>
</div>
<div class="f-cb j-flag f-fr">
<div class="share f-fr">
<span class="f-fl s-fc3">同时分享到：</span>
<ul class="u-logo u-logo-s f-cb">
<li><a class="u-slg u-slg-sn j-t" data-action="sns" data-type="2" hidefocus="true" href="//music.163.com/api/sns/authorize?snsType=2&clientType=web2&callbackType=Binding&forcelogin=true" title="新浪微博"></a></li>
<li><a class="u-slg u-slg-db j-t" data-action="sns" data-type="3" hidefocus="true" href="//music.163.com/api/sns/authorize?snsType=3&clientType=web2&callbackType=Binding&forcelogin=true" title="豆瓣网"></a></li>
</ul>
</div>
</div>
</div>
<div class="u-err j-flag"><i class="u-icn u-icn-25"></i><span></span></div>
</div>
</div>
</textarea>
<textarea name="jst" id="m-search-suggest" style="display:none;">{macro listArtists(artists)}
{list artists as art}
${art.name|mark}&nbsp;
{/list}
{/macro}
<div class="m-schlist">
<p class="note s-fc3"><a class="s-fc3 xtag" href="/search/#/?s=${keyword}&type=1002">搜“${keyword|cutStr}” 相关用户</a> &gt;</p>
<div class="rap">
{list result.order as index}
{var lst=result[index]}
{if !!lst&&!!lst.length}
<div class="itm f-cb">
{if index=="songs"}
<h3 class="hd"><i class="icn u-icn u-icn-26"></i><em class="f-fl">单曲</em></h3>
<ul class="{if index_index%2!=0}odd{/if} f-cb">
{list lst as song}
<li><a class="s-fc0 f-thide xtag" href="/song?id=${song.id}">${song.name|mark}-${listArtists(song.artists)}</a></li>
{/list}
</ul>
{elseif index=="artists"}
<h3 class="hd"><i class="icn u-icn u-icn-27"></i><em class="f-fl">歌手</em></h3>
<ul class="{if index_index%2!=0}odd{/if} f-cb">
{list lst as artist}
<li><a class="s-fc0 f-thide xtag" href="/artist?id=${artist.id}">${artist.name|mark}</a></li>
{/list}
</ul>
{elseif index=="albums"}
<h3 class="hd"><i class="icn u-icn u-icn-28"></i><em class="f-fl">专辑</em></h3>
<ul class="{if index_index%2!=0}odd{/if} f-cb">
{list lst as album}
<li><a class="s-fc0 f-thide xtag" href="/album?id=${album.id}">${album.name|mark}{if album.artist}-${album.artist.name|mark}{/if}</a></li>
{/list}
</ul>
{elseif index=="playlists"}
<h3 class="hd"><i class="icn u-icn u-icn-29"></i><em class="f-fl">歌单</em></h3>
<ul class="{if index_index%2!=0}odd{/if} f-cb">
{list lst as playlist}
<li><a class="s-fc0 f-thide xtag" href="/playlist?id=${playlist.id}">${playlist.name|escape|mark}</a></li>
{/list}
</ul>
{elseif index=="mvs"}
<h3 class="hd"><i class="icn u-icn u-icn-96"></i><em class="f-fl">MV</em></h3>
<ul class="{if index_index%2!=0}odd{/if} f-cb">
{list lst as mv}
<li><a class="s-fc0 f-thide xtag" href="/mv?id=${mv.id}">${mv.name|escape|mark}{if mv.artistName}-${mv.artistName|escape|mark}{/if}</a></li>
{/list}
</ul>
{/if}
</div>
{/if}
{/list}
</div>
</div>
</textarea>
<textarea name="jst" id="m-xwgt-share-infobar" style="display:none;"><i class="highlight"></i><div class="text f-fl f-fs1"><p class="f-thide">${info|escape}</p></div>
{if canChange}<i class="f-fr icn u-icn2 u-icn2-arr"></i>{/if}
</textarea>
<textarea name="jst" id="m-xwgt-share-videobar" style="display:none;"><div class="text">
<img src="${cover}?imageView&thumbnail=0x40" class="cvr f-fl">
<h3 class="f-thide f-fs1">${name}</h3>
<p class="f-thide s-fc3">${size}</p>
</div>
<i class="f-fr icn u-icn2 u-icn2-arr"></i>
</textarea>
<textarea name="ntp" id="m-xwgt-share-upload" style="display:none;"> <div class="f-pr choose f-cb">
<ul class="pics f-pr f-cb j-flag"><li class="f-pr add j-flag u-icn2 u-icn2-addimg" title="添加新图片"></li></ul>
<div class="f-pa tip s-fc6 j-flag"></div>
</div>
</textarea>
<textarea name="jst" id="m-xwgt-share-upload-preview" style="display:none;"> <li class="pic f-pr{if fail} z-fail{/if}">
{if !fail}
<i class="f-img icn"></i>
{else}
<div class="mask f-blk f-pa"></div><div class="f-blk f-pa error">${fail}</div>
{/if}
<span class="del f-pa u-icn2 u-icn2-delimg" title="删除"></span>
</li>
</textarea>
<textarea name="jst" id="m-xwgt-share-upload-preview-img" style="display:none;">{if !fail}
<img class="f-img" src="${url}?param=80y80" draggable=false>
{else}
<div class="mask f-blk f-pa"></div><div class="f-blk f-pa error">${fail}</div>
{/if}
</textarea>
<textarea name="ntp" id="ntp-alert" style="display:none;"><div class="lyct f-cb f-tc">
<p class="f-fs1">
<i class="u-icn u-icn-89 j-flag"></i>
<span class="f-fw1">&nbsp;&nbsp;&nbsp;<span class="j-flag"></span></span>
</p>
<p class="mesg j-flag">&nbsp;</p>
<div class="lybtn">
<a href="javascript:;" class="u-btn2 u-btn2-2 u-btn2-w2 j-flag" hidefocus="true"><i>知道了</i></a>
</div>
</div>
</textarea>
<textarea name="ntp" id="m-layer-commwin" style="display:none;"><div class="lyct f-tc">
<p class="j-t"><i class="u-icn u-icn-90"></i></p>
<p class="j-t msg1"></p>
</div>
<div class="j-t lsbtn f-tc">
<a href="javascript:;" class="u-btn2 u-btn2-2 u-btn2-w2" hidefocus="true"><i>上传节目</i></a>
</div>
</textarea>
<textarea name="jst" id="m-layer-commwin-btn" style="display:none;">{list buttons as item}
<a hidefocus="true" class="u-btn2 ${item.klass} {if item.style}${item.style}{else}u-btn2-w2{/if}" href="#" {if !!item.action}data-action="${item.action}"{/if}><i>${item.text}</i></a>
{/list}
</textarea>
<textarea name="ntp" id="m-layer-outershare" style="display:none;"><div class="lyct lyct-1">
<ul class="n-outshr f-cb">
<li>
<a href="#" data-action="wxfrd" class="logo wxfrd"></a>
<a href="#" data-action="wxfrd" class="wd">微信</a>
</li>
<!--
<li>
<a href="#" data-action="wxevt" class="logo wxevt"></a>
<a href="#" data-action="wxevt" class="wd">微信朋友圈</a>
</li>
-->
<li>
<a href="#" data-action="yxfrd" class="logo yxfrd"></a>
<a href="#" data-action="yxfrd" class="wd">易信</a>
</li>
<!--
<li>
<a href="#" data-action="yxevt" class="logo yxevt"></a>
<a href="#" data-action="yxevt" class="wd">易信朋友圈</a>
</li>
-->
<li>
<a href="#" data-action="qzone" class="logo qzone"></a>
<a href="#" data-action="qzone" class="wd">QQ空间</a>
</li>
<li>
<a href="#" data-action="lofte" class="logo lofte"></a>
<a href="#" data-action="lofte" class="wd">LOFTER</a>
</li>
</ul>
</div>
</textarea>
<textarea name="ntp" id="m-layer-tip" style="display:none;"><div class="lyct f-cb f-tc">
<div class="f-fs1 j-flag">message</div>
<div class="lybtn">
<a hidefocus="true" class="u-btn2 u-btn2-2 u-btn2-w2 j-flag" href="javascript:;"><i>知道了</i></a>
</div>
</div>
</textarea>
<textarea name="ntp" id="m-outshare-layer" style="display:none;"><div class="lyct lyct-1 f-cb">
<ul class="m-shareto f-cb j-flag">
<li class="fst" data-action="sn" data-type="2">
<a href="#" class="logo logo-sn"></a>
<a href="#" class="wd s-fc3">新浪微博</a>
</li>
<li data-action="tx" data-type="6" style="display:none;">
<a href="#" class="logo logo-tc"></a>
<a href="#" class="wd s-fc3">腾讯微博</a>
</li>
<li data-action="db" data-type="3">
<a href="#" class="logo logo-db"></a>
<a href="#" class="wd s-fc3">豆瓣</a>
</li>
</ul>
</div>
</div>
</textarea>
<textarea name="ntp" id="m-sharesingle-layer" style="display:none;"><div class="lyct lyct-1 f-cb">
<div class="m-lyshare">
<div class="u-txtwrap f-pr">
<textarea data-action="txt" class="u-txt area j-flag"><&#47;textarea>
</div>
<div class="oper f-cb">
<div class="face f-fl f-pr j-flag">
<i data-action="emt" class="u-icn u-icn-36 f-fl"></i>
</div>
<span class="zs f-fr s-fc3 j-flag">140</span>
</div>
<div class="btnwrap">
<a data-action="ok" class="u-btn2 u-btn2-2 u-btn2-w2 j-flag" hidefocus="true" href="#"><i>分享</i></a>
<a data-action="cc" class="u-btn2 u-btn2-1 u-btn2-w2" hidefocus="true" href="#"><i>取消</i></a>
</div>
<div class="u-err f-hide j-flag"><i class="u-icn u-icn-25"></i></div>
</div>
</div>
</textarea>
<textarea name="jst" id="m-popup-info" style="display:none;"><div class="lyct f-tc">
<div class="f-cb m-tipinfo">
<i class="u-icn2 u-icn2-11 f-fl"></i>
<div class="f-fr f-pr f-fs1 tip">${tip}</div>
</div>
</div>
<div class="lsbtn f-tc">
<a data-action="ok" href="javascript:void(0)" class="u-btn2 u-btn2-2 u-btn2-2-h {if oktext.length<=2}u-btn2-w2{/if}" hidefocus="true"><i>${oktext}</i></a>
<a data-action="cc" href="javascript:void(0)" hidefocus="true" class="u-btn2 u-btn2-1 u-btn2-1-h {if cctext.length<=2}u-btn2-w2{/if}"><i>${cctext}</i></a>
</div>
</textarea>
<textarea name="jst" id="m-popup-song-buy" style="display:none;"><div class="lyct m-songpay f-tc">
<div class="f-cb m-tipinfo">
<i class="u-icn2 u-icn2-11 f-fl"></i>
<div class="f-fr f-pr f-fs1 tip">${tip}</div>
</div>
<div class="f-pr f-tc">
<a data-action="ok" href="javascript:void(0)" class="u-btn2 u-btn2-2 {if oktext.length<=2}u-btn2-w2{/if}" hidefocus="true"><i>${oktext}</i></a>
{if showSongText}<a data-action="song" class="song s-fc4" href="javascript:void(0)">${songTxt}</a>{/if}
</div>
</div>
</textarea>
<textarea name="jst" id="m-popup-alert" style="display:none;"><div class="lyct f-tc">
<p><i class="${icon}"></i></p>
<p class="msg1"><span class="f-fs1 s-fc1">${tip}</span></p>
</div>
<div class="lsbtn f-tc">
{if typeof(oktext) != 'undefined'}<a data-action="ok" href="javascript:void(0)" class="u-btn2 u-btn2-2 u-btn2-2-h {if oktext.length<=2}u-btn2-w2{/if}" hidefocus="true"><i>${oktext}</i></a>{/if}
{if typeof(cctext) != 'undefined'}<a data-action="cc" href="javascript:void(0)" class="u-btn2 u-btn2-1 u-btn2-1-h {if cctext.length<=2}u-btn2-w2{/if}" hidefocus="true"><i>${cctext}</i></a>{/if}
</div>
</textarea>
<textarea name="txt" id="m-donate-tip" style="display:none;"><p>该资源为公益歌曲<p>
<p>捐赠任意金额（2~4999元）即可无限畅听下载</p>
</textarea>
<textarea name="ntp" id="m-simple-share-layer" style="display:none;"> <div class="lyct lyct-1">
<ul class="n-outshr f-cb">
<li data-type="xlwb">
<a href="javascript:;" class="logo xlwb"></a>
<a href="javascript:;" class="wd">新浪微博</a>
</li>
<li data-type="wx">
<a href="javascript:;" class="logo wxfrd"></a>
<a href="javascript:;" class="wd">微信</a>
</li>
<li data-type="yx">
<a href="javascript:;" class="logo yxfrd"></a>
<a href="javascript:;" class="wd">易信好友</a>
</li>
<li data-type="qzone">
<a href="javascript:;" class="logo qzone"></a>
<a href="javascript:;" class="wd">QQ空间</a>
</li>
<li data-type="lofter" style="display:none;">
<a href="javascript:;" class="logo lofte"></a>
<a href="javascript:;" class="wd">LOFTER</a>
</li>
<li data-type="db" style="display:none;">
<a href="javascript:;" class="logo db"></a>
<a href="javascript:;" class="wd">豆瓣</a>
</li>
</ul>
</div>
</textarea>
<textarea name="txt" id="m-report-point" style="display:none;"><div class="zcnt">
<div class="lyct f-cb f-tc">
<p class="f-fs2">悬赏1积分让大家来帮你补歌词，是否继续？</p>
<p style="padding-top: 10px;">若30天内歌词未补充，积分将退还给您</p>
<div class="lybtn">
<a href="javascript:;" data-action="ok" class="u-btn2 u-btn2-2 u-btn2-w2" hidefocus="true"><i>继续求</i></a>
<a href="javascript:;" data-action="cc" class="u-btn2 u-btn2-1 u-btn2-w2" hidefocus="true"><i>取消</i></a>
</div>
</div>
</div>
</textarea>
<textarea name="txt" id="txt-mobilestatus" style="display:none;"><div class="box f-cb">
<div data-action="invalid" class="item z-first f-fl">
<div class="icon"></div>
<p>原手机号已停用</p>
<p class="s-fc3">(使用其他方式验证)</p>
</div>
<div data-action="valid" class="item f-fr">
<div class="icon"></div>
<p>原手机号仍能使用</p>
<p class="s-fc3">(使用手机验证码验证)</p>
</div>
</div>
</textarea>
<textarea name="ntp" id="m-question" style="display:none;"><div class="m-question">
<div>请填写以下安全问题的答案</div>
<div class="qa j-flag f-cb">
<label class="f-fl">问题：</label>
</div>
<div class="qa f-cb">
<label class="f-fl">回答：</label>
<input type="text" class="u-txt txt f-fl j-flag">
</div>
<div class="u-err f-hide j-flag"><i class="u-icn u-icn-25"></i>帐号或密码错误</div>
<div class="btnwrap">
<a data-action="back" class="u-btn2 u-btn2-1 u-btn2-w2" hidefocus="true" href="javascript:void(0)"><i>上一步</i></a>
<a data-action="next" class="u-btn2 u-btn2-2 u-btn2-w2" hidefocus="true" href="javascript:void(0)"><i>下一步</i></a>
</div>
</div>
</textarea>
<textarea name="ntp" id="g-select" style="display:none;"><div class="u-slt f-ib">
<span class="curr f-thide">－请选择－</span>
<i class="btn"></i>
<ul class="f-hide">
</ul>
</div>
</textarea>
<textarea name="ntp" id="ntp-linuxlinks" style="display:none;"><div class="lyct lyct-1">
<div class="dc f-cb">
<ul class="links">
<li class="link f-cb">
<a href="" class="left" target="_blank" hidefocus="true" title="Linux版下载">deepin15（32位）</a>
<a href="" class="right" target="_blank" hidefocus="true" title="Linux版下载">deepin15（64位）</a>
</li>
<li class="link f-cb">
<a href="" class="left" target="_blank" hidefocus="true" title="Linux版下载">ubuntu16.04（32位）</a>
<a href="" class="right" target="_blank" hidefocus="true" title="Linux版下载">ubuntu16.04（64位）</a>
</li>
<li class="link f-cb">
<a href="" class="left" target="_blank" hidefocus="true" title="Linux版下载">ubuntu14.04（32位）</a>
<a href="" class="right" target="_blank" hidefocus="true" title="Linux版下载">ubuntu14.04（64位）</a>
</li>
</ul>
</div>
</div>
</textarea>
<textarea name="ntp" id="ntp-pcRedirect" style="display:none;"><div class="lyct lyct-1">
<div class="pcdld f-cb">
<img src="../../../style/web2/img/down/uwpWindown.png" alt="网易云音乐-UWP版">
<p class="txt">您的系统为Windows 10，推荐下载UWP版</p>
<div class="choose">
<a class="u-btn2 u-btn2-2" data-res-action="bilog" data-log-action="downloadapp" data-log-json='{"type":"pc","source":"downloadapp"}' href="https://www.microsoft.com/store/apps/9nblggh6g0jf" onclick="g_stat('uwp',true,event);_gaq.push(['_trackEvent','download','uwp','download']);" hidefocus="true" title="UWP版下载" target="_blank"><i>下载UWP版本</i></a>
<a class="link" data-res-action="bilog" data-log-action="downloadapp" data-log-json='{"type":"pc","source":"downloadapp"}' href="http://music.163.com/api/pc/download/latest" onclick="g_stat('pc',true,event);_gaq.push(['_trackEvent','download','pc','download']);" hidefocus="true" title="PC版下载" target="_blank"><i>继续下载PC版本</i></a>
</div>
</div>
</div>
</textarea>
<textarea name="jst" id="g-select-item" style="display:none;">{list options as o}
<li class="f-thide" data-index="${o_index}"><a href="javascript:;">${o|filter}</a></li>
{/list}
</textarea>
<textarea name="ntp" id="m-download-layer" style="display:none;"><h3 class="f-tc">使用云音乐客户端</h3>
<h4 class="f-tc s-fc3">即可无限下载高品质音乐</h4>
<div class="f-cb wrap">
<div class="left">
<div data-action="download" data-src="http://music.163.com/api/osx/download/latest" class="btn btn-mac"><i></i>Mac版<span class="ver j-flag">V1.9.1</span></div>
<div data-action="download" data-src="http://music.163.com/api/pc/download/latest" class="btn f-hide"><i></i>PC版<span class="ver j-flag">V1.9.1</span></div>
<div data-action="orpheus" class="btn btn-installed j-flag">已安装PC版</div>
</div>
<div class="right">
<div class="qtcode"></div>
<div class="s-fc3 f-tc">扫描下载手机版</div>
</div>
</div>
</textarea>
<textarea name="jst" id="com-artists-title" style="display:none;">{var title=""}
{if artists && artists.length}
{list artists as x}
{if x}
{var title = title + x.name}
{if x_index < x_length - 1}
{var title = title + " / "}
{/if}
{/if}
{/list}
{/if}
${escape(title)}
</textarea>
<textarea name="jst" id="com-mv-artists" style="display:none;">{if artists && artists.length}
<span class="${boxClazz}" title="${comJST('com-artists-title', artists)}">
{list artists as x}
{if !!x}
{if !!x.id}
<a href="/artist?id=${x.id}" class="${clazz}">${mark(escape(x.name))}</a>
{else}
<span class="${clazz}">${mark(escape(x.name))}</span>
{/if}
{if x_index < x_length - 1}&nbsp;/&nbsp;{/if}
{/if}
{/list}
</span>
{/if}
</textarea>
<textarea name="jst" id="com-album-artists" style="display:none;">${comJST('com-mv-artists', artists, clazz, mark, boxClazz)}
</textarea>
<textarea name="ntp" id="ntp-portrait" style="display:none;"><div class="m-emts z-show">
<div class="j-flag emtwrap f-cb"></div>
<div class="page">
<a href="#" hidefocus="true" class="j-flag u-btn u-btn-prv"></a><em class="j-flag s-fc3">1/2</em><a href="#" hidefocus="true" class="j-flag u-btn u-btn-nxt"></a>
</div>
</div>
</textarea>
<textarea name="jst" id="jst-portrait" style="display:none;">{list plist as item}
<span title="${item.key}" class="emtitm"><img data-text="${item.key}" data-url="${item.key|purl}" class="f-alpha" src="${item.key|purl}"></span>
{/list}
</textarea>
<textarea name="ntp" id="m-wgt-song-box" style="display:none;"><div class="j-flag"></div>
<div class="j-flag"></div>
</textarea>
<textarea name="jst" id="m-wgt-song-list" style="display:none;"><table class="m-table {if type=='rank'}m-table-rank{/if}">
<thead>
<tr>
<th class="first {if type=='rank'}wrk{else}w1{/if}"><div class="wp">&nbsp;</div></th>
<th><div class="wp">歌曲标题</div></th>
<th class="w2"><div class="wp">时长</div></th>
<th class="w3"><div class="wp">歌手</div></th>
<th class="w4"><div class="wp">专辑</div></th>
</tr>
</thead>
<tbody>
{list beg..end as y}
{var x=xlist[y]}
<tr id="${x.id|seed}" class="{if y%2==0}even{/if} {if disable(x)}js-dis{/if}">
<td class="left">
<div class="hd {if type=='rank'}rank{/if}">
<span data-res-id="${x.id}" data-res-type="18" data-res-action="play" {if from}data-res-from="${from.fid}" data-res-data="${from.fdata}"{/if} class="ply {if isPlaying(x)}ply-z-slt{/if}">&nbsp;</span>
<span class="num">${y+1}</span>
{if type=='rank'}
<div class="rk rk-1">
{if x.lastRank>=0}
{if y-x.lastRank>0}
<span class="ico u-icn u-icn-74 s-fc10">${y-x.lastRank}</span>
{elseif y-x.lastRank==0}
<span class="ico u-icn u-icn-72 s-fc4">0</span>
{else}
<span class="ico u-icn u-icn-73 s-fc9">${x.lastRank-y}</span>
{/if}
{else}
<span class="u-icn u-icn-75"></span>
{/if}
</div>
{/if}
</div>
</td>
<td class="">
<div class="f-cb">
<div class="tt">
<div class="ttc">
<span class="txt">
{var alia=songAlia(x)}
<a href="/song?id=${x.id}"><b title="${x.name|escape}{if alia} - (${alia|escape}){/if}">${x.name|escape}</b></a>{if alia}<span title="${alia|escape}" class="s-fc8"> - (${alia|escape})</span>{/if}
{if x.mvid>0}
<span data-res-id="${x.id}" data-res-action="mv" title="播放mv" class="mv">MV</span>
{/if}
</span>
</div>
</div>
</div>
</td>
<td class=" s-fc3">
<span class="u-dur {if canDel}candel{/if}">${dur2time(x.duration/1000)}{if x.ftype==2}<i title="歌曲来自第三方网站" class="migu u-icn2 u-icn2-14"></i>{/if}</span>
<div class="opt hshow">
<a class="u-icn u-icn-81 icn-add" href="javascript:;" title="添加到播放列表" hidefocus="true"
data-res-type="18"
data-res-id="${x.id}"
data-res-action="addto"
{if from}data-res-from="${from.fid}" data-res-data="${from.fdata}"{/if}></a>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="fav" class="icn icn-fav" title="收藏"></span>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="share" data-res-name="${x.name}" data-res-author="{list x.artists as art}${art.name}{if art_index<x.artists.length-1}/{/if}{/list}" {if x.album}data-res-pic="${x.album.picUrl}"{/if} class="icn icn-share" title="分享">分享</span>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="download" class="icn icn-dl" title="下载"></span>
{if canDel}
<span data-res-id="${x.id}" data-res-type="18" data-res-action="delete" class="icn icn-del" title="删除">删除</span>
{/if}
</div>
</td>
<td class="">
<div class="text" title="{list x.artists as art}${art.name}{if art_index<x.artists.length-1}/{/if}{/list}">
${getArtistName(x.artists)}
</div>
</td>
{if type=='dayRcmd'}
<td class="hascls">
<div class="f-pr">
<div class="text">{if x.album}<a href="/album?id=${x.album.id}" title="${x.album.name}">${x.album.name}</a>{/if}</div>
<a href="javascript:;" data-res-action="dislike" data-res-id="${x.id}" data-res-alg="${x.alg}" class="cls u-icn u-icn-80 f-tid icn-dislike" title="不感兴趣">不感兴趣</a>
</div>
</td>
{else}
<td class="">
<div class="text">
{if x.album}
<a href="/album?id=${x.album.id}" title="${x.album.name|escape}">${x.album.name|escape}</a>
{/if}
</div>
</td>
{/if}
</tr>
{/list}
</tbody>
</table>
</textarea>
<textarea name="jst" id="m-wgt-album-list" style="display:none;"><table class="m-table {if type=='rank'}m-table-rank{/if}">
<thead>
<tr>
<th class="first {if type=='rank'}wrk{else}w1{/if}"><div class="wp">&nbsp;</div></th>
<th><div class="wp">歌曲标题</div></th>
<th class="w2-1"><div class="wp">时长</div></th>
<th class="w4"><div class="wp">歌手</div></th>
</tr>
</thead>
<tbody>
{list beg..end as y}
{var x=xlist[y]}
<tr id="${x.id|seed}" class="{if y%2==0}even{/if} {if disable(x)}js-dis{/if}">
<td class="left">
<div class="hd {if type=='rank'}rank{/if}">
<span data-res-id="${x.id}" data-res-type="18" data-res-action="play" {if from}data-res-from="${from.fid}" data-res-data="${from.fdata}"{/if} class="ply {if isPlaying(x)}ply-z-slt{/if}">&nbsp;</span>
<span class="num">${y+1}</span>
{if type=='rank'}
<div class="rk rk-1">
{if x.lastRank>=0}
{if y-x.lastRank>0}
<span class="ico u-icn u-icn-74 s-fc10">${y-x.lastRank}</span>
{elseif y-x.lastRank==0}
<span class="ico u-icn u-icn-72 s-fc4">0</span>
{else}
<span class="ico u-icn u-icn-73 s-fc9">${x.lastRank-y}</span>
{/if}
{else}
<span class="u-icn u-icn-75"></span>
{/if}
</div>
{/if}
</div>
</td>
<td class="">
<div class="f-cb">
<div class="tt">
<div class="ttc">
<span class="txt">
{var alia=songAlia(x)}
<a href="/song?id=${x.id}"><b title="${x.name|escape}{if alia} - (${alia|escape}){/if}">${x.name|escape}</b></a>{if alia}<span title="${alia|escape}" class="s-fc8"> - (${alia|escape})</span>{/if}
{if x.mvid>0}
<span data-res-id="${x.id}" data-res-action="mv" title="播放mv" class="mv">MV</span>
{/if}
</span>
</div>
</div>
</div>
</td>
<td class=" s-fc3">
<span class="u-dur {if canDel}candel{/if}">${dur2time(x.duration/1000)}{if x.ftype==2}<i title="歌曲来自第三方网站" class="migu u-icn2 u-icn2-14"></i>{/if}</span>
<div class="opt hshow">
<a class="u-icn u-icn-81 icn-add" href="javascript:;" title="添加到播放列表" hidefocus="true"
data-res-type="18"
data-res-id="${x.id}"
data-res-action="addto"
{if from}data-res-from="${from.fid}" data-res-data="${from.fdata}"{/if}></a>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="fav" class="icn icn-fav" title="收藏"></span>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="share" data-res-name="${x.name}" data-res-author="{list x.artists as art}${art.name}{if art_index<x.artists.length-1}/{/if}{/list}" {if x.album}data-res-pic="${x.album.picUrl}"{/if} class="icn icn-share" title="分享">分享</span>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="download" class="icn icn-dl" title="下载"></span>
{if canDel}
<span data-res-id="${x.id}" data-res-type="18" data-res-action="delete" class="icn icn-del" title="删除">删除</span>
{/if}
</div>
</td>
<td class="">
<div class="text" title="{list x.artists as art}${art.name}{if art_index<x.artists.length-1}/{/if}{/list}">
${getArtistName(x.artists, '', '/', false, true)}
</div>
</td>
</tr>
{/list}
</tbody>
</table>
</textarea>
<textarea name="jst" id="m-wgt-song-top50-list" style="display:none;"><table class="m-table m-table-1 m-table-4">
<tbody>
{var preScore = 100}
{list beg..end as y}
{var x=xlist[y]}
{var score = Math.min(preScore, x.score);preScore = score;}
<tr id="${x.id|seed}" class="{if y%2==0}even{/if} {if disable(x)}js-dis{/if}">
<td class="w1">
<div class="hd">
<span data-res-id="${x.id}" data-res-type="18" data-res-action="play" {if from}data-res-from="${from.fid}" data-res-data="${from.fdata}"{/if} class="ply {if isPlaying(x)}ply-z-slt{/if}">&nbsp;</span>
<span class="num">${y+1}</span>
</div>
</td>
<td class="">
<div class="f-cb">
<div class="tt">
<div class="ttc">
<span class="txt">
{var alia=songAlia(x)}
<a href="/song?id=${x.id}"><b title="${x.name|escape}{if alia} - (${alia|escape}){/if}">${x.name|escape}</b></a>{if alia}<span title="${alia|escape}" class="s-fc8"> - (${alia|escape})</span>{/if}
{if x.mvid>0}
<span data-res-id="${x.id}" data-res-action="mv" title="播放mv" class="mv">MV</span>
{/if}
</span>
</div>
</div>
</div>
</td>
<td class="w2-1 s-fc3">
<span class="u-dur {if canDel}candel{/if}">${dur2time(x.duration/1000)}{if x.ftype==2}<i title="歌曲来自第三方网站" class="migu u-icn2 u-icn2-14"></i>{/if}</span>
<div class="opt hshow">
<a class="u-icn u-icn-81 icn-add" href="javascript:;" title="添加到播放列表" hidefocus="true"
data-res-type="18"
data-res-id="${x.id}"
data-res-action="addto"
{if from}data-res-from="${from.fid}" data-res-data="${from.fdata}"{/if}></a>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="fav" class="icn icn-fav" title="收藏"></span>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="share" data-res-name="${x.name}" data-res-author="{list x.artists as art}${art.name}{if art_index<x.artists.length-1}/{/if}{/list}" {if x.album}data-res-pic="${x.album.picUrl}"{/if} class="icn icn-share" title="分享">分享</span>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="download" class="icn icn-dl" title="下载"></span>
{if canDel}
<span data-res-id="${x.id}" data-res-type="18" data-res-action="delete" class="icn icn-del" title="删除">删除</span>
{/if}
</div>
</td>
<td class="w4">
<div class="text">
{if x.album}
{var transName = x.album.tns && x.album.tns.length > 0 ? x.album.tns[0] : ''}
<a href="/album?id=${x.album.id}" title="${x.album.name|escape}{if transName} - (${transName|escape}){/if}">${x.album.name|escape}</a>
{if transName}
<span title="${transName|escape}" class="s-fc8"> - (${transName|escape})</span>
{/if}
{/if}
</div>
</td>
<td class="w5"><span class="hot u-hot"><i style="width:${score*0.92}%"><i></i></i></span></td>
</tr>
{/list}
</tbody>
</table>
</textarea>
<textarea name="jst" id="m-wgt-song-rank-list" style="display:none;"><table class="m-table m-table-rank">
<thead>
<tr>
<th class="first w1"></th>
<th><div class="wp">标题</div></th>
<th class="w2-1"><div class="wp">时长</div></th>
<th class="w3"><div class="wp">歌手</div></th>
</tr>
</thead>
<tbody>
{list beg..end as y}
{var x=xlist[y]}
<tr id="${x.id|seed}" class="{if y%2==0}even{/if} {if disable(x)}js-dis{/if}">
{if y<3}
<td>
<div class="hd">
<span class="num">${y+1}</span>
<div class="rk ">
{if x.lastRank>=0}
{if y-x.lastRank>0}
<span class="ico u-icn u-icn-74 s-fc10">${y-x.lastRank}</span>
{elseif y-x.lastRank==0}
<span class="ico u-icn u-icn-72 s-fc4">0</span>
{else}
<span class="ico u-icn u-icn-73 s-fc9">${x.lastRank-y}</span>
{/if}
{else}
<span class="u-icn u-icn-75"></span>
{/if}
</div>
</div>
</td>
<td class="rank">
<div class="f-cb">
<div class="tt">
<a href="/song?id=${x.id}">{if x.album}<img class="rpic" src="${x.album.picUrl}?param=50y50&quality=100">{/if}</a>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="play" {if from}data-res-from="${from.fid}" data-res-data="${from.fdata}"{/if} class="ply {if isPlaying(x)}ply-z-slt{/if}">&nbsp;</span>
<div class="ttc">
<span class="txt">
{var alia=songAlia(x)}
<a href="/song?id=${x.id}"><b title="${x.name|escape}{if alia} - (${alia|escape}){/if}">${x.name|escape}</b></a>{if alia}<span title="${alia|escape}" class="s-fc8"> - (${alia|escape})</span>{/if}
{if x.mvid>0}
<span data-res-id="${x.id}" data-res-action="mv" title="播放mv" class="mv">MV</span>
{/if}
</span>
</div>
</div>
</div>
</td>
{else}
<td>
<div class="hd">
<span class="num">${y+1}</span>
<div class="rk ">
{if x.lastRank>=0}
{if y-x.lastRank>0}
<span class="ico u-icn u-icn-74 s-fc10">${y-x.lastRank}</span>
{elseif y-x.lastRank==0}
<span class="ico u-icn u-icn-72 s-fc4">0</span>
{else}
<span class="ico u-icn u-icn-73 s-fc9">${x.lastRank-y}</span>
{/if}
{else}
<span class="u-icn u-icn-75"></span>
{/if}
</div>
</div>
</td>
<td class="">
<div class="f-cb">
<div class="tt">
<span data-res-id="${x.id}" data-res-type="18" data-res-action="play" {if from}data-res-from="${from.fid}" data-res-data="${from.fdata}"{/if} class="ply {if isPlaying(x)}ply-z-slt{/if}">&nbsp;</span>
<div class="ttc">
<span class="txt">
{var alia=songAlia(x)}
<a href="/song?id=${x.id}"><b title="${x.name|escape}{if alia} - (${alia|escape}){/if}">${x.name|escape}</b></a>{if alia}<span title="${alia|escape}" class="s-fc8"> - (${alia|escape})</span>{/if}
{if x.mvid>0}
<span data-res-id="${x.id}" data-res-action="mv" title="播放mv" class="mv">MV</span>
{/if}
</span>
</div>
</div>
</div>
</td>
{/if}
<td class=" s-fc3">
<span class="u-dur {if canDel}candel{/if}">${dur2time(x.duration/1000)}{if x.ftype==2}<i title="歌曲来自第三方网站" class="migu u-icn2 u-icn2-14"></i>{/if}</span>
<div class="opt hshow">
<a class="u-icn u-icn-81 icn-add" href="javascript:;" title="添加到播放列表" hidefocus="true"
data-res-type="18"
data-res-id="${x.id}"
data-res-action="addto"
{if from}data-res-from="${from.fid}" data-res-data="${from.fdata}"{/if}></a>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="fav" class="icn icn-fav" title="收藏"></span>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="share" data-res-name="${x.name}" data-res-author="{list x.artists as art}${art.name}{if art_index<x.artists.length-1}/{/if}{/list}" {if x.album}data-res-pic="${x.album.picUrl}"{/if} class="icn icn-share" title="分享">分享</span>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="download" class="icn icn-dl" title="下载"></span>
{if canDel}
<span data-res-id="${x.id}" data-res-type="18" data-res-action="delete" class="icn icn-del" title="删除">删除</span>
{/if}
</div>
</td>
<td class="">
<div class="text" title="{list x.artists as art}${art.name}{if art_index<x.artists.length-1}/{/if}{/list}">
${getArtistName(x.artists)}
</div>
</td>
</tr>
{/list}
</tbody>
</table>
</textarea>
<textarea name="jst" id="m-wgt-song-pgm-list" style="display:none;"><table class="m-table m-table-prog">
<tbody id="song-list">
{list beg..end as y}
{var x=xlist[y]}
<tr id="${x.id|seed}" class="{if y%2!=0}even{/if} {if disable(x)}js-dis{/if}">
<td class="first col1">
<div class="hd">
<span data-res-id="${x.id}" data-res-type="18" data-res-action="play" {if from}data-res-from="${from.fid}" data-res-data="${from.fdata}"{/if} class="ply {if isPlaying(x)}ply-z-slt{/if}">&nbsp;</span>
<span class="num">${y+1}</span>
</div>
</td>
<td class="col2">
<div class="f-cb">
<div class="tt">
<div class="ttc">
<span class="txt">
{var alia=songAlia(x)}
<a href="/song?id=${x.id}"><b title="${x.name|escape}{if alia} - (${alia|escape}){/if}">${x.name|escape}</b></a>{if alia}<span title="${alia|escape}" class="s-fc8"> - (${alia|escape})</span>{/if}
{if x.mvid>0}
<span data-res-id="${x.id}" data-res-action="mv" title="播放mv" class="mv">MV</span>
{/if}
</span>
</div>
</div>
</div>
</td>
<td class="col3 s-fc3">
<span class="u-dur {if canDel}candel{/if}">${dur2time(x.duration/1000)}{if x.ftype==2}<i title="歌曲来自第三方网站" class="migu u-icn2 u-icn2-14"></i>{/if}</span>
<div class="opt hshow">
<a class="u-icn u-icn-81 icn-add" href="javascript:;" title="添加到播放列表" hidefocus="true"
data-res-type="18"
data-res-id="${x.id}"
data-res-action="addto"
{if from}data-res-from="${from.fid}" data-res-data="${from.fdata}"{/if}></a>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="fav" class="icn icn-fav" title="收藏"></span>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="share" data-res-name="${x.name}" data-res-author="{list x.artists as art}${art.name}{if art_index<x.artists.length-1}/{/if}{/list}" {if x.album}data-res-pic="${x.album.picUrl}"{/if} class="icn icn-share" title="分享">分享</span>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="download" class="icn icn-dl" title="下载"></span>
{if canDel}
<span data-res-id="${x.id}" data-res-type="18" data-res-action="delete" class="icn icn-del" title="删除">删除</span>
{/if}
</div>
</td>
<td class="col4">
<div class="text" title="{list x.artists as art}${art.name}{if art_index<x.artists.length-1}/{/if}{/list}">
${getArtistName(x.artists)}
</div>
</td>
<td class="col5">
<div class="text">
{if x.album}
<a href="/album?id=${x.album.id}" title="${x.album.name|escape}">${x.album.name|escape}</a>
{/if}
</div>
</td>
</tr>
{/list}
</tbody>
</table>
</textarea>
<textarea name="jst" id="m-wgt-song-listen" style="display:none;"> <ul>
{list beg..end as y}
{var x=xlist[y]}
{if extData&&extData.limit&&y>=extData.limit}
{break}
{/if}
{var from=getFrom()}
<li id="${x.id|seed}" {if y%2 !=0 }class='even'{/if}>
<div class="hd ">
<span data-res-id="${x.id}" data-res-type="18" data-res-action="play" {if from}data-res-from="${from.fid}" data-res-data="${from.fdata}"{/if} class="ply {if isPlaying(x)}ply-z-slt{/if}">&nbsp;</span>
<span class="num">${y+1}.</span>
</div>
<div class="song">
<div class="tt">
<div class="ttc">
<span class="txt"><a href="/song?id=${x.id}"><b title="${x.name}">${x.name}</b></a>
<span class='ar s-fc8'> <em>-</em>
${getArtistName(x.artists, 's-fc8')}
</span>
</span>
</div>
</div>
<div class="opt">
<a class="u-icn u-icn-81 icn-add" href="javascript:;" title="添加到播放列表" hidefocus="true" data-res-type="18" data-res-id="${x.id}" data-res-action="addto" {if from}data-res-from="${from.fid}" data-res-data="${from.fdata}"{/if}></a>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="subscribe" class="icn icn-fav" title="收藏"></span>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="share" data-res-name="${x.name}" data-res-author="{list x.artists as art}${art.name}{if art_index<x.artists.length-1}/{/if}{/list}" class="icn icn-share" title="分享">分享</span>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="download" class="icn icn-dl" title="下载">下载</span>
</div>
</div>
<div class="tops">
<span class="bg" style='width:${x.score*100/x.max}%;'></span>
{if extData.showCount&&x.playCount}<span class="times f-ff2">${x.playCount}次</span>{/if}
</div>
</li>
{/list}
</ul>
{if extData&&extData.limit&&xlist.length>extData.limit}
<div class="more">
<a href="/user/songs/rank?id=${hostId}" >查看更多&gt;</a>
</div>
{/if}
</textarea>
<textarea name="jst" id="m-wgt-purchased-song-list" style="display:none;"> {list beg..end as y}
{var x=xlist[y]}
<tr id="${x.id|seed}" class="{if y%2==1}even{/if} {if disable(x)}js-dis{/if}">
<td class="left">
<div class="hd {if type=='rank'}rank{/if}">
<span data-res-id="${x.id}" data-res-type="18" data-res-action="play" {if from}data-res-from="${from.fid}" data-res-data="${from.fdata}"{/if} class="ply {if isPlaying(x)}ply-z-slt{/if}">&nbsp;</span>
<span class="num">${y+1}</span>
{if type=='rank'}
<div class="rk rk-1">
{if x.lastRank>=0}
{if y-x.lastRank>0}
<span class="ico u-icn u-icn-74 s-fc10">${y-x.lastRank}</span>
{elseif y-x.lastRank==0}
<span class="ico u-icn u-icn-72 s-fc4">0</span>
{else}
<span class="ico u-icn u-icn-73 s-fc9">${x.lastRank-y}</span>
{/if}
{else}
<span class="u-icn u-icn-75"></span>
{/if}
</div>
{/if}
</div>
</td>
<td class="u-hasopt">
<div class="f-cb">
<div class="tt">
<div class="ttc">
<span class="txt">
{var alia=songAlia(x)}
<a href="/song?id=${x.id}"><b title="${x.name|escape}{if alia} - (${alia|escape}){/if}">${x.name|escape}</b></a>{if alia}<span title="${alia|escape}" class="s-fc8"> - (${alia|escape})</span>{/if}
{if x.mvid>0}
<span data-res-id="${x.id}" data-res-action="mv" title="播放mv" class="mv">MV</span>
{/if}
</span>
</div>
</div>
<div class="opt hshow">
<a class="u-icn u-icn-81 icn-add" href="javascript:;" title="添加到播放列表" hidefocus="true"
data-res-type="18"
data-res-id="${x.id}"
data-res-action="addto"
{if from}data-res-from="${from.fid}" data-res-data="${from.fdata}"{/if}></a>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="fav" class="icn icn-fav" title="收藏"></span>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="share" data-res-name="${x.name}" data-res-author="{list x.artists as art}${art.name}{if art_index<x.artists.length-1}/{/if}{/list}" {if x.album}data-res-pic="${x.album.picUrl}"{/if} class="icn icn-share" title="分享">分享</span>
<span data-res-id="${x.id}" data-res-type="18" data-res-action="download" class="icn icn-dl" title="下载"></span>
{if canDel}
<span data-res-id="${x.id}" data-res-type="18" data-res-action="delete" class="icn icn-del" title="删除">删除</span>
{/if}
</div>
</div>
</td>
<td class="">
<div class="text" title="{list x.artists as art}${art.name}{if art_index<x.artists.length-1}/{/if}{/list}">
${getArtistName(x.artists)}
</div>
</td>
<td class="">
<div class="text">
{if x.album}
<a href="/album?id=${x.album.id}" title="${x.album.name|escape}">${x.album.name|escape}</a>
{/if}
</div>
</td>
<td class="s-fc3">${formatTime(x.paidTime)}</td>
</tr>
{/list}
</textarea>
<textarea name="ntp" id="m-msg-private-send" style="display:none;"><div class="lyct lyct-1 f-cb">
<div class="m-lyshare m-plshare">
<div class="u-err j-flag" style="display: none;">最多选择10位好友</div>
<div class="item item-1 f-cb">
<label>发 给：</label>
<div class="ct f-pr j-flag">
</div>
</div>
<div class="item f-cb">
<label>内 容：</label>
<div class="ct j-flag">
</div>
</div>
</div>
</div>
</textarea>
<textarea name="jst" id="m-wgt-redeem-tip" style="display:none;"><div class="lyct">
<div class="result f-tc">
<div class="text">
<h4 class="f-fs2"><i class="icn u-icn2 u-icn2-{if type=='error'}16{else}15{/if}"></i>${title}</h4>
<p class="f-fs1">${sub}</p>
</div>
<div class="btnwrap {if ok&&cc}btnwrap-1{/if}">
{if ok}
<a data-action="ok" href="javascript:;" class="u-btn2 u-btn2-2 {if ok.length <= 3}u-btn2-w2{/if}" hidefocus="true"><i>${ok}</i></a>
{/if}
{if cc}
<a data-action="cc" href="javascript:;" class="u-btn2 u-btn2-1 u-btn2-w2" hidefocus="true"><i>${cc}</i></a>
{/if}
</div>
</div>
</div>
</textarea>
</div>
<script src="//s3.music.126.net/sep/s/2/core.js?fbb2919c31fa9a89feb223e12c7d9c55" type="text/javascript"></script><script src="//s3.music.126.net/sep/s/2/pt_frame_index.js?ecac74abe3d362a30ed7842c9a26ed81" type="text/javascript"></script>
</body>
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-38766552-1'],['_setLocalGifPath', '/UA-38766552-1/__utm.gif'],['_setLocalRemoteServerMode']);
_gaq.push(['_trackPageview']);
(function() {
var ga = document.createElement('script');
ga.type = 'text/javascript';
ga.async = true;
ga.src = '//wr.da.netease.com/ga.js';
var s = document.getElementsByTagName('script')[0];
s.parentNode.insertBefore(ga, s);
})();//fix ipad下的一个bug
if (navigator.userAgent.indexOf('iPad') != -1) {
iframeHeight = Math.max(
Math.max(document.body.scrollHeight, document.documentElement.scrollHeight),
Math.max(document.body.offsetHeight, document.documentElement.offsetHeight),
Math.max(document.body.clientHeight, document.documentElement.clientHeight)
);
top.document.body.style.height = iframeHeight + 20 + 'px';
}</script>
</html>