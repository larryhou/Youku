// ==UserScript==  
// @name         Youku Video Helper
// @version		 1.0.0
// @author       larryhou@foxmail.com
// @namespace    https://github.com/larryhou
// @description  解析优酷视频播放页面
// @include      *://v.youku.com/v_show/id_*
// ==/UserScript== 

function install(callback)
{
	var script = document.createElement("script");
	script.type = "text/javascript";
	script.textContent = "(" + callback.toString() + ")(window.jQuery, window);";
	document.head.appendChild(script);
}

install(function($, window)
{
	var kw = encodeURIComponent(window.location.href)
	var parser = "http://www.flvcd.com/parse.php?kw=" + kw + "&flag=one&format=super&s=trap"
	
	$("<iframe id='trap' width='100%' height='200px'></iframe>")
	.attr("src", parser)
	.css("border", "0px")
	.prependTo($(window.document.body))

	var episodes = jQuery(".item .sn").filter(function(){return jQuery(this).find(".sn_ispreview").length == 0}).map(function(){return this.href}).toArray()
	if (jQuery(".sn.current .sn_num").length == 0) return

	var index = parseInt(jQuery(".sn.current .sn_num").text())
	if (index >= episodes.length) return

	window.setTimeout(function()
	{
		window.location.href = episodes[index]
	}, 5 * 1000)
});
