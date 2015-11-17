<cfparam name="attributes.table" type="string">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.remove" type="boolean" default="false">
<cfparam name="attributes.ordercolumn" type="string" default="sort">
<cfparam name="attributes.minimum" type="string" default="1">
<cfparam name="attributes.startatminimum" type="boolean" default="false">
<cfparam name="attributes.condition" type="string" default="">
<cfparam name="attributes.asteriskcolumn" type="string" default="">
<cfparam name="attributes.crosstable" type="string" default="">
<cfparam name="attributes.crosstag" type="string" default="">
<cfparam name="attributes.crosskey" type="string" default="">
<cfparam name="attributes.crosscolumn" type="string" default="">
<cfparam name="attributes.crosscondition" type="string" default="">
<cfparam name="attributes.saving" type="numeric" default="0">
<cfparam name="attributes.title" type="string" default="">
<cfparam name="attributes.selflink" type="boolean" default="false">
<cfparam name="attributes.redirect" type="string" default="">
<cfparam name="attributes.rows" type="string" default="18">
<cfparam name="attributes.width" type="string" default="240">
<cfparam name="attributes.name" type="string" default="">
<cfparam name="attributes.message" type="string" default="">

<cf_tableLoad table="#attributes.table#">

<cfset locallight = Evaluate("application.color.#attributes.code#.light")>
<cfset localmed = Evaluate("application.color.#attributes.code#.med")>
<cfset localdark = Evaluate("application.color.#attributes.code#.dark")>

<cfif attributes.saving eq 1>

	<cfif attributes.startatminimum>
		<cfset itemplace = attributes.minimum>
	<cfelse>
		<cfset itemplace = 1>
	</cfif>
	<cfloop index="x" list="#orderlist#">
		<cfquery name="ordered" datasource="#application.dbSrc#">
			update #attributes.table#
			set #attributes.ordercolumn#=#itemplace#
			<cfif attributes.crosstable eq ''>
			where #keys#=#x#
			<cfelse>
			where  #PreserveSingleQuotes(attributes.condition)# and #attributes.crosskey#='#x#'
			</cfif>
		</cfquery>
		<cfset itemplace = itemplace + 1>
	</cfloop>
	<cfif attributes.name neq ''>
		<cfset attributes.name = "###attributes.name#">
	</cfif>
	<cfif attributes.redirect eq ''>
		<cflocation url="#attributes.table#list.cfm#attributes.name#" addtoken="no">
	<cfelse>
		<cflocation url="#attributes.redirect##attributes.name#" addtoken="no">
	</cfif>

<cfelse>

<cfset selectList = ''>
<cfloop list="#keys#" index="x">
	<cfset selectList = ListAppend(selectList, "x.#x#")>
</cfloop>
<cfif attributes.asteriskcolumn neq '' and not ListFind(keys, attributes.asteriskcolumn)>
	<cfset selectList = ListAppend(selectList, "x.#attributes.asteriskcolumn#")>
</cfif>
<cfquery name="ordered" datasource="#application.dbSrc#">
	select #selectList#, <cfif attributes.startatminimum>x.#attributes.ordercolumn#, </cfif><cfif attributes.crosscolumn eq ''>x.#name#<cfelse>#attributes.crosstag#.#attributes.crosscolumn#</cfif>
	from `#attributes.table#` x<cfif attributes.crosstable neq ''>, `#attributes.crosstable#` #attributes.crosstag#</cfif>
	<cfif attributes.condition neq '' or attributes.crosscondition neq ''>where <cfif attributes.condition neq ''> #PreserveSingleQuotes(attributes.condition)#</cfif><cfif attributes.condition neq '' and attributes.crosscondition neq ''> and </cfif><cfif attributes.crosscondition neq ''>#PreserveSingleQuotes(attributes.crosscondition)#</cfif>
order by x.#attributes.ordercolumn#
	</cfif>
</cfquery>
<cfif attributes.startatminimum and ordered.RecordCount>
	<cfset attributes.minimum = Evaluate("ordered.#attributes.ordercolumn#")>
</cfif>
<cfset orderList=''>
<cfloop query="ordered">
	<cfif attributes.crosstable eq ''>
		<cfset orderList = ListAppend(orderList, Evaluate(keys))>
	<cfelse>
		<cfset orderList = ListAppend(orderList, Evaluate(attributes.crosskey))>
	</cfif>
</cfloop>


<cfoutput>	

<table bgcolor="#localmed#" cellspacing="0" cellpadding="0" border="0"><tr>
<td align="left"><table bgcolor="#localmed#" cellspacing="5" cellpadding="0" border="0">
	<cfif attributes.crosstable eq '' and not attributes.selflink>
	<form action="#attributes.table#order.cfm" method="post" name="orderby">
	<cfelse>
	<form action="<cfif IsDefined('id')>?id=#id#</cfif>" method="post" name="orderby">
	</cfif>
	<tr></tr>
	<tr>
		<td></td>
		<td valign="bottom" width="#attributes.width#" class="normal"><b>#attributes.title#</b></td>
		<td></td>
		<cfif attributes.remove>
		<td valign="bottom" width="#attributes.width#" class="normal"><b>Recycle&nbsp;bin</b></td>
		<td></td>
		</cfif>
	</tr>
	<tr>
		<td></td>
		<td valign="top" class="small"><i><b>To reorder list:</b> Highlight item,<br>then use up and down arrows to<br>move to new position in list.</i></td>
		<td></td>
		<cfif attributes.remove>
		<td valign="top" class="small"><i><b>To remove items:</b> Use left and right<br>arrows to transfer highlighted titles<br>to and from recycle bin.</i></td>
		<td></td>
		</cfif>
	</tr>
	<tr>
		<td align="center" valign="middle">
<input type="button" value="  top  " class="search" onClick="launchElement(this.form.avllist, -1, this.form.avllist, this.form.orderlist)"><br><br>
<input type="button" value="pg up" class="search" onClick="jumpElement(this.form.avllist, -1, this.form.avllist, this.form.orderlist)"><br><br>
<input type="button" value="  up  " class="search" onClick="nudgeElement(this.form.avllist, -1, this.form.avllist, this.form.orderlist)"><br><br>
<input type="button" value=" down " class="search" onClick="nudgeElement(this.form.avllist, 1, this.form.avllist, this.form.orderlist)"><br><br>
<input type="button" value="pg dn" class="search" onClick="jumpElement(this.form.avllist, 1, this.form.avllist, this.form.orderlist)"><br><br>
<input type="button" value="bottom" class="search" onClick="launchElement(this.form.avllist, 1, this.form.avllist, this.form.orderlist)">
		</td>
		<td valign="top"><select name="avllist" size="#attributes.rows#" width="#attributes.width#" style="width: #attributes.width#" class="search" onMouseUp="if (ie) clicked(this, this.form.sellist, this, this.form.orderlist, this.form.sellist, this.form.removelist)" onFocus="if (ns) clicked(this, this.form.sellist, this, this.form.orderlist, this.form.sellist, this.form.removelist); this.blur()">|;

		<cfloop query="ordered">
			<cfif attributes.asteriskcolumn neq '' and Evaluate(attributes.asteriskcolumn) neq ''>
				<cfset asterisk = '* '>
			<cfelse>
				<cfset asterisk = ''>
			</cfif>
			<cfif attributes.crosstable eq ''>
				<option value="#Evaluate(keys)#">#asterisk##Evaluate(name)#
			<cfelse>
				<option value="#Evaluate("#attributes.crosskey#")#">#asterisk##Evaluate("#attributes.crosscolumn#")#
			</cfif>
		</cfloop>

		</select></td>
		<cfif attributes.remove>
		<td align="center" valign="middle">
<input type="button" value=" --&gt; " class="search" onClick="moveElement(this.form.avllist, this.form.sellist, this.form.avllist, this.form.orderlist, this.form.sellist, this.form.removelist)"><br>
<br>
<input type="button" value=" &lt;-- " class="search" onClick="moveElement(this.form.sellist, this.form.avllist, this.form.avllist, this.form.orderlist, this.form.sellist, this.form.removelist)">
		</td>
		<td valign="top">
<select name="sellist" size="#attributes.rows#" width="#attributes.width#" style="width: #attributes.width#" class="search" onMouseUp="if (ie) clicked(this, this.form.avllist, this.form.avllist, this.form.orderlist, this, this.form.removelist)" onFocus="if (ns) clicked(this, this.form.avllist, this.form.avllist, this.form.orderlist, this, this.form.removelist); this.blur()">
</select>
		</td>
		<td></td>
		<cfelse>
		<td><input type="hidden" name="sellist" value=""></td>
		</cfif>
	</tr>
	<tr></tr>
	<cfif attributes.message neq ''>
	<tr>
		<td></td>
		<td valign="top" class="small"><i>#attributes.message#</i></td>
	</tr>
	<tr></tr>
	</cfif>
	<tr>
		<td></td>
		<td align="left" valign="top"><input type="button" value="save changes" class="search" onClick="reorderSubmit(this.form.avllist, this.form.orderlist, this.form.sellist, <cfif attributes.remove>this.form.removelist<cfelse>null</cfif>);"> &nbsp; <input type="button" value="cancel" class="search" onClick="history.go(-1);"><input type="hidden" name="orderlist" value="#orderList#"><input type="hidden" name="removelist" value=""><input type="hidden" name="saving" value="1"><cfif attributes.startatminimum><input type="hidden" name="minimum" value="#attributes.minimum#"></cfif><input type="hidden" name="name" value="#attributes.name#"></td>
		<td></td>
	</tr>
	<tr></tr>
	</form>
</table></td></tr>
</table>

</cfoutput>

</cfif>
