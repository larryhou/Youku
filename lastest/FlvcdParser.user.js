// ==UserScript==  
// @name         www.flvcd.com helper
// @version		 1.0.0
// @author       larryhou@foxmail.com
// @namespace    https://github.com/larryhou
// @description  解析优酷视频下载链接
// @include      *://www.flvcd.com/parse.php?*
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
	var href = window.location.href
	if (href.indexOf("s=trap") < 0) return

	function notify(data, timeout) 
	{
		if (Notification.permission == "granted") 
		{
			var msg = new Notification(data.title, {
				body: data.body,
				icon: "http://larryhou.github.io/images/server.png" // icon url - can be relative
			})
			
			if (timeout) 
			{
				window.setTimeout(function()
				{
					msg.close()
				}, timeout)
			}
		} 
		else 
		{
			Notification.requestPermission()
		}
	}

	var flag = false

	function dojob()
	{
		if (href.indexOf("u=1") >= 0)
		{
			flag = true
			var episode_chapters = jQuery("a[href*='movie=1']").map(function(){return this.href}).toArray()
			var title = window.document.title.split("-").shift().split("[").shift().trim()

			var tv = title.replace(/\d+$/, "").trim()
			var episode = title.match(/(\d+)$/) ? title.match(/(\d+)$/)[0] : "all"

			var gateway = "http://localhost:8080/tv.php"
			$.post(gateway + "?tv=" + tv + "&episode=" + episode, 
			episode_chapters.join("\n"), function(data)
			{
				console.log(data)
				notify(data, 2000)
			}, "json")
		}
		else
		{
			var g = window.createSc(window.avdGgggg, window.avdGggggtt);
			var a = new Date();
			a.setTime(a.getTime() + 300 * 1000);
			window.document.cookie = "go=" + g + ";expires=" + a.toGMTString();
			window.document.cookie = "avdGggggtt=" + window.avdGggggtt + ";expires=" + a.toGMTString();
			window.setTimeout(function() 
			{
				window.location.href = window.location.href + "&u=1"
			}, 500)
		}
	}

	$(window.document).ready(dojob)
	// window.setTimeout(function()
	// {
	// 	if (!flag)
	// 	{
	// 		window.location.reload()
	// 	}
	// }, 2500)
});
