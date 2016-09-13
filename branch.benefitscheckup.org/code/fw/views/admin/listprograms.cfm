<link rel="stylesheet" type="text/css" media="screen" href="includes/css/jquery-ui-1.7.2.custom.css" />
<link rel="stylesheet" type="text/css" media="screen" href="includes/css/ui.jqgrid.css" />

<script src="includes/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="includes/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<h1>LIST PROGRAMS</h1>
<cfset programs = event.getArg("programs")>
<table id="programs"></table> 
<div id="programPages"></div> 
<!--- <cfoutput query="programs">
	<cfif isDefined("session.user") AND session.user.hasRole("superuser")>
        <div class="userListItem">
            <b>ID</b>: #program_id# | 
            <b>Program Code</b>: #program_code# | <a href="index.cfm?event=admin.editProgram&program_id=#program_id#">EDIT</a>
        </div>
	</cfif>
</cfoutput> --->

<script type="text/javascript">
jQuery(document).ready(function(){ 

  jQuery("#programs").jqGrid({
    url:'model/program/remoteProgramService.cfc?method=getProgramsJSON',
    datatype: 'JSON',
    colNames:['Program ID','Program Code', 'URL','Legacy Program ID','Created Date'],
    colModel :[ 
      {name:'program_id', index:'program_id', width:95, sortable:true, sorttype:"integer"}, 
      {name:'program_code', index:'program_code', width:210, search:true, stype:"text"}, 
      {name:'url', index:'url', width:280, align:'right'}, 
      {name:'legacy_prg_id', index:'legacy_prg_id', width:150, align:'right'}, 
      {name:'create_date', index:'create_date', width:200, align:'right'}
    ],
    pager: '#programPages',
    rowNum:10,
    rowList:[10,20,30],
    sortname: 'program_id',
    sortorder: 'desc',
    viewrecords: true,
    caption: 'Programs',
	height:'auto',
	search : {
		 caption: "Search...",
		 Find: "Find",
		 Reset: "Reset",
		 odata : ['equal', 'not equal', 'less', 'less or equal','greater','greater or equal', 'begins with','does not begin with','is in','is not in','ends with','does not end with','contains','does not contain'],
		 groupOps: [ { op: "AND", text: "all" }, { op: "OR", text: "any" } ],
		 matchText: " match",
		 rulesText: " rules"
	   },
	jsonReader: {
		  root: "ROWS", //our data
		  page: "PAGE", //current page
		  total: "TOTAL", //total pages
		  records:"RECORDS", //total records
		  cell: "", //not used
		  id: "0" //will default first column as ID
	}
  }); 
  jQuery("#programs").jqGrid('navGrid','#programPages', {}, //options 
							{height:280,reloadAfterSubmit:false}, // edit options 
							{height:280,reloadAfterSubmit:false}, // add options 
							{reloadAfterSubmit:false}, // del options 
							{} // search options 
	); 
}); 
/*
http://127.0.0.1:8500/fw/model/program/remoteProgramService.cfc
?method=getProgramsJSON
&_search=true&nd=1261505780666
&rows=10
&page=1
&sidx=program_id
&sord=desc
&searchOper=eq
&searchString=1908
&searchField=program_id
*/
</script>