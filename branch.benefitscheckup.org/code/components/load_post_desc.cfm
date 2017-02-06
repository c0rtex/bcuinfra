<cfset programs = ormExecuteQuery("from program where active_flag=1")>
<cfloop array="#programs#" index="i">
    <cfoutput><p>set @post_id = null;</p></cfoutput>
    <cfoutput><p>select id into @post_id from wp_posts where post_name='factsheet_#i.getCode()#';</p></cfoutput>
    <cfoutput><p>delete from wp_postmeta where post_id=@post_id and meta_key='program_short_summary';</p></cfoutput>
    <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) select @post_id,'program_short_summary','#i.getShort_desc()#' from dual where not(@post_id is null);</p></cfoutput>
</cfloop>

