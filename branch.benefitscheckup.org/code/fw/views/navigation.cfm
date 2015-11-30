
<script type="text/javascript">
	// Drop down menu functionality...
	var timeout    = 500;
	var closetimer = 0;
	var ddmenuitem = 0;

	function ddopen(){  
		ddcanceltimer();
   		ddclose();
   		ddmenuitem = $(this).find('ul').css('visibility', 'visible').show('normal');
	}
	function ddclose(){  
		if(ddmenuitem) ddmenuitem.css('visibility', 'hidden');
	}
	function ddtimer(){  
		closetimer = window.setTimeout(ddclose, timeout);
	}
	function ddcanceltimer(){
		if(closetimer){  
			window.clearTimeout(closetimer);
			closetimer = null;
		}
	}
	$(document).ready(function(){  
		$('#ddmenu > li').bind('mouseover', ddopen)
   		$('#ddmenu > li').bind('mouseout',  ddtimer)
	});
	document.onclick = ddclose;
</script>
<ul id="ddmenu">
	<li><a href="index.cfm?event=home">HOME</a></li>
	<li><a href="index.cfm?event=admin.login">LOGIN</a></li>
    <li><a href="index.cfm?event=aboutus">ABOUT</a></li>
    <cfif isdefined("session.user") AND session.user.hasRole("readonly")>
    	<li><a href="index.cfm?event=admin.listPrograms">PROGRAMS</a>
        	<ul>
                <li><a href="index.cfm?event=admin.listPrograms">List Programs</a></li>
                <cfif session.user.hasRole("superuser")>
                    <li><a href="index.cfm?event=admin.createProgram">Create a Program</a></li>
                </cfif>
            </ul>
        </li>
        <li><a href="index.cfm?event=admin.listSubsets">SUBSETS</a>
        	<ul>
                <li><a href="index.cfm?event=admin.listSubsets">List Subsets</a></li>
                <cfif session.user.hasRole("superuser")>
                    <li><a href="index.cfm?event=admin.createSubset">Create a Subset</a></li>
                </cfif>
            </ul>
        </li>
    	<li><a href="index.cfm?event=admin.listUsers">USERS</a>
        	<ul>
                <li><a href="index.cfm?event=admin.listUsers">List Users</a></li>
                <cfif session.user.hasRole("superuser")>
                    <li><a href="index.cfm?event=admin.createUser&user_id=0">Create a User</a></li>
                </cfif>
            </ul>
        </li>
    </cfif>
</ul>