<h1 class="h1">Podcasts Page</h1>
<cfoutput>
<p class="text1">
<strong>JPG:</strong><br />
<img src="bcu_logo.jpg" style="border:1px solid ##000000;" />
</p>
<p class="text1">
<strong>Download MP3 File:</strong>
</p>

<p class="text1">
<a href="2008-05-23.mp3">2008-05-23.mp3</a>
</p>

<p class="text1">
<strong>MP3 Player:</strong>
</p>

<p class="text1">
<object type="application/x-shockwave-flash" width="400" height="15"
data="http://#application.serverPath#/podcasts/xspf_player_slim.swf?playlist_url=http://#application.serverPath#/podcasts/playlist.xspf">
<param name="movie" 
value="http://#application.serverPath#/podcasts/xspf_player_slim.swf?playlist_url=http://#application.serverPath#/podcasts/playlist.xspf" />
</object>
</p>
</cfoutput>
