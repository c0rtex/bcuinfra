<cfcomponent>
<cffunction name="getDisplayText" output="no">
	<cfargument name="scope" type="string" default="application">
	<cfargument name="name" type="string" default="bcuDisplayPool">
	<cfargument name="code" type="string">
	<cfargument name="group" type="string" default="">
	<cfargument name="language_id" type="string" default="" >
	<cfargument name="spacebefore" type="boolean" default="false">
	<cfargument name="spaceafter" type="boolean" default="false">
	<cfargument name="suppress" type="boolean" default="false">
	<cfargument name="alt" type="string" default="">
	<cfargument name="stripAllTags" type="boolean" default="false">
	<cfargument name="stripTags" type="boolean" default="false">
	<cfargument name="expandCodes" type="boolean" default="true">
	<cfargument name="jsEscape" type="boolean" default="false">
	<cfargument name="isTargetHTML" type="boolean" default="false">
	<cfargument name="partner_id" type="numeric" default="0">
	<cfargument name="subset_id" type="numeric" default="0">
	<cfargument name="org_id" type="numeric" default="0">
	<cfargument name="source_id" type="numeric" default="0">
	<cfargument name="param1" type="string" default="">
	<cfargument name="param2" type="string" default="">
	<cfargument name="param3" type="string" default="">


	<cfset textStruct = "#scope#.#name#">
	<cfset display_id = 0>
	<cfset output = ''>
	<cfif language_id eq ''>
		<cfif IsDefined('language_id') and language_id neq ''>
	        <cfset language_id = session.language_id>
	    <cfelse>
			<cfset language_id=CreateObject("component","cf.components.cacheLanguagePoolComponent").getInstance().actionDefault()>
	    </cfif>
	<cfelse>
	</cfif>
	<cfif not IsDefined(textStruct)>
		<cfset "#textStruct#" = StructNew()>
	</cfif>
	<cfif group eq ''>
		<cfquery name="getdisplaygroup" datasource="#application.dbSrc#">
			select d.display_id, dg.displaygroup_code
			from display d, displaygroup dg
			where d.display_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#code#" maxlength="64">
				and d.displaygroup_id=dg.displaygroup_id
		</cfquery>
		<cfif getdisplaygroup.RecordCount eq 0>
			<cfif alt eq ''>
				<cfset output = "<i>bad display code <b>"" #code# ""</b> entered</i>">
			<cfelse>
				<cfset output = alt>
			</cfif>
		<cfelse>
			<cfset display_id = getdisplaygroup.display_id>
			<cfset group = getdisplaygroup.displaygroup_code>
		</cfif>
	</cfif>
	<cfif output eq ''>
		<cfif group neq ''>
			<cfif not IsDefined("#textStruct#.#group#")>
				<cfset "#textStruct#.#group#" = StructNew()>
			</cfif>
			<cfif not IsDefined("#textStruct#.#group#.#language_id#")>
				<cfset "#textStruct#.#group#.#language_id#" = StructNew()>
			</cfif>
			<cfset isCodeDefined = false>
			<cfset isBadCode = false>
			<cfif IsDefined("#textStruct#.#group#.#language_id#.#code#")>
				<cfset isCodeDefined = true>
				<cfif IsDefined("#textStruct#.#group#.#language_id#.#code#.bad")>
					<cfset isBadCode = true>
				<cfelse>
					<cfset output = Evaluate("#textStruct#.#group#.#language_id#.#code#")>
				</cfif>
			</cfif>
			<cfif not isCodeDefined or isBadCode>
				<cfif isBadCode>
					<cfset getdisplay = QueryNew('display_text')>
				<cfelseif display_id gt 0>
					<cfquery name="getdisplay" datasource="#application.dbSrc#">
						select dl.display_text
						from display_language dl, language l
						where dl.display_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#display_id#" maxlength="10">
							and dl.language_id in ('#language_id#', 'EN')
							and dl.language_id=l.language_id
							and l.active = 1
						order by l.default_flag
					</cfquery>
				<cfelse>
	 				<cfquery name="getdisplay" datasource="#application.dbSrc#">
						select dl.display_text
						from display d, display_language dl, language l
						where d.display_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#code#" maxlength="64">
							and d.display_id=dl.display_id
							and dl.language_id in ('#language_id#', 'EN')
							and dl.language_id=l.language_id
							and l.active = 1
						order by l.default_flag
					</cfquery>
				</cfif>
				<cfif getdisplay.RecordCount eq 0>
					<cfif alt eq '' and code neq 'answerfield_esi_client'>
						<cfset output = "<i>bad display code #isBadCode#<b>""#code#""</b> entered</i>">
					<cfelse>
						<cfset output = alt>
					</cfif>
					<cfif not isBadCode>
						<cfset "#textStruct#.#group#.#language_id#.#code#" = StructNew()>
						<cfset "#textStruct#.#group#.#language_id#.#code#.bad" = ''>
					</cfif>
				<cfelse>
					<cfloop query="getdisplay">
						<cfif output eq ''>
							<cfset output = display_text>
						</cfif>
					</cfloop>
					<cfset "#textStruct#.#group#.#language_id#.#code#" = output>
				</cfif>
			</cfif>

		</cfif>
	</cfif>
	<cfif expandCodes and output neq ''>
		<cfset output=this.expandTextCodes(text=output, param1=param1, param2=param2, param3=param3, partner_id=partner_id, subset_id=subset_id, org_id=org_id, source_id=source_id)>
	</cfif>
	<cfif output neq '' and (stripAllTags or stripTags)>
		<cfset commonUtils = CreateObject("component","commonUtils")>
		<cfset output=this.stripTags(text=output, all=stripAllTags)>
	</cfif>
	<cfif jsEscape>
		<cfif output eq ''>
			<cfset output = "''">
		<cfelse>
			<cfset output=this.jsEscapeString(text=output, isTargetHTML=isTargetHTML)>
		</cfif>
	</cfif>
	<cfif spacebefore and output neq ''>
		<cfset output = ' &nbsp; ' & output>
	</cfif>
	<cfif spaceafter and output neq ''>
		<cfset output = output & ' &nbsp; '>
	</cfif>
	<cfreturn output>
</cffunction>

<cffunction name="getHelpLink" output="no">
	<cfargument name="code" type="string" required="yes">
	<cfargument name="partner_id" type="numeric" default="0">
	<cfargument name="textonly" type="string" default="FALSE">

	<cfif Left(code, 5) eq 'help_'>
		<cfset code = Right(code, Len(code) - 5)>
	</cfif>

	<cfset hobj=CreateObject("component","cf.components.cacheHelpPoolComponent").getInstance().actionGet(code)>

	<cfif hobj.exists>
		<cfif partner_id eq 0>
			<cfset textonly = TRUE>
		</cfif>
		<cfreturn this.buildPopupLink(code=code, text="HELP", textonly=textonly, partner_id=partner_id)>
	</cfif>
</cffunction>

<cffunction name="buildPopupLink">
	<cfargument name="code" type="string" default="">
	<cfargument name="keyword" type="string" default="">
	<cfargument name="text" type="string" default="">
	<cfargument name="partner_id" type="numeric" default="0">
	<cfargument name="subset_id" type="numeric" default="0">
	<cfargument name="class" type="string" default="">
	<cfargument name="style" type="string" default="">
	<cfargument name="var" type="string" default="">
	<cfargument name="error_var" type="string" default="">
	<cfargument name="image" default="">
	<cfargument name="textonly" default="FALSE">

	<cfif IsDefined('partner_id') AND (partner_id EQ 0 OR partner_id EQ 77)>
		<cfif Not IsDefined ("session.esiDefCt")>
			<cfset session.esiDefCt = 0>
	     </cfif>
		<cfif not IsDefined('request.popupPool')>
			<cfset request.popupPool = StructNew()>
		</cfif>

		<cfset outstr = ''>
		<cfset errorCode = 0>

		<cfif code eq '' and keyword eq ''>
			<cfset errorCode = 1>
		<cfelse>
			<cfif code eq ''>
				<cfset code=CreateObject("component","cf.components.cacheHelpPoolComponent").getInstance().actionGetCodeByKeyword(keyword)>
			</cfif>
			<cfif code eq ''>
				<cfset errorCode = 2>
			<cfelse>
				<cfif text eq ''>
					<cfset text = keyword>
				</cfif>
				<cfset hobj=CreateObject("component","cf.components.cacheHelpPoolComponent").getInstance().actionGet(code)>

				<cfif not hobj.exists>
					<cfset errorCode = 2>
				<cfelse>
					<cfif StructKeyExists(request.popupPool, "help#hobj.id#") AND partner_id NEQ 77>
						<cfset popupLinkCount = StructFind(request.popupPool, "help#hobj.id#")>
						<cfset popupLinkIDSuffix = "_#popupLinkCount#">
						<cfset includeFunction = false>
						<cfset StructUpdate(request.popupPool, "help#hobj.id#", popupLinkCount + 1)>
	                <cfelse>
	                	<cfset popupLinkIDSuffix = ''>
	                    <cfset includeFunction = true>
	                    <cfif partner_id eq 77 OR partner_id eq 0>
	                    	<cfset session.esiDefCt = session.esiDefCt + 1>
	                    	<cfset StructInsert(request.popupPool, "help#hobj.id#_#session.esiDefCt#", 1)>
	                    <cfelse>
							<cfset StructInsert(request.popupPool, "help#hobj.id#", 1)>
	                    </cfif>
					</cfif>
					<cfif hobj.title eq ''>
						<cfset popTextQS = ''>
					<cfelse>
						<cfset popTextQS = "titlegroup=helptitle&titlecode=#hobj.title#&">
					</cfif>
					<cfif includeFunction>
						<cfif hobj.title eq ''>
							<cfset titleStr = "''">
						<cfelse>
							<cfif textonly>
								<cfset titleStr=this.getDisplayText(group="helptitle", code=text, jsEscape=false, isTargetHTML=true)>
							<cfelse>
								<cfif text neq ''>
									<cfset titleStr=this.getDisplayText(group="helptitle", code=hobj.title, jsEscape=true, isTargetHTML=true)>
	                            <cfelse>
									<cfset titleStr=this.getDisplayText(group="helptitle", code=keyword, jsEscape=true, isTargetHTML=true)>
	                            </cfif>
							</cfif>
						</cfif>

						<cfset textStr=this.getDisplayText(group="help", code=hobj.text, jsEscape=false, isTargetHTML=false)>

						<cfif text eq ''>
							<cfif titleStr neq "''">
								<cfset text = Mid(titleStr, 2, Len(text) - 2)>
							<cfelse>
								<cfset errorCode = 3>
							</cfif>
						</cfif>
					</cfif>
					<cfif style neq ''>
						<cfset style = " style=""#attributes.style#""">
					</cfif>
					<cfif class neq ''>
						<cfset class = " class=""#attributes.class#""">
					</cfif>
					<cfif not errorCode>
		            	<cfif image NEQ "">
		                	<cfset helpImg = this.getDisplayImage(code=image, border="0", alt=text)>
							<cfset outstr = "<a href=""javascript:help('popText.cfm?#popTextQS#group=help&code=#hobj.text#');"" id=""popupLink#hobj.id##popupLinkIDSuffix#""#style##class#>#helpImg#</a><script language=""JavaScript"">">
		                <cfelse>
		                	<cfif hobj.text EQ 'help_def_extrahelp'>
								<cfset outstr = '<script>$(function() { $("##show_extra_help_def").click(function() { $("##extra_help_def").toggle(); return false; }); $("##extra_help_def").click(function() { $("##extra_help_def").toggle();$(".questionHolder").removeClass("questionHighlight"); return false; }); });</script><a class="helpTrigger" id="show_extra_help_def" href="javascript:void(0);" style="font-size:14px; clear:right;">Extra Help</a><div style="display: none;" id="extra_help_def" class="helpTip" style="text-align:left;"><h2>Extra Help</h2>People with Medicare who have limited incomes and resources will be eligible to receive Extra Help through the Medicare Prescription Drug Coverage which will cover between 85 percent and 100 percent of prescription drug costs.</div>'>
	                        <cfelse>
	                        	<cfset outstr = "<a href=""javascript:help('popText.cfm?#popTextQS#group=help&code=#hobj.text#');"" id=""popupLink#hobj.id##popupLinkIDSuffix#""#style##class#>#text#</a>">
	                        </cfif>
						</cfif>
						<cfif includeFunction>
							<cfif Len(titleStr)>
								<cfset titleStr = Left(titleStr,Len(titleStr)-1)>
								<cfset titleStr = RemoveChars(titleStr, 1, 1)>
							</cfif>
							<cfset textStr = ReReplace(textStr, "'", "&rsquo;")>
	                        <cfif text NEQ ''>
								<cfset keywordStr = text>
	                        </cfif>

	                       	<cfif subset_id EQ 0 AND (CGI.SCRIPT_NAME IS '/cf/frmincomegrid.cfm' or CGI.SCRIPT_NAME IS '/cf/frmassetgrid.cfm')>
	                        	<cfif code IS 'def_assets' OR code IS 'def_gross_income' OR code IS 'def_household'>
	                            	<cfset outstr = '<a class="helpTrigger" href="javascript:void(0);">'& keywordStr &'<div style="display: none;" class="helpTip"><h2>'& titleStr &'</h2>' & textStr & '</div></a>'>
	                            <cfelse>
									<cfset titleStr = Replace(titleStr, "\'", "'", 'ALL')>
									<cfset textStr = Replace(textStr, "\'", "'", 'ALL')>

	                            	<cfset outstr = '<a class="helpTrigger" href="javascript:void(0);">'& keywordStr &'<div style="display: none;margin-top:250px;" class="helpTip"><h2 style="margin:20px 0 0;">'& titleStr &'</h2>' & textStr & '</div></a>'>
	                            </cfif>
	                        <cfelseif partner_id EQ 77 AND subset_id EQ 63 AND CGI.SCRIPT_NAME IS '/cf/esi_questions.cfm' AND (code IS 'def_tanf' OR code IS 'def_cash_assist' OR code IS 'def_other_nw' OR code IS 'def_cash' OR code IS 'def_auto1' OR code IS 'def_auto2' OR code IS 'def_retirement_accounts' OR code IS 'def_stocks' OR code IS 'def_revocable' OR code IS 'def_irrevocable' OR code IS 'def_other_a')>
	                        	<cfset outstr = '<a class="helpTrigger" href="javascript:void(0);">'& keywordStr &'<div style="display: none;margin-top:200px;" class="helpTip"><h2 style="margin:20px 0 0;">'& titleStr &'</h2>' & textStr & '</div></a>'>
	                        <cfelse>
								<cfset outstr = '<a class="helpTrigger" href="javascript:void(0);">'& keywordStr &'<div style="display: none;" class="helpTip"><h2>'& titleStr &'</h2>' & textStr & '</div></a>'>
	                        </cfif>
						</cfif>
						<cfif textonly>
							<cfif IsDefined('textStr') AND Len(textStr)>
								<cfset outstr = '<a class="helpTrigger helpButton" href="javascript:void(0);">HELP<div style="display: none;" class="helpTip"><h2>Help</h2>' & textStr & '</div></a>'>
							<cfelse>
								<cfset outstr = ''>
							</cfif>
						</cfif>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
		<cfif outstr eq ''>
			<cfset outstr = text>
		</cfif>
	<cfelse>
		<cfif not IsDefined('request.popupPool')>
			<cfset request.popupPool = StructNew()>
		</cfif>

		<cfset outstr = ''>
		<cfset errorCode = 0>

		<cfif code eq '' and keyword eq ''>
			<cfset errorCode = 1>
		<cfelse>
			<cfif code eq ''>
				<cfset code=CreateObject("component","cf.components.cacheHelpPoolComponent").getInstance().actionGetCodeByKeyword(keyword)>
			</cfif>
			<cfif code eq ''>
				<cfset errorCode = 2>
			<cfelse>
				<cfif text eq ''>
					<cfset text = keyword>
				</cfif>
				<cfset hobj=CreateObject("component","cf.components.cacheHelpPoolComponent").getInstance().actionGet(code)>
				<cfif not hobj.exists>
					<cfset errorCode = 2>
				<cfelse>
					<cfif StructKeyExists(request.popupPool, "help#hobj.id#")>
						<cfset popupLinkCount = StructFind(request.popupPool, "help#hobj.id#")>
						<cfset popupLinkIDSuffix = "_#popupLinkCount#">
						<cfset includeFunction = false>
						<cfset StructUpdate(request.popupPool, "help#hobj.id#", popupLinkCount + 1)>
					<cfelse>
						<cfset popupLinkIDSuffix = ''>
						<cfset includeFunction = true>
						<cfset StructInsert(request.popupPool, "help#hobj.id#", 1)>
					</cfif>
					<cfif hobj.title eq ''>
						<cfset popTextQS = ''>
					<cfelse>
						<cfset popTextQS = "titlegroup=helptitle&titlecode=#hobj.title#&">
					</cfif>
					<cfif includeFunction>
						<cfif hobj.title eq ''>
							<cfset titleStr = "''">
						<cfelse>
							<cfset titleStr=this.getDisplayText(group="helptitle", code=hobj.title, jsEscape=true, isTargetHTML=true)>
						</cfif>
							<cfset textStr=this.getDisplayText(group="help", code=hobj.text, jsEscape=true, isTargetHTML=true)>
						<cfif attributes.text eq ''>
							<cfif titleStr neq "''">
								<cfset text = Mid(titleStr, 2, Len(text) - 2)>
							<cfelse>
								<cfset errorCode = 3>
							</cfif>
						</cfif>
					</cfif>
					<cfif style neq ''>
						<cfset style = " style=""#style#""">
					</cfif>
					<cfif class neq ''>
						<cfset class = " class=""#class#""">
					</cfif>
					<cfif not errorCode>
		            	<cfif image NEQ "">
			            	<cfset helpImage = this.getDisplayImage(code=image, border="0", alt=text)>
							<cfset outstr = "<a href=""javascript:help('popText.cfm?#popTextQS#group=help&code=#hobj.text#');"" id=""popupLink#hobj.id##popupLinkIDSuffix#""#style##class#>#helpImg#</a><script language=""JavaScript"">">
		                <cfelse>
							<cfset outstr = "<a href=""javascript:help('popText.cfm?#popTextQS#group=help&code=#hobj.text#');"" id=""popupLink#hobj.id##popupLinkIDSuffix#""#style##class#>#text#</a><script language=""JavaScript"">">
						</cfif>
						<cfif includeFunction>
							<cfset outstr = outstr & "function showPopup#hobj.id#(e) {showPopup(e, #titleStr#, #textStr#);} ">
						</cfif>
						<cfset outstr = outstr & "addEvent(document.getElementById('popupLink#hobj.id##popupLinkIDSuffix#'), 'click', showPopup#hobj.id#, false);</script>">
					</cfif>
				</cfif>
			</cfif>
		</cfif>
		<cfif outstr eq ''>
			<cfset outstr = text>
		</cfif>
	</cfif>

	<cfset outVal=StructNew()>
	<cfset outVal["text"]=outstr>
	<cfset outVal["errorCode"]=errorCode>

	<cfreturn outVal>

</cffunction>

<cffunction name="jsEscapeString" output="no">
	<cfargument name="text" type="string">
	<cfargument name="quote" type="boolean" default="true">
	<cfargument name="isTargetHTML" type="boolean" default="false">

	<cfset outStr = text>
	<cfif outStr neq ''>
		<cfset outStr = Replace(outStr, "'", "\'", 'ALL')>
		<cfset outStr = Replace(outStr, '"', "'+String.fromCharCode(34)+'", 'ALL')>
		<cfset outStr = Replace(outStr, chr(13) & chr(10), "\n", 'ALL')>
		<cfset outStr = Replace(outStr, chr(10), "\n", 'ALL')>
		<cfset outStr = Replace(outStr, chr(13), "\n", 'ALL')>
		<cfif isTargetHTML>
			<cfset outStr = Replace(outStr, '<br />\n', '<br />', 'ALL')>
			<cfset outStr = Replace(outStr, '<br>\n', '<br />', 'ALL')>
			<cfset outStr = Replace(outStr, '\n', '<br />', 'ALL')>
			<cfset outStr = Replace(outStr, '<', "'+String.fromCharCode(60)+'", 'ALL')>
			<cfset outStr = Replace(outStr, '>', "'+String.fromCharCode(62)+'", 'ALL')>
		<cfelse>
			<cfset saveStr = ''>
			<cfset placeMarker = '<thisiswheretheLFgoes>'>
			<cfloop condition="saveStr neq outStr">
				<cfset saveStr = outStr>
				<cfset chunkStruct = REFindNoCase("<br[^/>]*/?>((#placeMarker#)*)\\n", outStr, 1, true)>
				<cfif chunkStruct.pos[1]>
					<cfif chunkStruct.len[2]>
						<cfset chunk = Mid(outStr, chunkStruct.pos[2], chunkStruct.len[2])>
					<cfelse>
						<cfset chunk = ''>
					</cfif>
					<cfif chunkStruct.pos[1] eq 1>
						<cfset leftChunk = ''>
					<cfelse>
						<cfset leftChunk = Left(outStr, chunkStruct.pos[1] - 1)>
					</cfif>
					<cfif Len(outStr) eq chunkStruct.pos[1] + chunkStruct.len[1] - 1>
						<cfset rightChunk = ''>
					<cfelse>
						<cfset rightChunk = Right(outStr, Len(outStr) - chunkStruct.pos[1] - chunkStruct.len[1] + 1)>
					</cfif>
					<cfset outStr = leftChunk & chunk & placeMarker & rightChunk>
				</cfif>
			</cfloop>
			<cfset outStr = Replace(outStr, placeMarker, "\n", 'ALL')>
			<cfset outStr = REReplaceNoCase(outStr, "<br[^/>]*/?>", "\n", 'ALL')>
		</cfif>
		<cfset outStr = REReplace(outStr, "\+(''\+)+", '+', 'ALL')>
	</cfif>
	<cfif quote>
		<cfset outStr = "'" & outStr & "'">
		<cfset outStr = REReplace(outStr, "^''\+", '')>
		<cfset outStr = REReplace(outStr, "\+''$", '')>
	</cfif>

	<cfreturn outStr>
</cffunction>

<cffunction name="getDisplayImage">
	<cfargument name="code" type="string">
	<cfargument name="alt" type="string" default="">
	<cfargument name="width" type="string" default="">
	<cfargument name="height" type="string" default="">
	<cfargument name="border" type="string" default="">
	<cfargument name="align" type="string" default="">
	<cfargument name="hspace" type="string" default="">
	<cfargument name="vspace" type="string" default="">
	<cfargument name="ismap" type="string" default="">
	<cfargument name="usemap" type="string" default="">
	<cfargument name="longdesc" type="string" default="">
	<cfargument name="id" type="string" default="">
	<cfargument name="class" type="string" default="">
	<cfargument name="title" type="string" default="">
	<cfargument name="style" type="string" default="">
	<cfargument name="lang" type="string" default="">
	<cfargument name="onclick" type="string" default="">
	<cfargument name="ondblclick" type="string" default="">
	<cfargument name="onmousedown" type="string" default="">
	<cfargument name="onmouseup" type="string" default="">
	<cfargument name="onmouseover" type="string" default="">
	<cfargument name="onmousemove" type="string" default="">
	<cfargument name="onmouseout" type="string" default="">
	<cfargument name="onkeypress" type="string" default="">
	<cfargument name="onkeydown" type="string" default="">
	<cfargument name="onkeyup" type="string" default="">
	<cfset outstr = ''>
	<cfset iobj=CreateObject("component","cf.components.cacheImagePoolComponent").getInstance().actionGet(code)>
	<cfif not IsStruct(iobj)>
		<cfset outstr = '<span style="font-weight: bold; color: ##800;">X</span>'>
	<cfelse>
		<cfset outstr = '<img '>

			<cfif parameterExists(session.transferTypeCanonicalOverride)>
				<cfset urlType = session.transferTypeCanonicalOverride>
			<cfelse>
				<cfset urlType = application.transferType>
			</cfif>

		<cfif Left(iobj.file, 1) EQ "/">
	     	<cfset iobj.file = ReReplaceNoCase(iobj.file,"/","","ONE")>
	    </cfif>

		<cfset outstr = outstr & "src=""#iobj.file#"" ">
		<cfif alt eq ''>
			<cfset diAltText = this.getDisplayText(group="imgalt", code="imgalt_#code#", alt="{{!!nada!!}}", title="{{!!nada!!}}")>
			<cfif diAltText neq '{{!!nada!!}}'>
				<cfset outstr = outstr & "alt=""#HTMLEditFormat(diAltText)#"" title=""#HTMLEditFormat(diAltText)#"" ">
			<cfelse>
				<cfset outstr = outstr & "alt="""" ">
			</cfif>
		<cfelse>
			<cfset outstr = outstr & "alt=""#HTMLEditFormat(alt)#"" title=""#HTMLEditFormat(alt)#"" ">
		</cfif>
		<cfif width eq ''>
			<cfif iobj.w neq ''>
				<cfset outstr = outstr & "width=""#iobj.w#"" ">
			</cfif>
		<cfelse>
			<cfset outstr = outstr & "width=""#width#"" ">
		</cfif>
		<cfif height eq ''>
			<cfif iobj.h neq ''>
				<cfset outstr = outstr & "height=""#iobj.h#"" ">
			</cfif>
		<cfelse>
			<cfset outstr = outstr & "height=""#height#"" ">
		</cfif>
		<cfif border neq ''>
			<cfset outstr = outstr & "border=""#border#"" ">
		</cfif>
		<cfif align neq ''>
			<cfset outstr = outstr & "align=""#align#"" ">
		</cfif>
		<cfif hspace neq ''>
			<cfset outstr = outstr & "hspace=""#hspace#"" ">
		</cfif>
		<cfif vspace neq ''>
			<cfset outstr = outstr & "vspace=""#vspace#"" ">
		</cfif>
		<cfif ismap neq ''>
			<cfset outstr = outstr & "ismap=""#ismap#"" ">
		</cfif>
		<cfif usemap neq ''>
			<cfset outstr = outstr & "usemap=""#usemap#"" ">
		</cfif>
		<cfif longdesc neq ''>
			<cfset outstr = outstr & "longdesc=""#longdesc#"" ">
		</cfif>
		<cfif id neq ''>
			<cfset outstr = outstr & "id=""#id#"" ">
		</cfif>
		<cfif class neq ''>
			<cfset outstr = outstr & "class=""#class#"" ">
		</cfif>
		<cfif title neq ''>
			<cfset outstr = outstr & "title=""#title#"" ">
		</cfif>
		<cfif style neq ''>
			<cfset outstr = outstr & "style=""#style#"" ">
		</cfif>
		<cfif lang neq ''>
			<cfset outstr = outstr & "lang=""#lang#"" ">
		</cfif>
		<cfif onclick neq ''>
			<cfset outstr = outstr & "onclick=""#onclick#"" ">
		</cfif>
		<cfif ondblclick neq ''>
			<cfset outstr = outstr & "ondblclick=""#ondblclick#"" ">
		</cfif>
		<cfif onmousedown neq ''>
			<cfset outstr = outstr & "onmousedown=""#onmousedown#"" ">
		</cfif>
		<cfif onmouseup neq ''>
			<cfset outstr = outstr & "onmouseup=""#onmouseup#"" ">
		</cfif>
		<cfif onmouseover neq ''>
			<cfset outstr = outstr & "onmouseover=""#onmouseover#"" ">
		</cfif>
		<cfif onmousemove neq ''>
			<cfset outstr = outstr & "onmousemove=""#onmousemove#"" ">
		</cfif>
		<cfif onmouseout neq ''>
			<cfset outstr = outstr & "onmouseout=""#onmouseout#"" ">
		</cfif>
		<cfif onkeypress neq ''>
			<cfset outstr = outstr & "onkeypress=""#onkeypress#"" ">
		</cfif>
		<cfif onkeydown neq ''>
			<cfset outstr = outstr & "onkeydown=""#onkeydown#"" ">
		</cfif>
		<cfif onkeyup neq ''>
			<cfset outstr = outstr & "onkeyup=""#onkeyup#"" ">
		</cfif>
		<cfset outstr = outstr & '/>'>
	</cfif>
	<cfreturn outstr>
</cffunction>

<cffunction name="expandTextCodes">
	<cfargument name="text" type="string">
	<cfargument name="param1" type="string" default="">
	<cfargument name="param2" type="string" default="">
	<cfargument name="param3" type="string" default="">
	<cfargument name="partner_id" type="numeric" default="0">
	<cfargument name="subset_id" type="numeric" default="0">
	<cfargument name="org_id" type="numeric" default="0">
	<cfargument name="source_id" type="numeric" default="0">

	<cfset outstr = text>
	<cfset hasCode = false>
	<cfset getCodeOpen = Find('[[', outstr)>
	<cfif getCodeOpen>
		<cfset getCodeClose = Find(']]', outstr, getCodeOpen + 2)>
		<cfif getCodeClose>
			<cfset hasCode = true>
			<cfset getCode = Mid(outstr, getCodeOpen + 2, getCodeClose - getCodeOpen - 2)>
		</cfif>
	</cfif>
	<cfloop condition="hasCode">
		<cfset commandParams = ListLen(getCode, '|')>
		<cfset commandCode = ListGetAt(getCode, 1, '|')>
		<cfswitch expression="#commandCode#">
			<cfcase value="bcu">
				<cfset expandedText = 'BenefitsCheckUp'>
				<cfif IsDefined('partner_id')>
					<cfset pobj=CreateObject("component","cf.components.cachePartnerPoolComponent").getInstance().actionGet(partner_id)>
					<cfif IsDefined('pobj.bcu') and pobj.bcu neq ''>
						<cfset bcuSiteName=this.getDisplayText(group="partnersite", code=pobj.bcu, alt="(zyx987NULL789xyz)")>
						<cfif bcuSiteName neq '(zyx987NULL789xyz)' and bcuSiteName neq ''>
							<cfset expandedText = bcuSiteName>
						</cfif>
					</cfif>
				</cfif>
			</cfcase>
			<cfcase value="count">
				<cfif commandParams gt 1>
					<cfset cmdType = ListGetAt(getCode, 2, '|')>
				<cfelse>
					<cfset cmdType = 'program'>
				</cfif>
				<cfif cmdType eq 'program'>
					<cfset cmdSpec = 'active'>
					<cfset cmdRoundDownTo = ''>
					<cfset cmdSubsetID = ''>
					<cfif commandParams gt 2>
						<cfset cmdSpec = ListGetAt(getCode, 3, '|')>
						<cfif commandParams gt 3>
							<cfset cmdRoundDownTo = ListGetAt(getCode, 4, '|')>
							<cfif cmdRoundDownTo eq 0>
								<cfset cmdRoundDownTo = ''>
							</cfif>
							<cfif commandParams gt 4>
								<cfset cmdSubsetID = ListGetAt(getCode, 5, '|')>
							</cfif>
						</cfif>
					</cfif>
					<cfif cmdSubsetID neq '' and IsNumeric(cmdSubsetID)>
						<cfinvoke component="#this#" method="populateTableFromView">
							<cfinvokeargument name="table" value="subset_program_base">
							<cfinvokeargument name="subset_id" value=cmdSubsetID>
						</cfinvoke>
						<cfquery name="prgcount" datasource="#application.dbSrc#">
							select count(*) as c
							from subset_program_base sp, tbl_prg_all p
							where sp.subset_id=#cmdSubsetID#
								and sp.program_id=p.RecID
								and <cfif cmdSpec eq 'active'>(p.inactive_flag is null or p.inactive_flag=0)<cfelseif cmdSpec eq 'inactive'>p.inactive_flag=1</cfif>
						</cfquery>
						<cfset outVal = prgcount.c>
					<cfelse>
						<cfquery name="prgcount" datasource="#application.dbSrc#">
							select count(*) as c
							from tbl_prg_all
							<cfif cmdSpec eq 'active'>where inactive_flag is null or inactive_flag=0<cfelseif cmdSpec eq 'inactive'>where inactive_flag=1</cfif>
						</cfquery>
						<cfset outVal = prgcount.c>
					</cfif>
					<cfset commonUtils = CreateObject("component","commonUtils")>
					<cfif cmdRoundDownTo neq ''>
						<cfset outVal=commonUtils.integerRoundOver(num=outVal, scale=cmdRoundDownTo)>
					</cfif>
					<cfset expandedText=commonUtils.integerSeparate(outVal)>
				<cfelse>
					<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (count): count type ""#cmdType#"" is not known]</span>">
				</cfif>
			</cfcase>
			<cfcase value="def">
				<cfif commandParams eq 1>
					<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (def): no term was specified]</span>">
				<cfelse>
					<cfif commandParams gt 2>
						<cfset defText = ListGetAt(getCode, 3, '|')>
					<cfelse>
						<cfset defText = ''>
					</cfif>
					<cfset defKeyword = ListGetAt(getCode, 2, '|')>
					<cfset popupLinkStruct=this.buildPopupLink(keyword=defKeyword, text=defText)>
					<cfset expandedText=popupLinkStruct.text>
					<cfset defError=popupLinkStruct.errorCode>
					<cfswitch expression="#defError#">
						<cfcase value="2">
							<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (def): definition for ""#defKeyword#"" not found]</span>">
						</cfcase>
						<cfcase value="3">
							<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (def): no link text could be determined]</span>">
						</cfcase>
					</cfswitch>
				</cfif>
			</cfcase>
			<cfcase value="eval">
				<cfif commandParams eq 1>
					<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (eval): no variable name was specified]</span>">
				<cfelse>
					<cfset expandedText = Evaluate("#Trim(ListGetAt(getCode, 2, '|'))#")>
				</cfif>
			</cfcase>
			<cfcase value="if">
				<cfif commandParams eq 1>
					<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (if): no ""then"" element was specified]</span>">
				<cfelse>
					<cfset conditionBoolean = Evaluate("#ListGetAt(getCode, 2, '|')#")>
					<cfif Not IsBoolean(conditionBoolean)>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (if): conditional parameter does not evaluate to a boolean value]</span>">
					<cfelseif conditionBoolean>
						<cfset expandedText = ListGetAt(getCode, 3, '|')>
					<cfelseif commandParams gt 3>
						<cfset expandedText = ListGetAt(getCode, 4, '|')>
					<cfelse>
						<cfset expandedText = ''>
					</cfif>
				</cfif>
			</cfcase>
			<cfcase value="number">
				<cfif commandParams eq 1>
					<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (number): no variable name was specified]</span>">
				<cfelse>
					<cfset expandNumber = Evaluate("#Trim(ListGetAt(getCode, 2, '|'))#")>
					<cfif not IsNumeric(expandNumber)>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (number): '#expandNumber#' is not a numeric value]</span>">
					<cfelse>
						<cfset expandedText=this.getDisplayText(group="number", code="number_#expandNumber#", alt=expandNumber)>
					</cfif>
				</cfif>
			</cfcase>
			<cfcase value="pass">
				<cfif commandParams eq 1>
					<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (pass): no URL was specified]</span>">
				<cfelseif commandParams eq 2>
					<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (pass): no link text was specified]</span>">
				<cfelse>
					<cfset commandProbe = 4>
					<cfif IsDefined('partner_id')>
						<cfset command_partner_id = partner_id>
					<cfelse>
						<cfset command_partner_id = 0>
					</cfif>
					<cfif IsDefined('subset_id')>
						<cfset command_subset_id = subset_id>
					<cfelse>
						<cfset command_subset_id = 0>
					</cfif>
					<cfif IsDefined('org_id')>
						<cfset command_org_id = org_id>
					<cfelse>
						<cfset command_org_id = 0>
					</cfif>
					<cfif IsDefined('source_id')>
						<cfset command_source_id = source_id>
					<cfelse>
						<cfset command_source_id = 0>
					</cfif>
					<cfset command_extralist = ''>
					<cfloop condition="commandParams gt commandProbe">
						<cfset "command_#ListGetAt(getCode, commandProbe, '|')#" = Evaluate(DE(ListGetAt(getCode, commandProbe + 1, '|')))>
						<cfset commandProbe = commandProbe + 2>
					</cfloop>
					<!---<cf_sessionPassVars href="#Trim(ListGetAt(getCode, 2, '|'))#" partner_id="#command_partner_id#" subset_id="#command_subset_id#" org_id="#command_org_id#" source_id="#command_source_id#" extralist="#command_extralist#" var="expandedText"><cfoutput>#Trim(ListGetAt(getCode, 3, '|'))#</cfoutput></cf_sessionPassVars>--->
				</cfif>
			</cfcase>
	        <!--		SE - Added this case statement to temporarily address bug 3624	-->
	        <cfcase value="home">
					<cfset commandProbe = 4>
					<cfif IsDefined('partner_id')>
						<cfset command_partner_id = partner_id>
					<cfelse>
						<cfset command_partner_id = 0>
					</cfif>
					<cfif IsDefined('subset_id')>
						<cfset command_subset_id = subset_id>
					<cfelse>
						<cfset command_subset_id = 0>
					</cfif>
					<cfif IsDefined('org_id')>
						<cfset command_org_id = org_id>
					<cfelse>
						<cfset command_org_id = 0>
					</cfif>
					<cfif IsDefined('source_id')>
						<cfset command_source_id = source_id>
					<cfelse>
						<cfset command_source_id = 0>
					</cfif>
					<cfset command_extralist = ''>
					<cfloop condition="commandParams gt commandProbe">
						<cfset "command_#ListGetAt(getCode, commandProbe, '|')#" = Evaluate(DE(ListGetAt(getCode, commandProbe + 1, '|')))>
						<cfset commandProbe = commandProbe + 2>
					</cfloop>
					<cfswitch expression="#application.serverPath#">
						<cfcase value="ssl1.benefitscheckup.org,ssl2.benefitscheckup.org,ssl3.benefitscheckup.org,ssl4.benefitscheckup.org">
							<cfset printedServer = 'www.benefitscheckup.org'>
						</cfcase>
						<cfdefaultcase>
							<cfset printedServer = application.serverPath>
						</cfdefaultcase>
					</cfswitch>
					<cfset expandedText = "<a href='#application.transfertype#://#printedServer#/index.cfm?partner_id=#command_partner_id#'>here</a>">
			</cfcase>
			<cfcase value="plural">
	<cfif param1 eq ''>
		<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (plural): no number was specified]</span>">
	<cfelseif not IsNumeric(param1)>
		<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (plural): '#param1#' is not a number]</span>">
	<cfelseif commandParams eq 1>
		<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (plural): no noun was specified]</span>">
	<cfelse>
		<cfif commandParams gt 2>
			<cfset pluralPluralNoun = Trim(ListGetAt(getCode, 3, '|'))>
		<cfelse>
			<cfset pluralPluralNoun = ''>
		</cfif>
		<cfset pluralSingularNoun = Trim(ListGetAt(getCode, 2, '|'))>
		<cfset pluralNumber=this.getDisplayText(group="number", code="number_#param1#", alt=param1)>
		<cfif param1 neq 1>
			<cfif pluralPluralNoun neq ''>
				<cfset expandedText = "#pluralNumber# #pluralPluralNoun#">
			<cfelse>
				<cfset expandedText = "#pluralNumber# #pluralSingularNoun#s">
			</cfif>
		<cfelse>
			<cfset expandedText = "#pluralNumber# #pluralSingularNoun#">
		</cfif>
	</cfif>
			</cfcase>
			<cfcase value="printed">
				<cfif commandParams gt 1 and ListGetAt(getCode, 2, '|') eq 'url'>
					<cfif IsDefined('partner_id')>
						<cfset command_partner_id = partner_id>
					<cfelse>
						<cfset command_partner_id = 0>
					</cfif>
					<cfif IsDefined('subset_id')>
						<cfset command_subset_id = subset_id>
					<cfelse>
						<cfset command_subset_id = 0>
					</cfif>
					<cfswitch expression="#application.serverPath#">
						<cfcase value="ssl1.benefitscheckup.org,ssl2.benefitscheckup.org,ssl3.benefitscheckup.org,ssl4.benefitscheckup.org">
							<cfset printedServer = 'www.benefitscheckup.org'>
						</cfcase>
						<cfdefaultcase>
							<cfset printedServer = application.serverPath>
						</cfdefaultcase>
					</cfswitch>
					<cfset expandedText = "http://#printedServer#/link/#command_partner_id#/#command_subset_id#">
				<cfelse>
					<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (printed): no mode was specified]</span>">
				</cfif>
			</cfcase>
			<cfcase value="state">
				<cfset expandedText = ''>
				<cfset stateID = ''>
				<cfif commandParams gt 1>
					<cfif commandParams gt 2>
						<cfset stateID = Evaluate(DE(ListGetAt(getCode, 3, '|')))>
					</cfif>
					<cfif stateID eq '' and IsDefined('state_id')>
						<cfset stateID = state_id>
					</cfif>
					<cfif stateID neq ''>
						<cfif (ListGetAt(getCode, 2, '|') eq 'abbrev' or ListGetAt(getCode, 2, '|') eq 'id')>
							<cfset expandedText = stateID>
						<cfelseif ListGetAt(getCode, 2, '|') eq 'name'>
							<cfset stobj=CreateObject("component","cf.components.cacheStatePoolComponent").getInstance().actionGet(stateID)>
							<cfset expandedText = stobj.name>
						</cfif>
					</cfif>
				<cfelse>
					<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (state): no mode was specified]</span>">
				</cfif>
				<cfif expandedText eq ''>
					<cfif stateID eq ''>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (state): state_id is blank]</span>">
					<cfelse>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (state): unknown state_id '#stateID#']</span>">
					</cfif>
				</cfif>
			</cfcase>
			<cfcase value="subset">
				<cfif commandParams gt 1 and ListGetAt(getCode, 2, '|') eq 'name'>
					<cfif IsDefined('subset_id') and subset_id neq ''>
						<cfquery name="expandSubset" datasource="#application.dbSrc#">
							select subset_name, qaire_name
							from xsubset
							where subset_id=#subset_id#
						</cfquery>
						<cfif expandSubset.RecordCount eq 0>
							<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (subset): no subset data was found]</span>">
						<cfelse>
							<cfif expandSubset.qaire_name eq ''>
								<cfset expandedText = expandSubset.subset_name>
							<cfelse>
								<cfset expandedText = expandSubset.qaire_name>
							</cfif>
						</cfif>
					<cfelse>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (subset): no subset_id is set]</span>">
					</cfif>
				<cfelse>
					<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (state): no mode was specified]</span>">
				</cfif>
			</cfcase>
			<cfcase value="track">
				<cfif commandParams eq 1>
					<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (track): no URL code was specified]</span>">
				<cfelse>
					<cfif commandParams gt 4>
						<cfset trackOnClick = Trim(ListGetAt(getCode, 5, '|'))>
					<cfelse>
						<cfset trackOnClick = ''>
					</cfif>
					<cfif commandParams gt 3>
						<cfset trackTarget = Trim(ListGetAt(getCode, 4, '|'))>
					<cfelse>
						<cfset trackTarget = ''>
					</cfif>
					<cfif commandParams gt 2>
						<cfset trackText = Trim(ListGetAt(getCode, 3, '|'))>
					<cfelse>
						<cfset trackText = ''>
					</cfif>
					<cfset trackCode = ListGetAt(getCode, 2, '|')>
					<cf_buildRedirectURL code="#trackCode#" text="#trackText#" target="#trackTarget#" onClick="#trackOnClick#" var="expandedText">
				</cfif>
			</cfcase>
			<cfcase value="year">
				<cfset expandedText = Year(Now())>
				<cfif commandParams gt 1>
					<cfset yearParam = ListGetAt(getCode, 2, '|')>
					<cfset incYear = 1>
					<cfif commandParams gt 2>
						<cfset incParam = ListGetAt(getCode, 3, '|')>
						<cfif IsNumeric(incParam)>
							<cfset incYear = incParam>
						</cfif>
					</cfif>
					<cfif yearParam eq 'next'>
						<cfset expandedText = expandedText + incYear>
					<cfelseif yearParam eq 'prev'>
						<cfset expandedText = expandedText - incYear>
					</cfif>
				</cfif>
			</cfcase>
			<cfdefaultcase>
				<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error: command ""#commandCode#"" not known]</span>">
			</cfdefaultcase>
		</cfswitch>
		<cfset outstr = Replace(outstr, "[[#getCode#]]", expandedText, 'ONE')>
		<cfset hasCode = false>
		<cfset getCodeOpen = Find('[[', outstr)>
		<cfif getCodeOpen>
			<cfset getCodeClose = Find(']]', outstr, getCodeOpen + 2)>
			<cfif getCodeClose>
				<cfset hasCode = true>
				<cfset getCode = Mid(outstr, getCodeOpen + 2, getCodeClose - getCodeOpen - 2)>
			</cfif>
		</cfif>
	</cfloop>
	<cfreturn outstr>
</cffunction>

<cffunction name="populateTableFromView">
	<cfargument name="table" type="string" default="subset_program_sum" >
	<cfargument name="subset_id" type="numeric" default="0">
	<cfargument name="full" type="boolean" default="false">
	<cfif application.subsetsUseViews>
	<cfif table eq 'subset_program_base' Or table eq 'subset_program_sum'>
		<cfif full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM #table#
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM #table#
				<cfif not full>
				WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" maxlength="4" value="#subset_id#">
				</cfif>
			</cfquery>
		</cfif>
		<cfif full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO #table#
					(subset_id, program_id)
				SELECT subset_id, program_id
				FROM view_#table#
				<cfif not full>
				WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" maxlength="4" value="#subset_id#">
				</cfif>
			</cfquery>
		</cfif>
	<cfelseif table eq 'program_parent'>
		<cfif full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM program_parent
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM program_parent
			</cfquery>
		</cfif>
		<cfif full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO program_parent
					(program_id, parent_program_id)
				SELECT program_id, parent_program_id
				FROM view_program_parent
			</cfquery>
		</cfif>
	<cfelseif table eq 'program_answerfield'>
		<cfif full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM program_answerfield
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM program_answerfield
			</cfquery>
		</cfif>
		<cfif full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO program_answerfield
					(program_id, answerfield_id, rule_flag)
				SELECT program_id, answerfield_id, rule_flag
				FROM view_program_answerfield
			</cfquery>
		</cfif>
	<cfelseif table eq 'xsubset'>
		<cfif full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM xsubset
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM xsubset
			</cfquery>
		</cfif>
		<cfif full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO xsubset
					(subset_id, subsettype_id, subset_name, subset_longname, subset_description, subset_text, qaire_name, alt_name, all_flag, drug_flag, grid_flag, optional_flag, rec_flag, eform_flag, schip_flag, state_flag, report_flag)
				SELECT subset_id, subsettype_id, subset_name, subset_longname, subset_description, subset_text, qaire_name, alt_name, all_flag, drug_flag, grid_flag, optional_flag, rec_flag, eform_flag, schip_flag, state_flag, report_flag
				FROM view_xsubset
			</cfquery>
		</cfif>
	<cfelseif table eq 'xsubset_xincometype'>
		<cfif full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM xsubset_xincometype where incometype_id <> 14
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM xsubset_xincometype
			</cfquery>
		</cfif>
		<cfif full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">

				INSERT INTO xsubset_xincometype
					(subset_id, incometype_id)
				SELECT subset_id, incometype_id
				FROM view_xsubset_xincometype
			</cfquery>
		</cfif>
	   <cfelseif table eq 'xsubset_xassettype'>
		<cfif full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM xsubset_xassettype
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM xsubset_xassettype
			</cfquery>
		</cfif>
		<cfif full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO xsubset_xassettype
					(subset_id, assettype_id)
				SELECT subset_id, assettype_id
				FROM view_xsubset_xassettype
			</cfquery>
		</cfif>
	<cfelseif table eq 'xsubset_xincass'>
		<cfif full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM xsubset_xincass
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM xsubset_xincass
			</cfquery>
		</cfif>
		<cfif full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO xsubset_xincass
					(subset_id, incass_id)
				SELECT subset_id, incass_id
				FROM view_xsubset_xincass_2
			</cfquery>
		</cfif>
	<cfelseif table eq 'xsubset_program'>
		<cfif full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM xsubset_program
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM xsubset_program
			</cfquery>
		</cfif>
		<cfif full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO xsubset_program
					(subset_id, program_id, exclude_flag)
				SELECT subset_id, program_id, exclude_flag
				FROM view_xsubset_program
			</cfquery>
		</cfif>
	<cfelseif table eq 'tbl_major_cat_list'>
		<cfif full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM tbl_major_cat_list
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM tbl_major_cat_list
			</cfquery>
		</cfif>
		<cfif full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO tbl_major_cat_list
					(major_cat, code, id_number, added_by, added_dt, mod_by, mod_dt, RecID, Sort_order)
				SELECT major_cat, code, id_number, added_by, added_dt, mod_by, mod_dt, RecID, Sort_order
				FROM view_tbl_major_cat_list
			</cfquery>
		</cfif>
	<cfelseif table eq 'tbl_prg_all'>
		<cfif full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM tbl_prg_all
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM tbl_prg_all
			</cfquery>
		</cfif>
		<cfif full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO tbl_prg_all
					(RecID, code, prg_id, order_num, pri_sec, prg_nm, prg_desc, st, proximity, firstproximity, comment, added_dt, added_by, mod_by, mod_dt, id, include, source, dollar_amount, Cat_ID, exclude_flag, inactive_flag, significant_flag, childrens_flag)
				SELECT RecID, code, prg_id, order_num, pri_sec, prg_nm, prg_desc, st, proximity, firstproximity, comment, added_dt, added_by, mod_by, mod_dt, id, include, source, dollar_amount, Cat_ID, exclude_flag, inactive_flag, significant_flag, childrens_flag
				FROM view_tbl_prg_all
			</cfquery>
		</cfif>
	<cfelseif table eq 'tbl_questions_new'>
		<cfif full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM tbl_questions_new
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM tbl_questions_new
			</cfquery>
		</cfif>
		<cfif full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO tbl_questions_new
					(question_id, answerfield, category, order_num, pri_sec, question, type, validation, client, textlength, dep_field, dep_op, dep_criteria, dep_formula)
				SELECT question_id, answerfield, category, order_num, pri_sec, question, type, validation, client, textlength, dep_field, dep_op, dep_criteria, dep_formula
				FROM view_tbl_questions_new
			</cfquery>
		</cfif>
	<cfelseif table eq 'tbl_rules'>
		<cfif full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM tbl_rules
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM tbl_rules
			</cfquery>
		</cfif>
		<cfif full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO tbl_rules
					(prg_id, elig_rule, pri_sec)
				SELECT prg_id, elig_rule, pri_sec
				FROM view_tbl_rules
			</cfquery>
		</cfif>
	</cfif>
	</cfif>
</cffunction>

</cfcomponent>