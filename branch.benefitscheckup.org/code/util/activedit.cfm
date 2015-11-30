<cfif NOT isdefined("thistag.ExecutionMode")>Activedit must be executed as a custom tag.<cfabort></cfif>
<cfsetting enablecfoutputonly="yes">
<cfparam name="attributes.type" default="form">

<cfif thisTag.executionMode IS "end"> 

<cfoutput>
<!--- trial token placeholder --->
<!-- begin cf_activedit v:5.0 (5.0.52 02/07/2007)  --></cfoutput>
<cfparam name="request.ae_num" default="0">
<cfset request.ae_num=request.ae_num+1>
<cfset ae_num=request.ae_num>

<!--- 	CF_Activedit 
		Copyright 1999-2006 ActivSoftware
		All Rights reserved
		Authors: 	Pete Freitag
				Matt Finn 
				Greg Alton
		Version: 5.0 (5.0.52 02/07/2007)
	
--->
	
<!--- Build Stock buttons --->

<cfset ae_stockbtns=StructNew()>
<cfset ae_stockbtns.cut="Cut,Cut,Cut the selected text and put it on the clipboard,images/cut.gif">
<cfset ae_stockbtns.copy="Copy,Copy,Copy the selected text into the clipboard,images/copy.gif">
<cfset ae_stockbtns.paste="Paste,Paste,Paste the contents of the clipboard into the workspace,images/paste.gif">
<cfset ae_stockbtns.pastetext="PasteText,Paste Text,Paste the contents of the clipboard without formatting,images/pastetext.gif">
<cfset ae_stockbtns.undo="Undo,Undo,Undo the last operation,images/undo.gif">
<cfset ae_stockbtns.redo="Redo,Redo,Redo the last operation,images/redo.gif">
<cfset ae_stockbtns.font="Font,Font,Change font and color,images/fgcolor.gif">
<cfset ae_stockbtns.bold="Bold,Bold,Make selected text bold,images/bold.gif">
<cfset ae_stockbtns.italic="Italic,Italic,Make selected text italic,images/italic.gif">
<cfset ae_stockbtns.underline="Underline,Underline,Underline the selected text,images/under.gif">
<cfset ae_stockbtns.outdent="Outdent,Decrease Indent,Reverse indent the current line,images/deindent.gif">
<cfset ae_stockbtns.indent="Indent,Indent,Indent the current line,images/inindent.gif">
<cfset ae_stockbtns.justifyleft="JustifyLeft,Align Left,Left justify the current line,images/left.gif">
<cfset ae_stockbtns.justifycenter="JustifyCenter,Center,Center the current line,images/center.gif">
<cfset ae_stockbtns.justifyright="JustifyRight,Align Right,Right justify the current line,images/right.gif">
<cfset ae_stockbtns.bullets="InsertUnorderedList,Bullets,Insert a bullet on current line,images/bullist.gif">
<cfset ae_stockbtns.numbers="InsertOrderedList,Numbering,Insert a numbered list on current line,images/numlist.gif">
<cfset ae_stockbtns.find="Find,Find,Find text in the document,images/find.gif">
<cfset ae_stockbtns.table="InsertTable,Insert Table,Insert a table,images/instable.gif">
<cfset ae_stockbtns.image="InsertImage,Insert Image,Insert an image,images/image.gif">
<cfset ae_stockbtns.hyperlink="Hyperlink,Insert Hyperlink,Insert a hyperlink on selected text,images/link.gif">
<cfset ae_stockbtns.help="Help,Help,Help,images/help.gif">
<cfset ae_stockbtns.showdetails="ShowDetails,Show Details,Displays hidden elements as glyphs,images/paragraph.gif">
<cfset ae_stockbtns.spellcheck="SpellCheck,Spell Check,Open spell check window,images/spell.gif">
<cfset ae_stockbtns.specialchars="SpecialChars,Special Characters,Insert a Special Character,images/specialchar.gif">
<cfset ae_stockbtns.hr = "InsertHR,Horizontal Rule,Insert a Horizontal Rule,images/hr.gif">
<cfset ae_stockbtns.subscript = "Subscript,Subscript,Subscript,images/subscript.gif">
<cfset ae_stockbtns.superscript = "Superscript,Superscript,Superscript,images/superscript.gif">
<cfset ae_stockbtns.strike = "Strike,Strike,Strike the selected text,images/strike.gif">
<cfset ae_stockbtns.highlight = "Highlight,Highlight,Highlight the selected text,images/highlight.gif">
<cfset ae_stockbtns.removeformat = "RemoveFormat,Remove Format,Remove Formatting,images/removeformat.gif">
<cfset ae_stockbtns.replace = "Replace,Replace,Replace Text,images/replace.gif">

			<!--- initialize error handeler ---> 
			<cfset error = 0>

			<!--- Error: inc is a required attribute --->
			<cfif NOT IsDefined("attributes.inc")>
				<cfset error = 1>
				<cfoutput>
					<li>ERROR: 
					The Required Attribute "inc" was not found in the tag input. 
					<i> This Attribute should contain the url to the 'inc' folder.</i></li>
				</cfoutput>
			</cfif>
			
			<cfparam name="attributes.fieldname" default="">
			<cfparam name="attributes.name" default="#attributes.fieldname#">
	
				<!--- Error: fieldname is a required attribute --->
				<cfif NOT Len(attributes.name)>
					<cfset error = 1>
					<cfoutput>
						<li>ERROR: 
						The Required Attribute "name" was not found in the tag input. 
						<i> This Attribute should contain the name of the field the dynamic data is stored in.</i></li>
					</cfoutput>
				</cfif>

			<!--- Set for conditional requirements --->
			<cfparam name="attributes.upload" default="1">
			<cfparam name="attributes.activscan" default="0">
			<cfparam name="attributes.path" default="">
			<cfparam name="attributes.url" default="">
			<cfparam name="attributes.imagepath" default="#attributes.path#">
			<cfparam name="attributes.imageurl" default="#attributes.url#">

			<cfif NOT IsDefined("attributes.image") AND 
					NOT Len(attributes.imagepath) AND
					NOT Len(attributes.imageurl)>
				<cfset attributes.image=0>
			</cfif>
			
			<cfparam name="attributes.image" default="1">
			
			<!--- Error: A conditional requirement of image=true requires imageurl and imagepath attributes --->
			<cfif attributes.image>
				<cfif NOT Len(attributes.imageurl)>
					<cfset error = 1>
					<cfoutput>
						<li>ERROR: 
						The Required Attribute (For Images) "imageurl" was not found in the tag input.
						<i>This Attribute should contain the url to the 'images' folder.</i></li>
					</cfoutput>
				</cfif>
				
				<cfif NOT Len(attributes.imagepath)>
					<cfset error = 1>
					<cfoutput>
						<li>ERROR: 
						The Required Attribute (For Images and upload) "imagepath" was not found in the tag input.  
						<i>This Attribute should contain the path to the 'images' folder.</i></li>
					</cfoutput>
				</cfif>	
			</cfif>
			
<!--- throw fatal error --->		
	
			<cfif error>
				<cfoutput>
				<title>Error Occurred</title>
				<br /><br />
				<b>This Page Is Terminating Prematurely Due To Fatal Configuration Errors</b>
				</cfoutput>
				<cfabort>
			</cfif>
		
<!--- define parameters --->
			<cfparam name="attributes.debug" default="0" type="boolean">
			<cfparam name="attributes.buttoncolor" default="buttonface">
			<cfparam name="attributes.backgroundcolor" default="">
			<cfparam name="attributes.width" default="610">
			<cfparam name="attributes.height" default="300">
			<cfparam name="attributes.border" default="1px outset">			
			<cfparam name="attributes.alloweditsource" default="1" type="boolean">
			<cfparam name="attributes.breakonenter" default="1" type="boolean">
			<cfparam name="attributes.tabview" default="0" type="boolean">
			
			<cfparam name="attributes.find" default="0" type="boolean">
			<cfparam name="attributes.cutcopypaste" default="1" type="boolean">
			<cfparam name="attributes.allowtable" default="1" type="boolean">
			<cfparam name="attributes.redoundo" default="1" type="boolean">
			<cfparam name="attributes.font" default="1" type="boolean">
			<cfparam name="simpleImage" default="0" type="boolean">
			<cfparam name="attributes.help" default="1" type="boolean">
			<cfparam name="attributes.defaultfont" default="">
			<cfparam name="attributes.baseurl" default="">
			<cfparam name="attributes.quickfonts" default="Arial,Courier New,Helvetica,Times New Roman,Verdana">
			<cfparam name="attributes.quickfontcolors" default="red,blue,green,orange,gray,silver,black,white">
			<cfparam name="attributes.quickstyles" default="">
			<cfparam name="attributes.quickstyleNames" default="">
			<cfparam name="attributes.quickformatNames" default="Normal,Formatted,Address,Heading 1,Heading 2,Heading 3,Heading 4,Heading 5,Heading 6,Numbered List,Bulleted List,Directory List,Menu List,Definition Term,Definition,Paragraph">
			<cfparam name="attributes.stylesheet" default="">
			<cfparam name="attributes.xhtml" default="false">
			<cfparam name="attributes.tabindex" default="0">
		<cfif NOT IsDefined("attributes.toolbar")>
			<cfset toolbar="">
			<cfif attributes.cutcopypaste><cfset toolbar=toolbar&"cut,copy,paste,|,"></cfif>
			<cfif attributes.redoundo><cfset toolbar=toolbar&"redo,undo,|,"></cfif>
			<cfif attributes.font><cfset toolbar=toolbar&"font,bold,italic,underline,|,"></cfif>			
			<cfset toolbar=toolbar&"outdent,indent,|,justifyleft,justifycenter,justifyright,bullets,|,">
			<cfif attributes.find><cfset toolbar=toolbar&"find,"></cfif>			
			<cfif attributes.allowtable><cfset toolbar=toolbar&"table,"></cfif>			
			<cfif attributes.image><cfset toolbar=toolbar&"image,"></cfif>			
			<cfset toolbar=toolbar&"hyperlink">
			<cfif attributes.help><cfset toolbar=toolbar&",help"></cfif>			
			<cfset attributes.toolbar=toolbar>
		</cfif>
			<cfparam name="attributes.customCaptions" default="#StructNew()#" type="struct">
			<cfparam name="attributes.applet" default="auto">
<!--- Format Parameters --->

	<cfif NOT Right(attributes.inc, 1) is "/">
		<cfset attributes.inc=attributes.inc & "/">
	</cfif>

	<cfif attributes.image>
		<cfif Right(attributes.imagepath, 1) is "/" OR
      Right(attributes.imagepath, 1) is "\">
			<cfset attributes.imagepath= Left(attributes.imagepath, Len(attributes.imagepath)-1)>		
		</cfif>
		<cfif Right(attributes.imageurl, 1) is "/">
			<cfset attributes.imageurl= Left(attributes.imageurl, Len(attributes.imageurl)-1)>		
		</cfif>
	</cfif>	
			
<!--- define global key --->

<cfset ae_imagedata="#attributes.upload#,#attributes.imagepath#">
<cflock scope="SERVER" type="EXCLUSIVE" timeout="30">
	<cfset "Server.ae_img_#Hash(ae_imagedata)#"=ae_imagedata>
</cflock>
				
<!--- define settings --->
<!--- check applet/dhtml mode --->
			<cfset dhtml = false>
			<cfset applet = false>
			<cfset browser = "other">
			
			<cfif cgi.http_user_agent DOES NOT CONTAIN "MSIE" OR LCase(cgi.http_user_agent) does not contain "windows">
				<cfif cgi.http_user_agent contains "Safari/">
					<cfset browser="safari">
					<cfset safariversion=#REReplace(cgi.http_user_agent, ".*Safari/([0-9]*).*", "\1")#>
					<cfif safariversion is not "85">
						<cfif safariversion is "100" or
							safariversion is "125">
						    <cfif attributes.applet IS NOT "off"><cfset applet = true></cfif>
						<cfelse>
							<cfset dhtml=true>
						</cfif>
					</cfif>
				<cfelseif cgi.http_user_agent contains "KHTML">
					<cfset browser="safari">
							<cfset dhtml=true>
				<cfelseif cgi.http_user_agent contains "Gecko/">
					<cfset browser="gecko">
					<cfset geckoversion=#REReplace(cgi.http_user_agent, ".*Gecko/([0-9]*).*", "\1")#>
					<cfif geckoversion gte 20030313>
					  <cfset dhtml=true>
					<cfelseif attributes.applet IS NOT "off">
						<cfset applet = true>
					</cfif>
				<cfelseif attributes.applet IS NOT "off" and not LCase(cgi.http_user_agent) contains "mozilla/4" and not LCase(cgi.http_user_agent) contains "mozilla/3" and not LCase(cgi.http_user_agent) contains "netscape6/6.0" and not LCase(cgi.http_user_agent) contains "netscape6/6.1">
					<cfset applet=true>
				</cfif>
			<cfelse>
				<cfset browser="msie">
				<!--- IS WIN IE --->
				<cfset dhtml = true>
				<cfif attributes.applet IS "always">
					<cfset dhtml = false>
					<cfset applet = true>
				<cfelseif attributes.applet IS "off">
					<cfset applet = false>
				</cfif>
			</cfif>
<cfsetting enablecfoutputonly="no">

<!--- global java script --->		
		<cfoutput>
			<script language="javascript">
				<cfif ae_num is 1>
				var ae_alloweditsource = new Array();
				var ae_fieldname = new Array();
				var ae_imagedata = new Array();
				var ae_imageurl = new Array();
				var ae_defaultfont = new Array();
				var ae_baseurl = new Array();
				var ae_breakonenter = new Array();
				var ae_xhtml = new Array();
				var ae_tabview = new Array();
				var ae_inc = '#attributes.inc#';
				var quickformatNameArray = new Array();
				var ae_stylesheet = new Array();
				var ae_quickfontcolors = new Array();
				var ae_backgroundcolor = new Array();
				var fileType = 'cfm';
				</cfif>
				
				var errlevel = 2;
				var ae_version="5.0.52";

				ae_breakonenter[#ae_num#] = <cfif attributes.breakonenter>true<cfelse>false</cfif>;
				ae_baseurl[#ae_num#] = "#attributes.baseurl#";
				ae_defaultfont[#ae_num#] = "#attributes.defaultfont#";
				ae_tabview[#ae_num#] = <cfif attributes.tabview>true<cfelse>false</cfif>;
				ae_alloweditsource[#ae_num#] = <cfif attributes.alloweditsource>true<cfelse>false</cfif>;
				ae_imagedata[#ae_num#] = '#URLEncodedFormat(Hash(ae_imagedata))#';				
				ae_imageurl[#ae_num#] = '#URLEncodedFormat(attributes.imageurl)#';
				ae_stylesheet[#ae_num#] = '#attributes.stylesheet#';
				ae_xhtml[#ae_num#] = <cfif attributes.xhtml>true<cfelse>false</cfif>;
				ae_backgroundcolor[#ae_num#] = '#attributes.backgroundcolor#';
				quickformatNameArray[#ae_num#] = new Array();
				<cfloop from="1" to="#ListLen(attributes.quickformatNames)#" index="quickformatNameIndex">
					<cfset i = quickformatNameIndex - 1>
					quickformatNameArray[#ae_num#][#i#] = "#ListGetAt(attributes.quickformatNames, quickformatNameIndex)#";
				</cfloop>
				
				
				
			</script>
		</cfoutput>
<CFIF dhtml>
	<cfoutput>
  <cfif ae_num is 1>
		<cfif NOT IsDefined("ae_trial")><script language="JavaScript" src="#attributes.inc#spellchecker/spell.js"></script></cfif>
		<script language="JavaScript" src="#attributes.inc#base.js" type="text/javascript"></script>
		<cfif dhtml><script language="javascript" src="#attributes.inc##browser#.js" type="text/javascript"></script></cfif>
		<script language="JavaScript">
			//declare global javascript variables
			if (errlevel == 2){
				//error catching
				document.write("<BR>The file editjs.cfm did not load properly. Make sure the the inc attribute is specified correctly<br>");
				document.write("Current Value: inc=" + ae_inc + "<br>");
				document.write("<comment>"); // Keeps the rest of the page from displaying
			}
		</script>
		<script language="javascript" src="#attributes.inc#user.js"></script>
<!--- style sheets --->
		<style type="text/css">
			.ae_disabled {-moz-opacity:.25;opacity:.25;width:23;height:22;margin:0px;padding:0px;vertical-align:middle;border:1px solid #attributes.buttoncolor#;visibility:visible;background-color:buttonface;}
			.ae_flat {width:23;height:22;margin:0px;padding:0px;vertical-align:middle;border:1px solid #attributes.buttoncolor#;visibility:visible;}		
			.ae_outset { width:23;height:22;margin:0px;padding:0px;vertical-align:middle;border:1px outset buttonshadow;background-color:buttonface;}
			.ae_inset {width:23;height:22;margin:0px;padding:0px;vertical-align:middle;border:1px inset buttonshadow;visibility:visible;}
			.ae_latched {width:23;height:22;margin:0px;padding:0px;vertical-align:middle;border:1px inset buttonshadow;background-color:##DDDDDD;visibility:visible;}
			.ae_spc {margin:0;padding:0;vertical-align:middle;}
			/* Don't allow the background color to be overridden by default style sheet*/
			TABLE.ae_tableClass {border:#attributes.border# #attributes.buttoncolor#;cursor:default;background-color:#attributes.buttoncolor#;}
			TR.ae_trClass {background-color:#attributes.buttoncolor#;}
			TD.ae_tdClass {background-color:#attributes.buttoncolor#;}
			.ae_menuspacer {border-top:1px inset buttonshadow;margin-top:4px;margin-bottom:4px;cursor:default;}
			.ae_menuitem {font-family:Arial,Helvetica,sans-serif;font-size:9pt;padding:4px 20px 4px 20px;cursor:default;}
			.ae_menuitem_over {font-family:Arial,Helvetica,sans-serif;font-size:9pt;padding:4px 20px 4px 20px;cursor:default;background-color:##AAAAFF}
		</style>
		<div id="ae_rightmenu" style="position:absolute;visibility:hidden;border:1px outset buttonshadow;background-color:buttonface;padding:4px;cursor:default;"></div>
		<div id="ae_popup" style="position:absolute;visibility:hidden;border:1px outset buttonshadow;background-color:##FFFFCC;padding:4px;font-family:Arial,Helvetica;font-size:10pt;"></div>
  </cfif> 
<!--- end if ae_num is 1 --->		
<!--- output object --->
		<table bgcolor="#attributes.buttoncolor#" style="padding-bottom:4px;" cellpadding="0" cellspacing="0" width="#attributes.width#" height="#attributes.height#" ondragstart="event.returnValue=false;"	onselectstart="event.returnValue=false;" class="ae_tableClass">
			<tr class="ae_trClass">	
				<td valign="bottom" colspan="2" class="ae_tdClass" width="100%">
<!---  Begin Toolbar 	--->
			<cfif browser is "msie"><cfset tb_begin="<nobr>"><cfset tb_end="</nobr>"><cfset tb_break="<wbr>"><cfset tb_rowbreak="<br/>"><cfelse><cfset tb_begin="<div style='clear:both;overflow:hidden;'><div style='float:left;height:24px;'>"><cfset tb_end="</div></div>"><cfset tb_break="</div><div style='float:left;height:24px;'>"><cfset tb_rowbreak="</div></div><div style='clear:both;overflow:hidden;'><div style='float:left;'>"></cfif>
					<cfif ae_num is 1><iframe src="#attributes.inc#blank.html" id="quicktable" style="border:none;position:absolute; visibility:hidden; width:10; height:10; z-index:2;" vspace=0 hspace=0 marginheight="0" marginwidth="0" scrolling="no"></iframe></cfif>
					<table cellspacing="2" cellpadding="0" border="0">
					<tr valign="middle">
					<td width="10" background="#attributes.inc#images/toolbar.gif"><img src="#attributes.inc#images/spacer.gif" width=9 height=24 alt=""></td>
					<td><span id="ae_tbar#ae_num#" 
						onmouseover="ae_m_over(event);"
						onmousedown="ae_m_down(event);"
						onmouseup="ae_m_up(event);"
						onmouseout="ae_m_out(event);"
						ondragstart="event.returnValue=false;"
						onselectstart="event.returnValue=false;"
						>#tb_begin#<cfloop index="btn" list=#attributes.toolbar#><cfif btn eq "|"><cfset brn=Trim(btn)><img 
							src="#attributes.inc#images/space.gif" class="ae_spc" alt="" />#tb_break#<cfelseif btn eq "||">#tb_rowbreak#<cfelseif btn eq "quickstyles"><img src="#attributes.inc#images/spacer.gif" width="1" height="24" alt="" style="vertical-align:middle;">
							<select size="1" id="oQuickStyle#ae_num#" style="width:120px;font:8pt Arial;vertical-align:middle;" onchange="ae_quickstyle(#ae_num#);" onmousedown="ae_bs_saveRange(#ae_num#);">
							<option value="none">Select Style</option>
							<cfloop from="1" to="#ListLen(attributes.quickstyles)#" index="stylename"><option value="#Trim(ListGetAt(attributes.quickstyles, stylename))#"><cfif Len(attributes.quickstyleNames)>#ListGetAt(attributes.quickstyleNames, stylename)#<cfelse>#ListGetAt(attributes.quickstyles, stylename)#</cfif></option>
							</cfloop><option value="ae_removeStyle">Remove Style</option>
							</select>
							<cfelseif Left(btn,7) eq "select_"><img src="#attributes.inc#images/spacer.gif" width="1" height="24" style="vertical-align:middle;" alt="" />
							<select size="1" id="ae_#btn#" style="width:120px;font:8pt Arial;vertical-align:middle;" onchange="ae_select_change(#ae_num#,'#btn#');" onmousedown="ae_bs_saveRange(#ae_num#);"></select>
<!--- build quickfont drop-down list --->
							<cfelseif btn eq "quickfont"><img src="#attributes.inc#images/spacer.gif" width="1" height="24" style="vertical-align:middle;" alt="" />
							<select size="1" id="oQuickFont#ae_num#" style="width:120px;font:8pt Arial;vertical-align:middle;" onchange="ae_quickfont(#ae_num#);" onmousedown="ae_bs_saveRange(#ae_num#);">
							<cfloop index="fontname" list="#attributes.quickfonts#"><option value="#fontname#">#fontname#</option>
							</cfloop>
							</select>
<!--- build quickfontcolors drop-down list --->
							<cfelseif btn eq "quickfontcolors"><img src="#attributes.inc#images/spacer.gif" width="1" height="24" style="vertical-align:middle;" alt="" />
							<select size="1" id="oQuickFontColors#ae_num#" style="width:120px;font:8pt Arial;vertical-align:middle;" onchange="ae_quickFontColor(#ae_num#);" onmousedown="ae_bs_saveRange(#ae_num#);">
							<option value="Quick Font Colors">Text Colors</option>
							<cfloop index="fontcolor" list="#attributes.quickfontcolors#"><option value="#fontcolor#">#fontcolor#</option>
							</cfloop>
							</select>
<!--- build quickformat drop-down list. Populated in editjs initialization functions --->
							<cfelseif btn eq "quickformat"><img src="#attributes.inc#images/spacer.gif" width="1" height="24" style="vertical-align:middle;" alt="" />
							<select size="1" id="oQuickFormat#ae_num#" style="width:120px;font:8pt Arial;vertical-align:middle;" onchange="ae_quickformat(#ae_num#);" onmousedown="ae_bs_saveRange(#ae_num#);">
							</select>
							<cfelseif btn eq "quickfontsize"><img src="#attributes.inc#images/spacer.gif" width="1" height="24" style="vertical-align:middle;" alt="" />
							<select size="1" id="oQuickFontSize#ae_num#" style="width:45px;font:8pt Arial;vertical-align:middle;" onchange="ae_quickfontsize(#ae_num#);" onmousedown="ae_bs_saveRange(#ae_num#);">
								<option value='8'>8</option>
								<option value='10'>10</option>
								<option value='12'>12</option>
								<option value='14'>14</option>
								<option value='18'>18</option>
								<option value='24'>24</option>
								<option value='36'>36</option>
							</select>
							<cfelseif StructKeyExists(ae_stockbtns, btn) AND Len(ae_stockbtns[btn])><img alt="#ListGetAt(ae_stockbtns[btn], 2)#" title="#ListGetAt(ae_stockbtns[btn], 2)#"
							status="#ListGetAt(ae_stockbtns[btn], 3)#"
							onmousedown="return ae_onCommand(event, '#ListGetAt(ae_stockbtns[btn], 1)#', #ae_num#);"
							src="#attributes.inc##ListGetAt(ae_stockbtns[btn], 4)#"
							tag="btn" class="ae_flat" cid="#ListGetAt(ae_stockbtns[btn], 1)#"<cfif btn eq "table">
							onDragStart="return false"
							onmouseover="ae_m_over(ae_tdrop#ae_num#);"
							onmouseout="ae_m_out(ae_tdrop#ae_num#);"
							id="ae_tbtn#ae_num#" /><img alt="Quick Table" title="Quick Table"
							onmousedown="ae_bs_saveRange(#ae_num#);"
							onclick="onTable(#ae_num#);"
							onDragStart="return false"
							onmouseover="ae_m_over(ae_tbtn#ae_num#);"
							onmouseout="ae_m_out(ae_tbtn#ae_num#);"
							name="ae_tdrop#ae_num#"
							status="Insert a table"
							src="#attributes.inc#images/tbdown.gif"
							tag="btn" class="ae_flat" style="width:9;" 
							cid="5022"</cfif> /><cfelse><cfset caption="Custom Button"><cfif IsDefined("attributes.customCaptions.#btn#")><cfset caption = attributes.customCaptions["#btn#"]></cfif> <img 
							alt="#caption#"	title="#caption#"	status="#caption#"
							onmousedown="ae_customExec('#btn#', #ae_num#)"
							src="#attributes.inc#images/custom/#btn#.gif"
							tag="btn" class="ae_flat" /></cfif></cfloop>#tb_end#</span><img src="#attributes.inc#images/spacer.gif" width=1 height=1 alt="" /></td>
					</tr>
					</table>
</cfoutput>
				</td>
				<td class="ae_tdClass">&nbsp;</td>
			</tr>
			<tr class="ae_trClass">		
				<td class="ae_tdClass">&nbsp;</td>
				<td class="ae_tdClass" width="100%" height="100%" style="padding:1px;">
<!--- output the safe for scripting dHTML editing object --->
					<cfoutput><iframe <cfif browser is "msie">src="#attributes.inc#blank.html" </cfif>style="width: 100%; height: 100%; <cfif browser is not "msie">border:1px inset buttonshadow; </cfif>background-color: ##FFFFFF;" id="ae_frame#ae_num#"></iframe></cfoutput>
<!--- initialize control --->
						<cfif Len(thisTag.generatedContent)>
							<cfset content = thisTag.GeneratedContent>
							<cfset content=HTMLEditFormat(content)>
							<cfset thisTag.generatedContent = " ">
						<cfelse>
							<cfset content = " ">
							<cfset thisTag.generatedContent = " ">
						</cfif>
				</td>
				<td class="ae_tdClass">&nbsp;</td>
			</tr>
			<tr class="ae_trClass">
				<td colspan="3" class="ae_tdClass">
					<table cellspacing=0 cellpadding=0 border=0 width="100%">
						<tr>
						<cfoutput>
							<td valign="top"><img src="#attributes.inc#images/spacer.gif" alt="" 
								width="20" height="1" /><cfif attributes.tabview><img 
								src="#attributes.inc#images/normaltabon.gif" 
								width="49" height="11" border="0" 
								alt="Visual Edit Mode" name="normaltab#ae_num#"
								onclick="ae_editsourceinline(#ae_num#, false)" /><img 
								src="#attributes.inc#images/htmltaboff.gif" 
								width="41" height="11" border="0" 
								alt="HTML Edit Mode" name="htmltab#ae_num#"
								onclick="ae_editsourceinline(#ae_num#, true)" /></cfif></td>				
							<td align="right" valign="top"><a href="javascript:ae_cmd_About()" style="text-decoration:none;color:gray;"><span style="font-family:Arial;font-size:10px;"><cfif NOT IsDefined("attributes.removecopyright")>ActivEdit 5.0 &copy; 1999-2006</cfif>&nbsp;</span></a></td>
				</cfoutput>
						</tr>					
					</table>
				</td>				
			</tr>
		</table> 
<!--- embed hidden objects continue initializing --->
<cfoutput>					
	<textarea style="position:absolute; visibility:hidden; width:0px;height:0px;" id="ae_tx_content#ae_num#" name="#attributes.name#">#content#</textarea>
	<script>ae_initialize(#ae_num#);</script>
</cfoutput>	
<!--- debugging output ---><cfif attributes.debug></cfif>
<!--- Continue displaying if editjs.cfm crashed --->
		<script>
			//</comment>
		</script>
<cfelse>
<!--- Degrade to textarea --->
	<cfif Len(thisTag.generatedContent) AND attributes.type is "form">
		<cfset content = thisTag.GeneratedContent>
		<cfset thisTag.generatedContent = " ">
	<cfelse>
		<cfset content = " ">
		<cfset thisTag.generatedContent = " ">
	</cfif>
	<cfparam name="attributes.buttoncolor" default="silver">
	<cfoutput><table border="0" cellpadding="0" cellspacing="0" bgcolor="#attributes.buttoncolor#">
	<tr>
		<td height="20"><img src="#attributes.inc#/images/space.gif" border="0" alt="" align="absmiddle" />&nbsp;<a href="javascript:alert('You are using an unsupported browser.\n You should use Internet Explorer, Firefox, or Safari to get all the functionality.')"><img src="#attributes.inc#/images/help.gif" border="0" alt="Info" align="absmiddle" /></a></td>
	</tr>
	<tr><td>

	<cfif Find("%",attributes.width)><cfset attributes.width=100></cfif>
	<cfif Find("%",attributes.height)><cfset attributes.height=100></cfif>

	<cfif NOT IsDefined("attributes.cols")>
		<CFIF IsDefined("attributes.width")>
			<cfset attributes.cols="#Fix(Evaluate(attributes.width/8))#">
		<CFELSE>
			<cfset attributes.cols=100>
		</CFIF>
	</cfif>
	<cfif NOT IsDefined("attributes.rows")>
		<CFIF IsDefined("attributes.height")>
			<cfset attributes.rows="#Fix(Evaluate(attributes.height/13))#">
		<CFELSE>
			<cfset attributes.rows=18>
		</CFIF>
	</cfif>
		<textarea name="#attributes.name#" COLS="#attributes.cols#" ROWS="#attributes.rows#">#content#</textarea>
	</td></tr>
	</table>
	</cfoutput>

</cfif><!--- end if applet/dhtml type --->
<cfoutput><!-- end cf_activedit v:5.0 (5.0.52 02/07/2007) --></cfoutput>
<cfelseif NOT thisTag.HasEndTag>
<cfoutput>
	<ul>
	<li><span style="font: 10pt Arial">Error: Missing &lt;/cf_activedit&gt; tag.</span> </li>
	</ul>
</cfoutput>
</cfif><!--- end if thisTag.executionMode = end --->

<cfsetting enablecfoutputonly="No">
