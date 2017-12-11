<cfquery name="getPartnerInfo" datasource="dbSrc">
  select
  t.partner_id,
  t.partner_code,
  t.partner_name,
  t.partner_url,
  t.alt_name,
  pt.`code` as partner_type,
  t.partner_titlebar,
  t.login_only_flag,
  t.report_flag,
  t.learn_flag,
  t.race_flag,
  t.hispanic_flag,
  t.links_flag,
  t.pdf_logo_flag,
  t.demo,
  t.parent,
  w.wrapper_logo,
  w.wrapper_logo_alt_text,
  w.wrapper_logo_link
  from
  tbl_partner t join
  partnertype pt on t.partnertype_id=pt.partnertype_id join
  `wrapper` w on w.wrapper_id=t.wrapper_id
</cfquery>

<cfoutput>
    <p>delete from wp_postmeta where post_id in (select id from wp_posts where post_type='partners-data');</p>
    <p>delete from wp_posts where post_type='partners-data';</p>
    </p>
</cfoutput>

<cfloop query = "getPartnerInfo">
  <cfoutput><p>set @post_id = null;</p></cfoutput>

  <cfoutput><p>insert into wp_posts(post_title,post_type,post_content,post_excerpt,to_ping,pinged,post_content_filtered,post_mime_type)
      values ('#partner_name#','partners-data','','','','','','');</p></cfoutput>

  <cfoutput><p>select last_insert_id() into @post_id;</p></cfoutput>

  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-id','#partner_id#');</p></cfoutput>
  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-code','#partner_code#');</p></cfoutput>
  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-name','#partner_name#');</p></cfoutput>
  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-url','#partner_url#');</p></cfoutput>
  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-alt-name','#alt_name#');</p></cfoutput>
  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-type','#partner_type#');</p></cfoutput>
  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-title-bar','#partner_titlebar#');</p></cfoutput>
  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-cms-document-no','#partner_titlebar#');</p></cfoutput>
  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-login-only','#login_only_flag#');</p></cfoutput>
  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-include-in-reports','#report_flag#');</p></cfoutput>
  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-learn','#learn_flag#');</p></cfoutput>
  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-race','#race_flag#');</p></cfoutput>
  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-hispanic','#hispanic_flag#');</p></cfoutput>
  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-prepop-links','#links_flag#');</p></cfoutput>
  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-pdf-logo','#pdf_logo_flag#');</p></cfoutput>
  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-demo','#demo#');</p></cfoutput>
  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-parent-id','#parent#');</p></cfoutput>

  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'logo','#wrapper_logo#');</p></cfoutput>
  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'logo-alt-text','#wrapper_logo_alt_text#');</p></cfoutput>
  <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'logo-link','#wrapper_logo_link#');</p></cfoutput>

</cfloop>

