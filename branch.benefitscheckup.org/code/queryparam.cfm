<b>1 queries found in checkzip.cfm!</b><br />
            &lt;cfquery name=&quot;postalcode&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	select z.zipcode, z.state_id
	from zip z, state s
	where z.zipcode='#Left(zip, 5)#'
		and z.valid=1
		and z.state_id=s.state_id
		and s.statetype_id=1
&lt;/cfquery&gt;<br>
                Table: <strong>zip</strong><br>
				Params:<br>
				
                    <strong>'#Left(zip, 5)#'</strong><br>
                    

                <hr>
            <b>6 queries found in com/fusionlink/Portcullis.cfc!</b><br />
            &lt;cfquery dbtype=&quot;query&quot; name=&quot;find&quot;&gt;
		select IP from variables.instance.iplog
		where IP = &lt;cfqueryparam cfsqltype=&quot;cf_sql_varchar&quot; maxlength=&quot;20&quot; value=&quot;#arguments.ipAddress#&quot;&gt;
		&lt;/cfquery&gt;<br>
                Table: <strong>zip</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery dbtype=&quot;query&quot; name=&quot;find&quot;&gt;
			SELECT blocked 
			FROM variables.instance.iplog
			WHERE IP = &lt;cfqueryparam cfsqltype=&quot;cf_sql_varchar&quot; maxlength=&quot;20&quot; value=&quot;#arguments.ipAddress#&quot;&gt;
			&lt;/cfquery&gt;<br>
                Table: <strong>zip</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery dbtype=&quot;query&quot; name=&quot;variables.instance.iplog&quot;&gt;
		SELECT IP, Attempts, Blocked, DateBlocked
		FROM variables.instance.iplog
		WHERE DateBlocked &gt; &lt;cfqueryparam cfsqltype=&quot;cf_sql_datetime&quot; maxlength=&quot;50&quot; value=&quot;#dateadd(&quot;s&quot;,cutoff,now())#&quot;&gt;
		&lt;/cfquery&gt;<br>
                Table: <strong>zip</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery dbtype=&quot;query&quot; name=&quot;find&quot;&gt;
		SELECT attempts 
		FROM variables.instance.iplog
		WHERE IP = &lt;cfqueryparam cfsqltype=&quot;cf_sql_varchar&quot; maxlength=&quot;20&quot; value=&quot;#arguments.ipAddress#&quot;&gt;
		&lt;/cfquery&gt;<br>
                Table: <strong>zip</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery dbtype=&quot;query&quot; name=&quot;variables.instance.iplog&quot;&gt;
		&lt;cfif variables.instance.ipBlock eq true and variables.instance.allowedAttempts lte attempts&gt;
		SELECT IP, #attempts# AS Attempts, 1 AS Blocked, #now()# as DateBlocked
		&lt;cfelse&gt;
		SELECT IP, #attempts# AS Attempts, Blocked, #now()# as DateBlocked
		&lt;/cfif&gt; 
		FROM variables.instance.iplog
		WHERE IP = &lt;cfqueryparam cfsqltype=&quot;cf_sql_varchar&quot; maxlength=&quot;20&quot; value=&quot;#arguments.ipAddress#&quot;&gt;
		UNION
		SELECT IP, Attempts, Blocked, DateBlocked 
		FROM variables.instance.iplog
		WHERE NOT IP = &lt;cfqueryparam cfsqltype=&quot;cf_sql_varchar&quot; maxlength=&quot;20&quot; value=&quot;#arguments.ipAddress#&quot;&gt;
		&lt;/cfquery&gt;<br>
                Table: <strong>zip</strong><br>
				Params:<br>
				
                    <strong>#attempts#</strong><br>
                    
                    <strong>#now()#</strong><br>
                    
                    <strong>#attempts#</strong><br>
                    
                    <strong>#now()#</strong><br>
                    

                <hr>
            &lt;cfquery dbtype=&quot;query&quot; name=&quot;variables.instance.iplog&quot;&gt;
		SELECT *
		FROM variables.instance.iplog
		WHERE IP &lt;&gt; &lt;cfqueryparam cfsqltype=&quot;cf_sql_varchar&quot; maxlength=&quot;20&quot; value=&quot;#arguments.ipAddress#&quot;&gt;
		&lt;/cfquery&gt;<br>
                Table: <strong>zip</strong><br>
				Params:<br>
				

                <hr>
            <b>2 queries found in confirmation.cfm!</b><br />
            &lt;cfquery name=&quot;qrySubmission&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT *
	FROM screening_submission
	WHERE screening_id=#session.prev_id#
	AND submission_status = 1
&lt;/cfquery&gt;<br>
                Table: <strong>zip</strong><br>
				Params:<br>
				
                    <strong>#session.prev_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;qrySubmission&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT *
		FROM screening_submission
		WHERE screening_id=#session.prev_id#
		ORDER BY post_finish_time DESC	
	&lt;/cfquery&gt;<br>
                Table: <strong>zip</strong><br>
				Params:<br>
				
                    <strong>#session.prev_id#</strong><br>
                    

                <hr>
            <b>1 queries found in dspEForms.cfm!</b><br />
            &lt;CFQUERY datasource=&quot;#application.dbSrc#&quot; name=&quot;appforms&quot;&gt;
	SELECT ft.string, t.tag_name
	FROM tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
	WHERE p.prg_id = '#prg_id#'
		AND p.RecID=pf.program_id
		AND pf.form_id=f.form_id
		and (f.state_id is null or f.state_id='#session.st#')
		AND f.form_id=ft.form_id
		AND ft.formtype_id=2
		AND ft.active=1
		AND f.formtag_id=t.formtag_id
	ORDER BY pf.sort
&lt;/CFQUERY&gt;<br>
                Table: <strong>zip</strong><br>
				Params:<br>
				
                    <strong>'#prg_id#'</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    

                <hr>
            <b>1 queries found in dspMedicareConfirm.cfm!</b><br />
            &lt;cfquery name=&quot;GetName&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
SELECT     CardName
FROM      tbl_rx_prgdetail
where DNumber = '#form.SponsorID#'
&lt;/cfquery&gt;<br>
                Table: <strong>zip</strong><br>
				Params:<br>
				
                    <strong>'#form.SponsorID#'</strong><br>
                    

                <hr>
            <b>2 queries found in dspMedicareEnroll.cfm!</b><br />
            &lt;cfquery datasource=&quot;#application.dbSrc#&quot; name=&quot;getMedicare&quot;&gt; 
&lt;cfif isdefined('url.prg_id')&gt;
SELECT tbl_prg_all.prg_id, tbl_prg_all.prg_nm, tbl_RX_PrgDetail.DNumber
FROM         tbl_prg_all INNER JOIN tbl_RX_PrgDetail ON tbl_prg_all.prg_id = tbl_RX_PrgDetail.PRG_ID
where
tbl_prg_all.prg_id = tbl_RX_PrgDetail.prg_id and
tbl_prg_all.prg_id = '#url.prg_id#'

&lt;cfelse&gt;
SELECT tbl_prg_all.prg_id, tbl_prg_all.prg_nm, tbl_RX_PrgDetail.DNumber
FROM         tbl_prg_all INNER JOIN
                      tbl_user_prgid ON tbl_prg_all.prg_id = tbl_user_prgid.prg_id INNER JOIN
                      tbl_RX_PrgDetail ON tbl_user_prgid.prg_id = tbl_RX_PrgDetail.PRG_ID
WHERE  
(tbl_user_prgid.unseen IS NULL) and (tbl_user_prgid.clientnum = '#clientnum#') AND (tbl_prg_all.Cat_ID = 333)
&lt;/cfif&gt; 
&lt;/cfquery&gt;<br>
                Table: <strong>zip</strong><br>
				Params:<br>
				
                    <strong>'#url.prg_id#'</strong><br>
                    
                    <strong>'#clientnum#'</strong><br>
                    

                <hr>
            &lt;cfquery datasource=&quot;#application.dbSrc#&quot; name=&quot;getMedicare&quot;&gt; 
SELECT tbl_prg_all.prg_id, tbl_prg_all.prg_nm, tbl_RX_PrgDetail.DNumber
FROM         tbl_prg_all INNER JOIN tbl_RX_PrgDetail ON tbl_prg_all.prg_id = tbl_RX_PrgDetail.PRG_ID
where
tbl_prg_all.prg_id = tbl_RX_PrgDetail.prg_id and
tbl_prg_all.prg_id in ('#session.prg[1]#','#session.prg[2]#','#session.prg[3]#')
&lt;/cfquery&gt;<br>
                Table: <strong>zip</strong><br>
				Params:<br>
				
                    <strong>'#session.prg[1]#'</strong><br>
                    
                    <strong>'#session.prg[2]#'</strong><br>
                    
                    <strong>'#session.prg[3]#'</strong><br>
                    

                <hr>
            <b>1 queries found in dspTAEnrollmentCount.cfm!</b><br />
            &lt;cfquery name=&quot;CountTA&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
SELECT count(distinct(ConfirmationNumber)) as total
FROM tbl_user_ta
WHERE CreateDate &gt; '12/20/2004'
&lt;/cfquery&gt;<br>
                Table: <strong>zip</strong><br>
				Params:<br>
				

                <hr>
            <b>2 queries found in dsp_appforms.cfm!</b><br />
            &lt;CFQUERY datasource=&quot;#application.dbSrc#&quot; name=&quot;appforms&quot;&gt;
	SELECT ft.string, t.tag_name
	FROM tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
	WHERE p.prg_id = '#prg_id#'
		AND p.RecID=pf.program_id
		AND pf.form_id=f.form_id
		and (f.state_id is null or f.state_id='#session.st#')
		AND f.form_id=ft.form_id
		AND ft.formtype_id&lt;cfif formtype_id eq 0&gt; IN (1, 4)&lt;cfelse&gt;=#formtype_id#&lt;/cfif&gt;
		AND ft.active=1
		AND f.formtag_id=t.formtag_id
	ORDER BY pf.sort
&lt;/CFQUERY&gt;<br>
                Table: <strong>zip</strong><br>
				Params:<br>
				
                    <strong>'#prg_id#'</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#formtype_id#</strong><br>
                    

                <hr>
            &lt;CFQUERY datasource=&quot;#application.dbSrc#&quot; name=&quot;appforms&quot;&gt;
	SELECT ft.string, t.tag_name
	FROM tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
	WHERE p.prg_id = '#prg_id#'
		AND p.RecID=pf.program_id
		AND pf.form_id=f.form_id
		and (f.state_id is null or f.state_id='#session.st#')
		AND f.form_id=ft.form_id
		AND ft.formtype_id&lt;cfif formtype_id eq 0&gt; IN (1, 4)&lt;cfelse&gt;=#formtype_id#&lt;/cfif&gt;
		AND ft.active=1
		AND f.formtag_id=t.formtag_id
	ORDER BY pf.sort
&lt;/CFQUERY&gt;<br>
                Table: <strong>zip</strong><br>
				Params:<br>
				
                    <strong>'#prg_id#'</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#formtype_id#</strong><br>
                    

                <hr>
            <b>3 queries found in ec/dspForms.cfm!</b><br />
            &lt;cfquery name=&quot;matchingdrugs&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT a.answerfield, convert(dl.display_text, 1, 255) option_nm
		FROM tbl_prg_all p, program_answerfield pa, answerfield a, display_language dl
		WHERE p.prg_id = '#prg_id#'
			AND p.recid=pa.program_id
			and pa.answerfield_id=a.answerfield_id
			AND a.answerfieldtype_id in (13, 14)
			AND a.display_id=dl.display_id
			and dl.language_id='#session.language_id#'
		ORDER BY option_nm
	&lt;/cfquery&gt;<br>
                Table: <strong>zip</strong><br>
				Params:<br>
				
                    <strong>'#prg_id#'</strong><br>
                    
                    <strong>'#session.language_id#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;genericMatch&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
			select answerfield, answerfield option_nm
			from answerfield
			where answerfield_id is null
		&lt;/cfquery&gt;<br>
                Table: <strong>zip</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;genericMatch&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
			select a.answerfield, substring(dl.display_text, 1, 255) as option_nm
			from answerfield_relationship ar, answerfield a, display_language dl
			where ar.right_answerfield_id in (#genericList#)
				and ar.relationship_id=1
				and ar.left_answerfield_id=a.answerfield_id
				and a.answerfieldtype_id=13
				and a.display_id=dl.display_id
				and dl.language_id='#session.language_id#'
			order by option_nm
		&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>#genericList#</strong><br>
                    
                    <strong>'#session.language_id#'</strong><br>
                    

                <hr>
            <b>1 queries found in ec/dsp_appforms.cfm!</b><br />
            &lt;CFQUERY datasource=&quot;#application.dbSrc#&quot; name=&quot;appforms&quot;&gt;

	SELECT ft.string, t.tag_name

	FROM tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t

	WHERE p.prg_id = '#prg_id#'

		AND p.RecID=pf.program_id

		AND pf.form_id=f.form_id

		AND f.form_id=ft.form_id

		AND ft.formtype_id=1

		AND ft.active=1

		AND f.formtag_id=t.formtag_id

	ORDER BY pf.sort

&lt;/CFQUERY&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>'#prg_id#'</strong><br>
                    

                <hr>
            <b>2 queries found in ec/procGetPrg.cfm!</b><br />
            &lt;CFQUERY NAME=&quot;qryPrgs&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
		SELECT p.prg_id
		FROM answerfield a, program_answerfield pa, tbl_prg_all p
		WHERE a.answerfield = '#drug#'
			AND a.answerfield_id=pa.answerfield_id
			AND pa.program_id=p.RecID
		ORDER BY p.prg_id
	&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>'#drug#'</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;qryPrgs2&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
		select p.prg_id
		from answerfield_relationship ar, program_answerfield pa, tbl_prg_all p
		where ar.right_answerfield_id in (#genericList#)
				and ar.relationship_id=1
				and ar.left_answerfield_id=pa.answerfield_id
				and pa.program_id=p.RecID
		group by p.prg_id
		order by p.prg_id
	&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>#genericList#</strong><br>
                    

                <hr>
            <b>1 queries found in ec/qryForms.cfm!</b><br />
            &lt;cfquery datasource=&quot;#application.dbSrc#&quot; name=&quot;qryForms&quot;&gt;
SELECT distinct(f.form_id), p.recid, p.prg_id, p.prg_nm, f.state_id as st, f.form_name, ft.type_code, ftg.tag_name, fft.string, fft.entry_date, fft.form_date, p.cat_id, fft.formtype_id, p.ST 
FROM
form f, formtype ft, form_formtype fft, program_form pf, tbl_prg_all p, formtag ftg, subset_program_base sp
WHERE 
f.form_id = fft.form_id 
and ft.formtype_id = fft.formtype_id
and pf.program_id=p.recid
and pf.form_id = f.form_id
and ftg.formtag_id = f.formtag_id
and ft.formtype_id &lt;&gt; 2
AND sp.program_id=p.RecID
AND (p.inactive_flag = 0 or p.inactive_flag is null)



&lt;cfif isdefined('url.cat') and url.cat EQ 'PAP'&gt;

and sp.subset_id=19
and p.CAT_ID = 331

&lt;cfelseif isdefined('url.cat') and url.cat EQ 'MSP'&gt;
and sp.subset_id=1
and p.CAT_ID = 309

&lt;cfelseif isdefined('url.cat') and url.cat EQ 'QMB'&gt;
and sp.subset_id=1
and (  p.prg_id = '103-309-1031-FD-FD' or  p.prg_id = '103-309-2681-AZ-ST')
&lt;cfelseif isdefined('url.cat') and url.cat EQ 'QI'&gt;
and sp.subset_id=1
and (  p.prg_id = '103-309-1071-FD-FD' or p.prg_id = '103-309-2683-AZ-ST' )
&lt;cfelseif isdefined('url.cat') and url.cat EQ 'SLMB'&gt;
and sp.subset_id=1
and ( p.prg_id = '103-309-1032-FD-FD' or p.prg_id = '103-309-2682-AZ-ST')
&lt;cfelseif isdefined('url.cat') and url.cat EQ 'MEDAPROV'&gt;
and sp.subset_id=12
&lt;cfelseif isdefined('url.cat') and url.cat EQ 'MED'&gt;
and sp.subset_id=8
&lt;cfelseif isdefined('url.cat') and url.cat EQ 'OTH'&gt;
and sp.subset_id=1
and p.CAT_ID = 332
&lt;cfelseif isdefined('url.cat') and url.cat EQ 'STRX'&gt;
and sp.subset_id=9
&lt;cfelseif isdefined('url.cat') and (url.cat EQ 'Entered' or url.cat EQ 'PUB')&gt;
and sp.subset_id=1
&lt;cfelseif isdefined('url.ST') and url.ST neq ''&gt;
and sp.subset_id=1
and  (f.state_id = '#url.ST#') 
&lt;/cfif&gt;



&lt;cfif isdefined('url.cat') and url.cat EQ 'DRUG'&gt;

&lt;cfif isdefined('session.ecPrgList') and len(session.ecPrgList) gt 1 &gt;
and (sp.subset_id=1 or sp.subset_id=19)
and p.prg_id IN (#preserveSingleQuotes(session.ecPrgList)#)
&lt;cfelse&gt;
and sp.subset_id=10000
&lt;/cfif&gt;
&lt;/cfif&gt;



&lt;cfif isdefined('url.sortorder') and isdefined ('url.sortby')&gt;
	order by #url.sortby# #url.sortorder#
&lt;cfelseif isdefined('url.ST') and url.ST neq '' &gt;
	order by p.CAT_ID
&lt;cfelseif isdefined('url.cat') and url.cat eq 'PUB'&gt;
	order by fft.form_date desc
&lt;cfelseif isdefined('url.cat') and url.cat eq 'ENTERED'&gt;
	order by fft.entry_date desc
&lt;cfelseif isdefined('url.cat') and url.cat eq 'DRUG'&gt;
	order by p.CAT_ID asc
&lt;cfelseif isdefined('url.cat') and (url.cat EQ 'SLMB' or url.cat EQ 'QMB' or url.cat EQ 'QI' or url.cat EQ 'MED' or url.cat EQ 'MSP' or url.cat EQ 'STRX') &gt;
	order by p.ST
&lt;cfelse&gt;
	order by p.prg_nm
&lt;/cfif&gt;
&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>'#url.ST#'</strong><br>
                    
                    <strong>#preserveSingleQuotes(session.ecPrgList)#</strong><br>
                    
                    <strong>#url.sortby#</strong><br>
                    
                    <strong>#url.sortorder#</strong><br>
                    

                <hr>
            <b>1 queries found in expertfeedback_p.cfm!</b><br />
            &lt;CFQUERY datasource=&quot;rxwizardexpfdbk&quot; NAME=&quot;add&quot;&gt;

INSERT INTO pagefeedback (
   like, suggestions, comments
	)
VALUES (
	'#form.like#', '#form.suggestions#', '#form.comments#'
	)
&lt;/CFQUERY&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>'#form.like#'</strong><br>
                    
                    <strong>'#form.suggestions#'</strong><br>
                    
                    <strong>'#form.comments#'</strong><br>
                    

                <hr>
            <b>3 queries found in forcetallyupdate.cfm!</b><br />
            &lt;cfquery name=&quot;gettally&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT bcu, rx, brand, generic, drug
	FROM view_tally
&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;updatetally&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	UPDATE tbl_tally
	SET bcu=#gettally.bcu#, rx=#gettally.rx#, brand=#gettally.brand#, generic=#gettally.generic#, drug=#gettally.drug#, updated=now()
&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>#gettally.bcu#</strong><br>
                    
                    <strong>#gettally.rx#</strong><br>
                    
                    <strong>#gettally.brand#</strong><br>
                    
                    <strong>#gettally.generic#</strong><br>
                    
                    <strong>#gettally.drug#</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;qryDrugnm&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
SELECT * FROM tbl_tally
&lt;/CFQUERY&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				

                <hr>
            <b>2 queries found in frmassetgrid.cfm!</b><br />
            &lt;cfquery name=&quot;getasset&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT a.assettype_name, a.assettype_varname, a.definition
	FROM &lt;cfif session.subsetGridFlag eq 1&gt;xsubset_xassettype sa, &lt;/cfif&gt;xassettype a
	WHERE &lt;cfif session.subsetGridFlag eq 1&gt;sa.subset_id=#session.subset_id#
		AND sa.assettype_id=a.assettype_id&lt;cfelse&gt;a.exclude_flag=0&lt;/cfif&gt;
	ORDER BY a.sort
&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;getassetvar&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT i.assettype_varname
		FROM xassettype i
		ORDER BY i.sort
	&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				

                <hr>
            <b>1 queries found in frmDrugCosts.cfm!</b><br />
            &lt;CFQUERY NAME=&quot;qryDrugnm&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
select substring(dl.display_text, 1,  255) as option_nm, a.answerfield as fieldtext,
        0 sort_id, lower(substring(dl.display_text, 255)) as low
from answerfield a, display_language dl
where a.answerfieldtype_id=14
        and a.display_id=dl.display_id
        and dl.language_id='EN'
union
select substring(dl.display_text, 1, 255) as option_nm, q.answerfield as fieldtext,
        0 sort_id, lower(substring(dl.display_text, 1, 255)) as low
from (
        select a.answerfield_id, a.answerfieldtype_id, a.answerfield, a.display_id
        from program_answerfield pa, answerfield a
        where pa.answerfield_id=a.answerfield_id
                and a.answerfieldtype_id=13
        group by a.answerfield_id, a.answerfieldtype_id, a.answerfield, a.display_id
     ) q, display_language dl
where q.answerfieldtype_id=13
        and q.display_id=dl.display_id
        and dl.language_id='EN'
order by option_nm
&lt;/CFQUERY&gt;<br>
                Table: <strong>program_answerfield</strong><br>
				Params:<br>
				

                <hr>
            <b>5 queries found in frmEForms.cfm!</b><br />
            &lt;CFQUERY NAME=&quot;programs&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
		SELECT prg_id, prg_nm
		FROM tbl_prg_all
		WHERE prg_id IN (#PreserveSingleQuotes(tempList)#)
	&lt;/CFQUERY&gt;<br>
                Table: <strong>program_answerfield</strong><br>
				Params:<br>
				
                    <strong>#PreserveSingleQuotes(tempList)#</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;forms&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
		select p.prg_id, pf.sort, ft.formtype_id, t.formclass_id, t.tag_name
		from tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
		where p.prg_id IN (#PreserveSingleQuotes(tempList)#)
			and p.recid=pf.program_id
			and pf.form_id=f.form_id
			and (f.state_id is null or f.state_id='#session.st#')
			and f.form_id=ft.form_id
			&lt;cfif Not isOE&gt;and ft.formtype_id &lt;= #typeLimit#&lt;/cfif&gt;
			and ft.active=1
			and f.formtag_id=t.formtag_id
		order by p.prg_id, pf.sort, ft.formtype_id
	&lt;/CFQUERY&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#PreserveSingleQuotes(tempList)#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#typeLimit#</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;programs&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
		SELECT prg_id, prg_nm
		FROM tbl_prg_all
		WHERE prg_id IN (#PreserveSingleQuotes(session.prg_list)#)
	&lt;/CFQUERY&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#PreserveSingleQuotes(session.prg_list)#</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;forms&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
		select p.prg_id, pf.sort, ft.formtype_id, t.formclass_id, t.tag_name
		from tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
		where p.prg_id IN (#PreserveSingleQuotes(session.prg_list)#)
			and p.recid=pf.program_id
			and pf.form_id=f.form_id
			and (f.state_id is null or f.state_id='#session.st#')
			and f.form_id=ft.form_id
			&lt;cfif Not isOE&gt;and ft.formtype_id &lt;= #typeLimit#&lt;/cfif&gt;
			and ft.active=1
			and f.formtag_id=t.formtag_id
		order by p.prg_id, pf.sort, ft.formtype_id
	&lt;/CFQUERY&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#PreserveSingleQuotes(session.prg_list)#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#typeLimit#</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;order&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
		SELECT prg_id AS eachPrg
		FROM tbl_prg_all
		WHERE prg_id IN (#PreserveSingleQuotes(session.prg_list)#)
		ORDER BY order_num, prg_nm
	&lt;/CFQUERY&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#PreserveSingleQuotes(session.prg_list)#</strong><br>
                    
	    <!--- MH: Bug 5579 7/21/10 Removed reference to tbl_prg_agcode which is being archived 

                <hr>
            <b>1 queries found in frmEFormsAll.cfm!</b><br />
            &lt;CFQUERY DATASOURCE=&quot;#application.dbSrc#&quot; NAME=&quot;prgs&quot;&gt;
	SELECT p.prg_id, p.prg_nm, pa.ag_code
	FROM tbl_prg_agcode pa, tbl_prg_all p
	WHERE pa.prg_id=p.prg_id
	ORDER BY p.order_num DESC, p.prg_nm DESC, pa.ag_code
&lt;/CFQUERY&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>--->
				

                <hr>
            <b>2 queries found in frmeligibility.cfm!</b><br />
            &lt;cfquery name=&quot;prgConvert&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		select p.program_code
		from tbl_prg_all pa inner join program p
				on pa.RecID=p.program_id
			left outer join programgroup pg
				on p.programgroup_id=pg.programgroup_id
		where pa.prg_id in (#PreserveSingleQuotes(session.prg_list)#)
		order by pg.sort, p.sort
	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#PreserveSingleQuotes(session.prg_list)#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;prgs&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		select pp.program_code, ifnull(pp.supersort, 999999999) bigsort
		from tbl_prg_all p, program pp, programcategory pc
		where p.prg_id in (#PreserveSingleQuotes(session.prg_list)#)
			and p.RecID=pp.program_id
			and pp.programgroup_id is null
			and pp.programcategory_id=pc.programcategory_id
		&lt;cfif Not IsDefined('session.subset_id') Or session.subset_id eq 0 Or session.subset_id eq 21 Or session.subset_id eq ''&gt;
			and (pc.legacy_code is null or pc.legacy_code not in (333, 334))
		&lt;/cfif&gt;
		order by bigsort, pc.sort, pp.sort
	&lt;/CFQUERY&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#PreserveSingleQuotes(session.prg_list)#</strong><br>
                    

                <hr>
            <b>1 queries found in frmHelp.cfm!</b><br />
            &lt;cfquery name=&quot;def&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	select dt.display_code title_help, d.display_code help
	from [help] h inner join [display] d
			on h.display_id=d.display_id
		left outer join [display] dt
			on h.title_display_id=dt.display_id
	where keyword='#keyword#'
	order by h.help_code
&lt;/cfquery&gt;<br>
                Table: <strong>[help]</strong><br>
				Params:<br>
				
                    <strong>'#keyword#'</strong><br>
                    

                <hr>
            <b>2 queries found in frmincomegrid.cfm!</b><br />
            &lt;cfquery name=&quot;getincome&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT i.incometype_name, i.incometype_varname, i.definition
	FROM &lt;cfif session.subsetGridFlag eq 1&gt;xsubset_xincometype si, &lt;/cfif&gt;xincometype i
	WHERE &lt;cfif session.subsetGridFlag eq 1&gt;si.subset_id=#session.subset_id#
		AND si.incometype_id=i.incometype_id&lt;cfelse&gt;i.exclude_flag=0&lt;/cfif&gt;
	ORDER BY i.sort
&lt;/cfquery&gt;<br>
                Table: <strong>[help]</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;getincomevar&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT i.incometype_varname
		FROM xincometype i
		ORDER BY i.sort
	&lt;/cfquery&gt;<br>
                Table: <strong>[help]</strong><br>
				Params:<br>
				

                <hr>
            <b>2 queries found in frmquestions.cfm!</b><br />
            &lt;cfquery name=&quot;build_array&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT q.question_id, q.pri_sec, q.answerfield, q.type, q.textlength, q.validation, q.dep_formula, q.category, q.order_num, 0 AS options_flag
		FROM (
			SELECT q.question_id, q.question_code, qc.questioncategory_code, a.page_id
			FROM (
				SELECT q.question_id, NULL AS page_id
				FROM (
					SELECT pa.answerfield_id
					FROM subset_program_sum sp, program p, program_answerfield pa, answerfield a
					WHERE sp.subset_id=#session.subset_id#
						AND sp.program_id=p.program_id
						AND (p.state_id IS NULL or p.state_id='#session.st#')
						AND p.active_flag=1
						AND p.program_id=pa.program_id
						AND pa.answerfield_id NOT IN (
							SELECT answerfield_id
							FROM answerfield_subset_partner
							WHERE subset_id=#session.subset_id#
								AND (partner_id is null or partner_id=#session.partner_id#)
								AND background_flag=1
						)
						AND pa.answerfield_id=a.answerfield_id
						AND (a.state_id IS NULL or a.state_id='#session.st#')
					UNION
					SELECT ar.right_answerfield_id as answerfield_id
					FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
					WHERE sp.subset_id=#session.subset_id#
						AND sp.program_id=p.program_id
						AND (p.state_id IS NULL or p.state_id='#session.st#')
						AND p.active_flag=1
						AND p.program_id=pa.program_id
						AND pa.answerfield_id NOT IN (
							SELECT answerfield_id
							FROM answerfield_subset_partner
							WHERE subset_id=#session.subset_id#
								AND (partner_id is null or partner_id=#session.partner_id#)
								AND background_flag=1
						)
						AND pa.answerfield_id=ar.left_answerfield_id
						AND ar.relationship_id=2
						AND ar.right_answerfield_id=a.answerfield_id
						AND (a.state_id IS NULL or a.state_id='#session.st#')
				) AS a, question_answerfield qa, question q
				WHERE a.answerfield_id=qa.answerfield_id
						AND &lt;cfif session.subset_id neq 27 Or session.partner_id neq 8&gt;qa.question_id NOT IN (
							SELECT question_id
							FROM subset_question
							WHERE subset_id=#session.subset_id#
								AND exclude_flag=1
						)
						AND &lt;/cfif&gt;qa.question_id=q.question_id
						AND q.exclude_flag=0
				&lt;cfif session.subset_id neq 27 Or session.partner_id neq 8&gt;UNION
				SELECT q.question_id, sq.page_id
				FROM subset_question sq, question q
				WHERE sq.subset_id=#session.subset_id#
					AND sq.exclude_flag=0
					AND sq.question_id=q.question_id
				&lt;/cfif&gt;UNION
				SELECT q.question_id, NULL AS page_id
				FROM question q
				WHERE q.include_flag=1
					AND q.question_id NOT IN (
						SELECT question_id
						FROM subset_question
						WHERE subset_id=#session.subset_id#
							AND exclude_flag=1
					)
			) AS a, question q, questioncategory qc
			WHERE a.question_id=q.question_id
				AND q.questioncategory_id=qc.questioncategory_id
		) sq, tbl_questions_new q, question qq, questioncategory qc
		WHERE sq.question_id=q.question_id
			AND q.answerfield not in ('zip')
			AND q.client='self'
			AND q.pri_sec='pri'
			AND q.type is not null
			AND q.question_id=qq.question_id
			AND qq.questioncategory_id=qc.questioncategory_id
		ORDER BY qc.sort, qq.sort
	&lt;/cfquery&gt;<br>
                Table: <strong>[help]</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>#session.partner_id#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>#session.partner_id#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;build_array_question_text&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
			select question
			from tbl_questions_new
			where question_id = #build_array.question_id[CurrentRow]#
		&lt;/cfquery&gt;<br>
                Table: <strong>[help]</strong><br>
				Params:<br>
				
                    <strong>#build_array.question_id[CurrentRow]#</strong><br>
                    

                <hr>
            <b>2 queries found in frmquestionssec.cfm!</b><br />
            &lt;cfquery name=&quot;build_array&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT q.question_id, q.pri_sec, q.answerfield, q.type, q.textlength, q.validation, q.dep_formula, q.category, q.order_num, 0 AS options_flag
		FROM (
			SELECT q.question_id, q.question_code, qc.questioncategory_code, a.page_id
			FROM (
				SELECT q.question_id, NULL AS page_id
				FROM (
					SELECT pa.answerfield_id
					FROM subset_program_sum sp, program p, program_answerfield pa, answerfield a
					WHERE sp.subset_id=#session.subset_id#
						AND sp.program_id=p.program_id
						AND (p.state_id IS NULL or p.state_id='#session.st#')
						AND p.active_flag=1
						AND p.program_id=pa.program_id
						AND pa.answerfield_id NOT IN (
							SELECT answerfield_id
							FROM answerfield_subset_partner
							WHERE subset_id=#session.subset_id#
								AND (partner_id is null or partner_id=#session.partner_id#)
								AND background_flag=1
						)
						AND pa.answerfield_id=a.answerfield_id
						AND (a.state_id IS NULL or a.state_id='#session.st#')
					UNION
					SELECT ar.right_answerfield_id as answerfield_id
					FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
					WHERE sp.subset_id=#session.subset_id#
						AND sp.program_id=p.program_id
						AND (p.state_id IS NULL or p.state_id='#session.st#')
						AND p.active_flag=1
						AND p.program_id=pa.program_id
						AND pa.answerfield_id NOT IN (
							SELECT answerfield_id
							FROM answerfield_subset_partner
							WHERE subset_id=#session.subset_id#
								AND (partner_id is null or partner_id=#session.partner_id#)
								AND background_flag=1
						)
						AND pa.answerfield_id=ar.left_answerfield_id
						AND ar.relationship_id=2
						AND ar.right_answerfield_id=a.answerfield_id
						AND (a.state_id IS NULL or a.state_id='#session.st#')
				) AS a, question_answerfield qa, question q
				WHERE a.answerfield_id=qa.answerfield_id
						AND &lt;cfif session.subset_id neq 27 Or session.partner_id neq 8&gt;qa.question_id NOT IN (
							SELECT question_id
							FROM subset_question
							WHERE subset_id=#session.subset_id#
								AND exclude_flag=1
						)
						AND &lt;/cfif&gt;qa.question_id=q.question_id
						AND q.exclude_flag=0
				&lt;cfif session.subset_id neq 27 Or session.partner_id neq 8&gt;UNION
				SELECT q.question_id, sq.page_id
				FROM subset_question sq, question q
				WHERE sq.subset_id=#session.subset_id#
					AND sq.exclude_flag=0
					AND sq.question_id=q.question_id
				&lt;/cfif&gt;UNION
				SELECT q.question_id, NULL AS page_id
				FROM question q
				WHERE q.include_flag=1
					AND q.question_id NOT IN (
						SELECT question_id
						FROM subset_question
						WHERE subset_id=#session.subset_id#
							AND exclude_flag=1
					)
			) AS a, question q, questioncategory qc
			WHERE a.question_id=q.question_id
				AND q.questioncategory_id=qc.questioncategory_id
		) sq, tbl_questions_new q, question qq, questioncategory qc
		WHERE sq.question_id=q.question_id
			AND q.client='self'
			AND q.pri_sec='sec'
			AND q.type is not null
			AND q.question_id=qq.question_id
			AND qq.questioncategory_id=qc.questioncategory_id
		ORDER BY qc.sort, qq.sort
	&lt;/cfquery&gt;<br>
                Table: <strong>[help]</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>#session.partner_id#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>#session.partner_id#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;build_array_question_text&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
			select question
			from tbl_questions_new
			where question_id = #build_array.question_id[CurrentRow]#
		&lt;/cfquery&gt;<br>
                Table: <strong>[help]</strong><br>
				Params:<br>
				
                    <strong>#build_array.question_id[CurrentRow]#</strong><br>
                    

                <hr>
            <b>2 queries found in frmquestionssecdep.cfm!</b><br />
            &lt;cfquery name=&quot;build_array&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT q.question_id, q.pri_sec, q.answerfield, q.type, q.textlength, q.validation, q.dep_formula, q.category, q.order_num, 0 AS options_flag
		FROM (
			SELECT q.question_id, q.question_code, qc.questioncategory_code, a.page_id
			FROM (
				SELECT q.question_id, NULL AS page_id
				FROM (
					SELECT pa.answerfield_id
					FROM subset_program_sum sp, program p, program_answerfield pa, answerfield a
					WHERE sp.subset_id=#session.subset_id#
						AND sp.program_id=p.program_id
						AND (p.state_id IS NULL or p.state_id='#session.st#')
						AND p.active_flag=1
						AND p.program_id=pa.program_id
						AND pa.answerfield_id NOT IN (
							SELECT answerfield_id
							FROM answerfield_subset_partner
							WHERE subset_id=#session.subset_id#
								AND (partner_id is null or partner_id=#session.partner_id#)
								AND background_flag=1
						)
						AND pa.answerfield_id=a.answerfield_id
						AND (a.state_id IS NULL or a.state_id='#session.st#')
					UNION
					SELECT ar.right_answerfield_id as answerfield_id
					FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
					WHERE sp.subset_id=#session.subset_id#
						AND sp.program_id=p.program_id
						AND (p.state_id IS NULL or p.state_id='#session.st#')
						AND p.active_flag=1
						AND p.program_id=pa.program_id
						AND pa.answerfield_id NOT IN (
							SELECT answerfield_id
							FROM answerfield_subset_partner
							WHERE subset_id=#session.subset_id#
								AND (partner_id is null or partner_id=#session.partner_id#)
								AND background_flag=1
						)
						AND pa.answerfield_id=ar.left_answerfield_id
						AND ar.relationship_id=2
						AND ar.right_answerfield_id=a.answerfield_id
						AND (a.state_id IS NULL or a.state_id='#session.st#')
				) AS a, question_answerfield qa, question q
				WHERE a.answerfield_id=qa.answerfield_id
						AND &lt;cfif session.subset_id neq 27 Or session.partner_id neq 8&gt;qa.question_id NOT IN (
							SELECT question_id
							FROM subset_question
							WHERE subset_id=#session.subset_id#
								AND exclude_flag=1
						)
						AND &lt;/cfif&gt;qa.question_id=q.question_id
						AND q.exclude_flag=0
				&lt;cfif session.subset_id neq 27 Or session.partner_id neq 8&gt;UNION
				SELECT q.question_id, sq.page_id
				FROM subset_question sq, question q
				WHERE sq.subset_id=#session.subset_id#
					AND sq.exclude_flag=0
					AND sq.question_id=q.question_id
				&lt;/cfif&gt;UNION
				SELECT q.question_id, NULL AS page_id
				FROM question q
				WHERE q.include_flag=1
					AND q.question_id NOT IN (
						SELECT question_id
						FROM subset_question
						WHERE subset_id=#session.subset_id#
							AND exclude_flag=1
					)
			) AS a, question q, questioncategory qc
			WHERE a.question_id=q.question_id
				AND q.questioncategory_id=qc.questioncategory_id
		) sq, tbl_questions_new q, question qq, questioncategory qc
		WHERE sq.question_id=q.question_id
			AND q.client='self'
			AND q.pri_sec='secdep'
			AND q.type is not null
			AND q.question_id=qq.question_id
			AND qq.questioncategory_id=qc.questioncategory_id
		ORDER BY qc.sort, qq.sort
	&lt;/cfquery&gt;<br>
                Table: <strong>[help]</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>#session.partner_id#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>#session.partner_id#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;build_array_question_text&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
			select question
			from tbl_questions_new
			where question_id = #build_array.question_id[CurrentRow]#
		&lt;/cfquery&gt;<br>
                Table: <strong>[help]</strong><br>
				Params:<br>
				
                    <strong>#build_array.question_id[CurrentRow]#</strong><br>
                    

                <hr>
            <b>1 queries found in frmRecommend.cfm!</b><br />
            &lt;cfquery name=&quot;markseen&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
				UPDATE tbl_user_prgid
				SET unseen=NULL
				WHERE clientnum=#session.clientnum#
					AND prg_id='#prgRec#'
				&lt;/cfquery&gt;<br>
                Table: <strong>[help]</strong><br>
				Params:<br>
				
                    <strong>#session.clientnum#</strong><br>
                    
                    <strong>'#prgRec#'</strong><br>
                    

                <hr>
            <b>2 queries found in frmreportoptions.cfm!</b><br />
            &lt;CFQUERY DATASOURCE=&quot;#application.dbSrc#&quot; NAME=&quot;prgs&quot;&gt;
	select q.program_code, q.bigsort, q.pcsort, q.ppsort, ifnull(pg.sort, 0) groupsort
	from (
		select pp.program_code, pp.programgroup_id, ifnull(pp.supersort, 999999999) bigsort, pc.sort pcsort, pp.sort ppsort
		from tbl_prg_all p, program pp, programcategory pc
		where p.prg_id in (#PreserveSingleQuotes(session.prg_list)#)
			and p.RecID=pp.program_id
			and pp.programcategory_id=pc.programcategory_id
		&lt;cfif Not IsDefined('session.subset_id') Or session.subset_id eq 0 Or session.subset_id eq 21 Or session.subset_id eq ''&gt;
			and (pc.legacy_code is null or pc.legacy_code not in (333, 334))
		&lt;/cfif&gt;
		) q left outer join programgroup pg
			on q.programgroup_id=pg.programgroup_id
	order by groupsort, q.bigsort, q.pcsort, q.ppsort
&lt;/CFQUERY&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#PreserveSingleQuotes(session.prg_list)#</strong><br>
                    

                <hr>
            &lt;CFQUERY DATASOURCE=&quot;#application.dbSrc#&quot; NAME=&quot;buffs&quot;&gt;
		select q.program_code, q.bigsort, q.pcsort, q.ppsort, ifnull(pg.sort, 0) groupsort
		from (
			select pp.program_code, pp.programgroup_id, ifnull(pp.supersort, 999999999) bigsort, pc.sort pcsort, pp.sort ppsort
			from tbl_prg_all p, program pp, programcategory pc
			where p.prg_id in (#PreserveSingleQuotes(session.buff_list)#)
				and p.RecID=pp.program_id
				and pp.programcategory_id=pc.programcategory_id
			&lt;cfif Not IsDefined('session.subset_id') Or session.subset_id eq 0 Or session.subset_id eq 21 Or session.subset_id eq ''&gt;
				and (pc.legacy_code is null or pc.legacy_code not in (333, 334))
			&lt;/cfif&gt;
			) q left outer join programgroup pg
				on q.programgroup_id=pg.programgroup_id
		order by groupsort, q.bigsort, q.pcsort, q.ppsort
	&lt;/CFQUERY&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#PreserveSingleQuotes(session.buff_list)#</strong><br>
                    

                <hr>
            <b>5 queries found in frmskipgrid.cfm!</b><br />
            &lt;cfquery name=&quot;getincome&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT i.incometype_name, i.incometype_varname, i.definition
		FROM &lt;cfif session.subsetGridFlag eq 1&gt;xsubset_xincometype si, &lt;/cfif&gt;xincometype i
		WHERE &lt;cfif session.subsetGridFlag eq 1&gt;si.subset_id=#session.subset_id#
			AND si.incometype_id=i.incometype_id&lt;cfelse&gt;i.exclude_flag=0&lt;/cfif&gt;
		ORDER BY i.sort
	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;getasset&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT a.assettype_name, a.assettype_varname, a.definition
		FROM &lt;cfif session.subsetGridFlag eq 1&gt;xsubset_xassettype sa, &lt;/cfif&gt;xassettype a
		WHERE &lt;cfif session.subsetGridFlag eq 1&gt;sa.subset_id=#session.subset_id#
			AND sa.assettype_id=a.assettype_id&lt;cfelse&gt;a.exclude_flag=0&lt;/cfif&gt;
		ORDER BY a.sort
	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;getincass&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT i.incass_varname, i.#incassColName#_text AS incass_text, i.work_flag
		FROM xsubset_xincass AS si, xincass AS i
		WHERE si.subset_id=#session.subset_id#
			AND si.incass_id=i.incass_id
		ORDER BY i.sort
	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#incassColName#</strong><br>
                    
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;getincomevar&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT i.incometype_varname
		FROM xincometype i
		ORDER BY i.sort
	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;getassetvar&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
			SELECT a.assettype_varname
			FROM xassettype a
			ORDER BY a.sort
		&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				

                <hr>
            <b>2 queries found in full.cfm!</b><br />
            &lt;cfquery name=&quot;zipstate&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
			select state_id
			from zip
			where zipcode='#zip#'
				and valid=1
		&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#zip#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;getClient&quot; datasource=&quot;#application.dbSrcOE#&quot;&gt;
		SELECT ext_client_id
		FROM CLIENT
		WHERE client_id=#session.client_id#
	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#session.client_id#</strong><br>
                    

                <hr>
            <b>2 queries found in getrpt1.cfm!</b><br />
            &lt;cfquery name=&quot;GetUserData&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

SELECT wantChips, County, ST, ZIP, City

FROM tbl_user_ans

WHERE clientnum = #clientnum#

&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#clientnum#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;GetUserPrgs&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

SELECT prg_id

FROM tbl_user_prgid

WHERE clientnum = #clientnum#

&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#clientnum#</strong><br>
                    

                <hr>
            <b>1 queries found in jsZipWrite.cfm!</b><br />
            &lt;cfquery name=&quot;zip&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		select zipcode
		from zip
		where state_id='#stateID#'
			and valid=1
		order by zipcode
	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#stateID#'</strong><br>
                    

                <hr>
            <b>1 queries found in lisapp/index.cfm!</b><br />
            &lt;cfquery name=&quot;cobrandInfo&quot; datasource=&quot;#application.dbSrcOE#&quot;&gt;
		select o.organization_type_id
		from ORGANIZATION o 
		WHERE o.id=#session.org_id#
	&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#session.org_id#</strong><br>
                    

                <hr>
            <b>1 queries found in liscenter/index.cfm!</b><br />
            &lt;cfquery name=&quot;cobrandInfo&quot; datasource=&quot;#application.dbSrcOE#&quot;&gt;
		select o.organization_type_id
		from ORGANIZATION o 
		WHERE o.id=#session.org_id#
	&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#session.org_id#</strong><br>
                    

                <hr>
            <b>1 queries found in mapSSAdata2.cfc!</b><br />
            &lt;cfquery name=&quot;fieldtypes&quot; dbtype=&quot;query&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
					SELECT at.answerfieldtype_id, a.answerfield
         			FROM answerfield a 
         			INNER JOIN subset_answerfield sa ON a.answerfield_id = sa.answerfield_id 
					INNER JOIN answerfieldtype at ON a.answerfieldtype_id = at.answerfieldtype_id 
					where subset_id = 41
          			ORDER BY a.answerfield 
			&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				

                <hr>
            <b>1 queries found in offices.cfm!</b><br />
            &lt;cfquery name=&quot;ep&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	select e.entrypoint_id
	from entrypoint_entrypointgroup eg, entrypoint e
	where eg.entrypointgroup_id=#group_id#
		and eg.entrypoint_id=e.entrypoint_id
		and e.active_flag=1
		and e.state_id='#localStateID#'
	order by e.city, e.zipcode
&lt;/cfquery&gt;<br>
                Table: <strong>entrypoint_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>#group_id#</strong><br>
                    
                    <strong>'#localStateID#'</strong><br>
                    

                <hr>
            <b>1 queries found in pl_cf.cfm!</b><br />
            &lt;cfquery name=&quot;wrapper&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT *
	FROM wrapper w
	LEFT JOIN tbl_partner t ON t.wrapper_id = w.wrapper_id
	WHERE wrapper_status = 1
	ORDER BY partner_name
&lt;/cfquery&gt;<br>
                Table: <strong>entrypoint_entrypointgroup</strong><br>
				Params:<br>
				

                <hr>
            <b>7 queries found in printformcontrol.cfm!</b><br />
            &lt;cfquery name=&quot;codeString&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
			select p.prg_nm
			from tbl_prg_all p
			where p.prg_id = '#codeProgram#'
		&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#codeProgram#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;codeString&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
			select p.prg_nm, t.tag_name
			from tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
			where p.prg_id = '#codeProgram#'
				and p.recid=pf.program_id
				and pf.sort=#codeSort#
				and pf.form_id=f.form_id
				and (f.state_id is null or f.state_id='#session.st#')
				and f.form_id=ft.form_id
				and ft.formtype_id=#codeType#
				and ft.active=1
				and f.formtag_id=t.formtag_id
				and t.formclass_id=#codeClass#
			order by p.prg_id, pf.sort, ft.formtype_id, t.formclass_id
		&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#codeProgram#'</strong><br>
                    
                    <strong>#codeSort#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#codeType#</strong><br>
                    
                    <strong>#codeClass#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;codeString&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
			select p.prg_nm
			from tbl_prg_all p
			where p.prg_id = '#pcodeProgram#'
		&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#pcodeProgram#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;codeString&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
			select p.prg_nm, t.tag_name
			from tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
			where p.prg_id = '#pcodeProgram#'
				and p.recid=pf.program_id
				and pf.sort=#pcodeSort#
				and pf.form_id=f.form_id
				and (f.state_id is null or f.state_id='#session.st#')
				and f.form_id=ft.form_id
				and ft.formtype_id=#pcodeType#
				and ft.active=1
				and f.formtag_id=t.formtag_id
				and t.formclass_id=#pcodeClass#
			order by p.prg_id, pf.sort, ft.formtype_id, t.formclass_id
		&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#pcodeProgram#'</strong><br>
                    
                    <strong>#pcodeSort#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#pcodeType#</strong><br>
                    
                    <strong>#pcodeClass#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;codeString&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
			select p.prg_nm
			from tbl_prg_all p
			where p.prg_id = '#ncodeProgram#'
		&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#ncodeProgram#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;codeString&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
			select p.prg_nm, t.tag_name
			from tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
			where p.prg_id = '#ncodeProgram#'
				and p.recid=pf.program_id
				and pf.sort=#ncodeSort#
				and pf.form_id=f.form_id
				and (f.state_id is null or f.state_id='#session.st#')
				and f.form_id=ft.form_id
				and ft.formtype_id=#ncodeType#
				and ft.active=1
				and f.formtag_id=t.formtag_id
				and t.formclass_id=#ncodeClass#
			order by p.prg_id, pf.sort, ft.formtype_id, t.formclass_id
		&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#ncodeProgram#'</strong><br>
                    
                    <strong>#ncodeSort#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#ncodeType#</strong><br>
                    
                    <strong>#ncodeClass#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;codeStringer&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
				select ft.string
				from tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
				where p.prg_id = '#codeProgram#'
					and p.recid=pf.program_id
					and pf.sort=#codeSort#
					and pf.form_id=f.form_id
					and (f.state_id is null or f.state_id='#session.st#')
					and f.form_id=ft.form_id
					and ft.formtype_id=2
					and ft.active=1
					and f.formtag_id=t.formtag_id
					and t.formclass_id=#codeClass#
				order by p.prg_id, pf.sort, ft.formtype_id, t.formclass_id
			&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#codeProgram#'</strong><br>
                    
                    <strong>#codeSort#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#codeClass#</strong><br>
                    

                <hr>
            <b>1 queries found in printforms.cfm!</b><br />
            &lt;cfquery name=&quot;codeString&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
			select p.prg_id, pf.sort, ft.formtype_id, t.formclass_id, ft.string, t.tag_name
			from tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
			where p.prg_id = '#codeProgram#'
				and p.recid=pf.program_id
				and pf.sort=#codeSort#
				and pf.form_id=f.form_id
				and (f.state_id is null or f.state_id='#session.st#')
				and f.form_id=ft.form_id
				and ft.formtype_id=#codeType#
				and ft.active=1
				and f.formtag_id=t.formtag_id
				and t.formclass_id=#codeClass#
			order by p.prg_id, pf.sort, ft.formtype_id, t.formclass_id
		&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#codeProgram#'</strong><br>
                    
                    <strong>#codeSort#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#codeType#</strong><br>
                    
                    <strong>#codeClass#</strong><br>
                    

                <hr>
            <b>1 queries found in printmerge.cfm!</b><br />
            &lt;cfquery name=&quot;getstring&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
			select ft.string
			from tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
			where p.prg_id = '#codeProgram#'
				and p.recid=pf.program_id
				and pf.sort=#codeSort#
				and pf.form_id=f.form_id
				and (f.state_id is null or f.state_id='#session.st#')
				and f.form_id=ft.form_id
				and ft.formtype_id=1
				and ft.active=1
				and f.formtag_id=t.formtag_id
				and t.formclass_id=#codeClass#
		&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#codeProgram#'</strong><br>
                    
                    <strong>#codeSort#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#codeClass#</strong><br>
                    

                <hr>
            <b>9 queries found in procBatchScreening.cfm!</b><br />
            &lt;cfquery name=&quot;BatchQuery&quot;  datasource=&quot;#application.dbSrc#&quot;  &gt;

	SELECT     *

	FROM         kpdata2

&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;mapfields&quot; dbtype=&quot;query&quot; &gt;

	SELECT     *

	FROM         BatchQuery

	WHERE BDTID='#bdtid#'

&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#bdtid#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;subsetInfo&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

		SELECT subsettype_id, subset_name, subset_longname, subset_description, subset_text,

			all_flag, grid_flag, schip_flag, drug_flag, optional_flag, rec_flag, eform_flag

		FROM xsubset

		WHERE subset_id=#session.subset_id#

	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;subsetPartnerInfo&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

		SELECT resultpage_id

		FROM subset_partner

		WHERE subset_id=#session.subset_id#

			AND partner_id=#session.partner_id#

			AND resultpage_id IS NOT NULL

	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>#session.partner_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;helperPrg&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

		SELECT p.prg_id AS helper_prg_id

		FROM subset_program_base spb RIGHT OUTER JOIN subset_program_sum sps

				ON spb.subset_id=sps.subset_id AND spb.program_id=sps.program_id

			INNER JOIN tbl_prg_all p

				ON sps.program_id=p.RecID

		WHERE sps.subset_id=#session.subset_id#

			AND spb.subset_id IS NULL

		ORDER BY p.prg_id

	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;insertprograms&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;

		INSERT INTO screening_program

			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)

		VALUES

			(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenAdjustedVal#, 0, 0)

	&lt;/CFQUERY&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#</strong><br>
                    
                    <strong>#unseenAdjustedVal#</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;insertchips&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;

		INSERT INTO screening_program

			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)

		VALUES

			(#session.screening_id#, #StructFind(application.prgvars, '103-309-2191-FD-FD')#, #unseenVal#, 0, 0)

	&lt;/CFQUERY&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, '103-309-2191-FD-FD')#</strong><br>
                    
                    <strong>#unseenVal#</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;insertgeneric&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;

		INSERT INTO screening_program

			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)

		VALUES

			(#session.screening_id#, #StructFind(application.prgvars, 'XXX-311-2387-FD-FD')#, #unseenVal#, 0, 0)

	&lt;/CFQUERY&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, 'XXX-311-2387-FD-FD')#</strong><br>
                    
                    <strong>#unseenVal#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;insertbuffers&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;

		INSERT INTO screening_program

			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)

		VALUES

			(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenVal#, 1, 0)

	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#</strong><br>
                    
                    <strong>#unseenVal#</strong><br>
                    

                <hr>
            <b>7 queries found in procBatchSSASubmission.cfm!</b><br />
            &lt;cfquery name=&quot;CLIENTIDQUERY&quot;  datasource=&quot;#batch_datasrc#&quot;  &gt;
	SELECT   client_id
	FROM         
	&lt;cfif partner_id eq 23&gt;
	 bdtssabatch
	&lt;cfelseif partner_id eq 29&gt;
	 epicssabatch
	&lt;cfelse&gt;
	epicssabatch
	&lt;/cfif&gt; 
	order by client_id desc
&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;BatchQuery&quot;  datasource=&quot;#batch_datasrc#&quot;  &gt;
	SELECT    bdtssabatch_id, BE_INS_POL_AMT,
	BE_CLNT_OTH_INCM_XND,be_clnt_oth_incm_amt,
	BE_RES_BANK_ACC_XND,
	BE_RES_INVST_XND,
	BE_RES_CSH_XND,
	BE_CLNT_INS_POL_XND,	BE_NONCL_INS_POL_XND,BE_CLNT_CHG_ADDR_SW,BE_CLNT_COSSN,BE_CLNT_DOB_DAY,BE_CLNT_DOB_MONTH,BE_CLNT_DOB_YEAR,BE_CLNT_EARN_AMT,BE_CLNT_EARN_LOSS_XND,BE_CLNT_EARN_WGS_AMT,BE_CLNT_EARN_WGS_XND,BE_CLNT_FNM,BE_CLNT_LNM,BE_CLNT_LOSS_AMT,BE_CLNT_MAIL_ADDRLN_1,BE_CLNT_MAIL_ADDRLN_2,BE_CLNT_MAIL_ADDRLN_3,BE_CLNT_MAIL_ADDR_CITY,BE_CLNT_MAIL_ADDR_ST,BE_CLNT_MAIL_ADDR_ZIP5,BE_CLNT_MAIL_APT_NO,BE_CLNT_MNM,BE_CLNT_OTH_INCM_TYP,BE_CLNT_PAY_DISBLTY_XND,BE_CLNT_PENS_ANNUIT_AMT,BE_CLNT_PENS_ANNUIT_XND,BE_CLNT_PHNAREA,BE_CLNT_PHNEXCH,BE_CLNT_PHNNUM,BE_CLNT_RR_INCM_AMT,BE_CLNT_RR_INCM_XND,BE_CLNT_SFX,BE_CLNT_SS_BENEFITS_AMT,BE_CLNT_SS_BENEFITS_XND,BE_CLNT_STOP_WRK_MONTH,BE_CLNT_STOP_WRK_XND,BE_CLNT_STOP_WRK_YEAR,BE_CLNT_SUB_SW,BE_CLNT_VA_BENEFITS_AMT,BE_CLNT_VA_BENEFITS_XND,BE_CLNT_WRKD_L2YR_XND,BE_CNTCT_FNM,BE_CNTCT_LNM,BE_CNTCT_PHNAREA,BE_CNTCT_PHNEXCH,BE_CNTCT_PHNNUM,BE_EXPENSE_AMT,BE_EXPENSE_XND,BE_INCM_DECRS_XND,BE_NONCL_COSSN,BE_NONCL_DOB_DAY,BE_NONCL_DOB_MONTH,BE_NONCL_DOB_YEAR,BE_NONCL_EARN_AMT,BE_NONCL_EARN_LOSS_XND,BE_NONCL_EARN_WGS_AMT,BE_NONCL_EARN_WGS_XND,BE_NONCL_FNM,BE_NONCL_LNM,BE_NONCL_LOSS_AMT,BE_NONCL_MNM,BE_NONCL_OTH_INCM_AMT,BE_NONCL_OTH_INCM_TYP,BE_NONCL_OTH_INCM_XND,BE_NONCL_PAY_DISBLTY_XND,BE_NONCL_PENS_ANNUIT_AMT,BE_NONCL_PENS_ANNUIT_XND,BE_NONCL_RR_INCM_AMT,BE_NONCL_RR_INCM_XND,BE_NONCL_SFX,BE_NONCL_SS_BENEFITS_AMT,BE_NONCL_SS_BENEFITS_XND,BE_NONCL_STOP_WRK_MONTH,BE_NONCL_STOP_WRK_XND,BE_NONCL_STOP_WRK_YEAR,BE_NONCL_SUB_SW,BE_NONCL_VA_BENEFITS_AMT,BE_NONCL_VA_BENEFITS_XND,BE_NONCL_WRKD_L2YR_XND,BE_RESTT_XND,BE_RES_BANK_ACC_AMT,BE_RES_CSH_AMT,BE_RES_INVST_AMT,BE_CLNT_BUEXP_XND as BE_CLNT_BUEXP_SW,BE_NONCL_BUEXP_XND as BE_NONCL_BUEXP_SW,BE_RLTVS_SUP,BE_SAV_LMT_XND,BE_SAV_LMT_XND1,BE_THRD_ADDRLN_1,BE_THRD_ADDRLN_2,BE_THRD_ADDRLN_3,BE_THRD_ADDR_CITY,BE_THRD_ADDR_ST,BE_THRD_ADDR_ZIP5,BE_THRD_APT_NO,BE_THRD_FNM,BE_THRD_LNM,BE_THRD_PHNAREA,BE_THRD_PHNEXCH,BE_THRD_PHNNUM,BE_THRD_REL, BE_THRD_REL_OTH,BE_THRD_SUB_SW,BE_WGS_DECRS_XND,BE_WH_APPLY,CLIENT_ID,CT_LIVE,CT_MAIL_XND,CT_MRTL_STUS,CT_OLDER_XND,CT_RECEIVE_MEDICARE_XND,CT_SS_DISBLTY_XND,CT_THRD_PTY_XND
	FROM         
	&lt;cfif partner_id eq 23&gt;
	 bdtssabatch
	&lt;cfelseif partner_id eq 29&gt;
	 epicssabatch
	&lt;cfelse&gt;
	epicssabatch
	&lt;/cfif&gt; 
	where client_id = '#CLIENTIDQUERY.client_id#'
&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#CLIENTIDQUERY.client_id#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;subsetInfo&quot; datasource=&quot;#session.datasrc#&quot;&gt;
		SELECT subsettype_id, subset_name, subset_longname, subset_description, subset_text,
			all_flag, grid_flag, schip_flag, drug_flag, optional_flag, rec_flag, eform_flag
		FROM xsubset
		WHERE subset_id=#session.subset_id#
	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;subsetPartnerInfo&quot; datasource=&quot;#session.datasrc#&quot;&gt;
		SELECT resultpage_id
		FROM subset_partner
		WHERE subset_id=#session.subset_id#
			AND partner_id=#session.partner_id#
			AND resultpage_id IS NOT NULL
	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>#session.partner_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;status&quot;  datasource=&quot;#session.datasrc#&quot;  &gt;
	select * from screening_submission where screening_id = #session.screening_id#
&lt;/cfquery&gt;<br>
                Table: <strong>screening_submission</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;getsource&quot; datasource=&quot;#batch_datasrc#&quot;&gt;
		Select BDTSource from bdtssabatch
where bdtssabatch_id = #BatchQuery.bdtssabatch_id#
	&lt;/cfquery&gt;<br>
                Table: <strong>screening_submission</strong><br>
				Params:<br>
				
                    <strong>#BatchQuery.bdtssabatch_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;insert_result&quot; datasource=&quot;#batch_datasrc#&quot;&gt;
		INSERT INTO batch_submission
			(screening_id, source, status_message,date_time, batch_id, client_id)
		VALUES
			(#session.screening_id#,'#source#','#status_message#',#CREATEODBCDATETIME(now())#,#batch_id#,'#BatchQuery.client_id#' )
	&lt;/cfquery&gt;<br>
                Table: <strong>screening_submission</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>'#source#'</strong><br>
                    
                    <strong>'#status_message#'</strong><br>
                    
                    <strong>#CREATEODBCDATETIME(now())#</strong><br>
                    
                    <strong>#batch_id#</strong><br>
                    
                    <strong>'#BatchQuery.client_id#'</strong><br>
                    

                <hr>
            <b>9 queries found in procbuffer.cfm!</b><br />
            &lt;CFQUERY NAME=&quot;sec8&quot; DATASOURCE = &quot;#application.dbSrc#&quot;&gt;
SELECT mem#session.no_hh_members# AS record
FROM tbl_inc_new
WHERE tbl_nm='section 8' AND st='#session.st#'
&lt;/CFQUERY&gt;<br>
                Table: <strong>screening_submission</strong><br>
				Params:<br>
				
                    <strong>#session.no_hh_members#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;PH&quot; DATASOURCE = &quot;#application.dbSrc#&quot;&gt;
SELECT mem#session.no_hh_members# AS record
FROM tbl_inc_new
WHERE tbl_nm='public housing' AND st='#session.st#'
&lt;/CFQUERY&gt;<br>
                Table: <strong>screening_submission</strong><br>
				Params:<br>
				
                    <strong>#session.no_hh_members#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;weather&quot; DATASOURCE = &quot;#application.dbSrc#&quot;&gt;
	SELECT mem#session.no_hh_members# AS record
	FROM tbl_inc_new
	WHERE tbl_nm='WEATHER' AND st='#session.st#'
	&lt;/CFQUERY&gt;<br>
                Table: <strong>screening_submission</strong><br>
				Params:<br>
				
                    <strong>#session.no_hh_members#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;liheap&quot; DATASOURCE = &quot;#application.dbSrc#&quot;&gt;
SELECT mem#session.no_hh_members# AS record
FROM tbl_inc_new
WHERE tbl_nm='liheap' AND st='#session.st#'
&lt;/CFQUERY&gt;<br>
                Table: <strong>screening_submission</strong><br>
				Params:<br>
				
                    <strong>#session.no_hh_members#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;lasset&quot; datasource = &quot;#application.dbSrc#&quot;&gt;
SELECT mem#session.no_hh_members# AS tbl
FROM tbl_inc_new
WHERE tbl_nm='LASSET' AND st='#session.st#'
&lt;/cfquery&gt;<br>
                Table: <strong>screening_submission</strong><br>
				Params:<br>
				
                    <strong>#session.no_hh_members#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME = &quot;build_income_array&quot; DATASOURCE = &quot;#application.dbSrc#&quot;&gt;
	SELECT mem1,mem2,mem3,mem4,mem5,mem6,mem7,mem8
	FROM tbl_inc_new
&lt;/CFQUERY&gt;<br>
                Table: <strong>screening_submission</strong><br>
				Params:<br>
				

                <hr>
            &lt;CFQUERY NAME = &quot;build_income_array&quot; DATASOURCE = &quot;#application.dbSrc#&quot;&gt;
	SELECT mem1,mem2,mem3,mem4,mem5,mem6,mem7,mem8, proc_id
	FROM tbl_inc_new
	ORDER BY proc_id
	&lt;/CFQUERY&gt;<br>
                Table: <strong>screening_submission</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;rules&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT r.prg_id, r.elig_rule, p.pri_sec
	FROM tbl_rules r, tbl_prg_all p
	WHERE r.prg_id = p.prg_id
		AND r.prg_id in (
			select p.prg_id
			from tbl_prg_all p, program_answerfield pa
			where (p.st='#session.st#' OR p.st='FD')
				and p.RecID=pa.program_id
			group by p.prg_id
		)
	ORDER BY p.pri_sec, r.prg_id
&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#session.st#'</strong><br>
                    

                <hr>
            &lt;CFQUERY DATASOURCE=&quot;#application.dbSrc#&quot; NAME=&quot;prgs&quot;&gt;
SELECT prg_id, prg_nm, order_num, st, Cat_ID, major_cat, id_number
	FROM tbl_prg_all, tbl_major_cat_list
	WHERE tbl_major_cat_list.id_number = tbl_prg_all.Cat_ID and prg_id IN (#preservesinglequotes(prg_list)#)
	ORDER BY order_num
&lt;/CFQUERY&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#preservesinglequotes(prg_list)#</strong><br>
                    

                <hr>
            <b>1 queries found in procDrugQuestions.cfm!</b><br />
            &lt;CFQUERY NAME=&quot;qryGeneric&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
			select aa.answerfield
			from answerfield_relationship ar, answerfield aa
			where ar.right_answerfield_id=#afobj.id#
				and ar.relationship_id=1
				and ar.left_answerfield_id=aa.answerfield_id
		&lt;/CFQUERY&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>#afobj.id#</strong><br>
                    

                <hr>
            <b>5 queries found in proceligibility.cfm!</b><br />
            &lt;cfquery name=&quot;helperPrg&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT p.prg_id AS helper_prg_id
		FROM subset_program_base spb RIGHT OUTER JOIN subset_program_sum sps
				ON spb.subset_id=sps.subset_id AND spb.program_id=sps.program_id
			INNER JOIN tbl_prg_all p
				ON sps.program_id=p.RecID
		WHERE sps.subset_id=#session.subset_id#
			AND spb.subset_id IS NULL
		ORDER BY p.prg_id
	&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;insertprograms&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenAdjustedVal#, 0, 0)
	&lt;/CFQUERY&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#</strong><br>
                    
                    <strong>#unseenAdjustedVal#</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;insertchips&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #StructFind(application.prgvars, '103-309-2191-FD-FD')#, #unseenVal#, 0, 0)
	&lt;/CFQUERY&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, '103-309-2191-FD-FD')#</strong><br>
                    
                    <strong>#unseenVal#</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;insertgeneric&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #StructFind(application.prgvars, 'XXX-311-2387-FD-FD')#, #unseenVal#, 0, 0)
	&lt;/CFQUERY&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, 'XXX-311-2387-FD-FD')#</strong><br>
                    
                    <strong>#unseenVal#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;insertbuffers&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenVal#, 1, 0)
	&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#</strong><br>
                    
                    <strong>#unseenVal#</strong><br>
                    

                <hr>
            <b>3 queries found in procMedicareEnroll.cfm!</b><br />
            &lt;cfquery name=&quot;GetShip_Code&quot; datasource=&quot;#application.dbSrcOE#&quot;&gt;
Select ship_code from ORGANIZATION where id = '#session.org_id#'
&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>'#session.org_id#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;LogTrans&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
Insert into 
tbl_user_trans
(clientnum, DNumber)
Values
('#session.clientnum#','#SponsorID#')
&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>'#session.clientnum#'</strong><br>
                    
                    <strong>'#SponsorID#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;GetTrans&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
Select Max(trans_id) as TransNum from tbl_user_trans
&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				

                <hr>
            <b>2 queries found in procMedicareResults.cfm!</b><br />
            &lt;cfquery name=&quot;GetSession&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
select urltoken
from tbl_user_trans
where trans_id = '#TransID#'
&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>'#TransID#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;GetPrgs&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
Insert into 
tbl_user_ta
(clientnum, ConfirmationNumber, SubmitDate, FirstName, LastName, DOB, Zip, SponsorID, SourceID, ReferringID, TransID)
Values
('#session.clientnum#','#ConfirmationNumber#','#SubmitDate#','#FirstName#','#LastName#','#DOB#','#Zip#','#SponsorID#','#SourceID#','#ReferringID#','#TransID#')
&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>'#session.clientnum#'</strong><br>
                    
                    <strong>'#ConfirmationNumber#'</strong><br>
                    
                    <strong>'#SubmitDate#'</strong><br>
                    
                    <strong>'#FirstName#'</strong><br>
                    
                    <strong>'#LastName#'</strong><br>
                    
                    <strong>'#DOB#'</strong><br>
                    
                    <strong>'#Zip#'</strong><br>
                    
                    <strong>'#SponsorID#'</strong><br>
                    
                    <strong>'#SourceID#'</strong><br>
                    
                    <strong>'#ReferringID#'</strong><br>
                    
                    <strong>'#TransID#'</strong><br>
                    

                <hr>
            <b>7 queries found in procOptionalQuestions.cfm!</b><br />
            &lt;cfquery name=&quot;rob&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT ifnull(RACE, 'NULL') BRACE, count(*) CRACE
	FROM tbl_user_ans
	group by RACE
	order by RACE
&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;molchon&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT ifnull(LEARN, 'NULL') BLEARN, count(*) CLEARN
	FROM tbl_user_ans
	group by LEARN
	ORDER BY LEARN
&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;tmolchon&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
SELECT MIN(END_TIME) mindate, MAX(END_TIME) maxdate
FROM tbl_user_ans
WHERE RACE IS NOT NULL AND RACE &lt;&gt; ''
&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;bmolchon&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
SELECT MIN(END_TIME) mindate, MAX(END_TIME) maxdate
FROM tbl_user_ans
WHERE LEARN IS NOT NULL AND LEARN &lt;&gt; ''
&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;rmolchon&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
SELECT MIN(END_TIME) mindate, MAX(END_TIME) maxdate
FROM tbl_user_ans
WHERE LEARN IS NULL AND RACE IS NULL
&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;amolchon&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
SELECT MIN(END_TIME) mindate, MAX(END_TIME) maxdate
FROM tbl_user_ans
WHERE LEARN = '' AND RACE = ''
&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;survey&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
SELECT CLIENTNUM, COUNTY, ST, ZIP, DOB, CITIZEN, WORK_STATUS, END_TIME, RACE, LEARN, POVERTYINDEX, IDNUMBER
FROM tbl_user_ans
WHERE CLIENTNUM + 51 &gt; (select max(CLIENTNUM) from tbl_user_ans)
	or (CLIENTNUM &gt; 19670000 AND CLIENTNUM &lt; 19680000)
ORDER BY CLIENTNUM DESC
&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				

                <hr>
            <b>7 queries found in procShadow.cfm!</b><br />
            &lt;cfquery name=&quot;subsetInfo&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT subsettype_id, subset_name, subset_longname, subset_description, subset_text,
			all_flag, grid_flag, schip_flag, drug_flag, optional_flag, rec_flag, eform_flag
		FROM xsubset
		WHERE subset_id=#session.subset_id#
	&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;subsetPartnerInfo&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT resultpage_id
		FROM subset_partner
		WHERE subset_id=#session.subset_id#
			AND partner_id=#session.partner_id#
			AND resultpage_id IS NOT NULL
	&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>#session.partner_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;helperPrg&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT p.prg_id AS helper_prg_id
		FROM subset_program_base spb RIGHT OUTER JOIN subset_program_sum sps
				ON spb.subset_id=sps.subset_id AND spb.program_id=sps.program_id
			INNER JOIN tbl_prg_all p
				ON sps.program_id=p.RecID
		WHERE sps.subset_id=#session.subset_id#
			AND spb.subset_id IS NULL
		ORDER BY p.prg_id
	&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;insertprograms&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenAdjustedVal#, 0, 0)
	&lt;/CFQUERY&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#</strong><br>
                    
                    <strong>#unseenAdjustedVal#</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;insertchips&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #StructFind(application.prgvars, '103-309-2191-FD-FD')#, #unseenVal#, 0, 0)
	&lt;/CFQUERY&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, '103-309-2191-FD-FD')#</strong><br>
                    
                    <strong>#unseenVal#</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;insertgeneric&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #StructFind(application.prgvars, 'XXX-311-2387-FD-FD')#, #unseenVal#, 0, 0)
	&lt;/CFQUERY&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, 'XXX-311-2387-FD-FD')#</strong><br>
                    
                    <strong>#unseenVal#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;insertbuffers&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenVal#, 1, 0)
	&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#</strong><br>
                    
                    <strong>#unseenVal#</strong><br>
                    

                <hr>
            <b>2 queries found in redirect.cfm!</b><br />
            &lt;cfquery name=&quot;urlinfo&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT p.protocol, u.url, u.active_flag
		FROM url u  LEFT OUTER JOIN protocol p 
			ON u.protocol_id=p.protocol_id
		WHERE u.url_id=#id#
	&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;logClick&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
				INSERT INTO click WITH (ROWLOCK)
					(url_id, screening_id, prev_screening_id, cfid, cftoken, source_id, org_id, partner_id, subset_id, language_id,
						access_id, oe_client_id, oe_user_id, preset_state_id, test_flag, target_flag, oe_flag, click_datetime)
				VALUES
					(#id#, #lsScreeningID#, #lsPrevScreeningID#, #session.cfid#, #session.cftoken#, #lsSourceID#, #lsOrgID#,
						#lsPartnerID#, #lsSubsetID#, #PreserveSingleQuotes(lsLanguageID)#, #lsAccessID#, #lsClientID#, #lsUserID#,
						#PreserveSingleQuotes(lsPresetStateID)#, #lsTestID#, #tgt#, #oe#, #CreateODBCDateTime(Now())#)
			&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#id#</strong><br>
                    
                    <strong>#lsScreeningID#</strong><br>
                    
                    <strong>#lsPrevScreeningID#</strong><br>
                    
                    <strong>#session.cfid#</strong><br>
                    
                    <strong>#session.cftoken#</strong><br>
                    
                    <strong>#lsSourceID#</strong><br>
                    
                    <strong>#lsOrgID#</strong><br>
                    
                    <strong>#lsPartnerID#</strong><br>
                    
                    <strong>#lsSubsetID#</strong><br>
                    
                    <strong>#PreserveSingleQuotes(lsLanguageID)#</strong><br>
                    
                    <strong>#lsAccessID#</strong><br>
                    
                    <strong>#lsClientID#</strong><br>
                    
                    <strong>#lsUserID#</strong><br>
                    
                    <strong>#PreserveSingleQuotes(lsPresetStateID)#</strong><br>
                    
                    <strong>#lsTestID#</strong><br>
                    
                    <strong>#tgt#</strong><br>
                    
                    <strong>#oe#</strong><br>
                    
                    <strong>#CreateODBCDateTime(Now())#</strong><br>
                    

                <hr>
            <b>1 queries found in rules.cfm!</b><br />
            &lt;cfquery name=&quot;programs&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	select sp.program_id, p.st, p.prg_id, p.prg_nm
	from view_subset_program_sum sp, tbl_prg_all p
	where sp.subset_id=&lt;cfif IsDefined(&quot;session.subset_id&quot;)&gt;#session.subset_id#&lt;cfelse&gt;0&lt;/cfif&gt;
		and sp.program_id=p.RecID
		&lt;cfif IsDefined('session.st') and session.st neq ''&gt;
		and p.st in ('FD', '#session.st#')
		&lt;/cfif&gt;
	order by p.st, p.prg_nm
&lt;/cfquery&gt;<br>
                Table: <strong>view_subset_program_sum</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    

                <hr>
            <b>1 queries found in rules_test.cfm!</b><br />
            &lt;cfquery name=&quot;rules&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	select r.prg_id, r.elig_rule, r.pri_sec
    from tbl_prg_all p, tbl_rules r
	where p.RecID=#program_id#
		and p.prg_id=r.prg_id
	order by r.pri_sec, r.RecID
&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#program_id#</strong><br>
                    

                <hr>
            <b>2 queries found in rx/dspfiles/dspConsiderOptions.cfm!</b><br />
            &lt;cfquery name=&quot;qryActions&quot; datasource=&quot;#session.datasrc#&quot;&gt;

		SELECT      pt.actions

		FROM        programtext pt

		WHERE     programtext_id = (#arrayActions[count]#)

	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#arrayActions[count]#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;qryActions2&quot; datasource=&quot;#session.datasrc#&quot;&gt;

		SELECT      pt.actions

		FROM          tbl_prg_all p, programtext pt

		WHERE     p.recid = pt.program_id and p.prg_id = '#prg_id#' and type='#type#' and benefit=(#benefit#)

	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#prg_id#'</strong><br>
                    
                    <strong>'#type#'</strong><br>
                    
                    <strong>#benefit#</strong><br>
                    

                <hr>
            <b>2 queries found in rx/dspfiles/dspCreditable.cfm!</b><br />
            &lt;cfquery name=&quot;qryLIS&quot; datasource=&quot;#session.datasrc#&quot;&gt;
	SELECT      pt.summary, pt.rec, pt.type, pt.benefit, pt.actions
	FROM        programtext pt
	WHERE     
	pt.template = 'LIS' and pt.benefit = (#benefit#)
	and answerfield = '#answerfield#'
&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#benefit#</strong><br>
                    
                    <strong>'#answerfield#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;qryLISNOTES&quot; datasource=&quot;#session.datasrc#&quot;&gt;
				SELECT      pt.summary, pt.rec, pt.type, pt.benefit
				FROM        programtext pt
				WHERE     
				pt.template = 'LISNOTE' and benefit = (#benefit#)
				and (answerfield = '#answerfield#' or answerfield = '#answerfield2#')
			&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#benefit#</strong><br>
                    
                    <strong>'#answerfield#'</strong><br>
                    
                    <strong>'#answerfield2#'</strong><br>
                    

                <hr>
            <b>2 queries found in rx/dspfiles/dspExcludedDrugs.cfm!</b><br />
            &lt;cfquery name=&quot;qrylivSit&quot; datasource=&quot;#session.datasrc#&quot;&gt;
		SELECT      pt.programtext_id, pt.summary, pt.answerfield, pt.rec, pt.actions
		FROM        programtext pt
		WHERE     
		pt.template = 'LIVSITUATION' 
		and answerfield IN (#PreserveSingleQuotes(listLivingSituationFields)#)  
	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#PreserveSingleQuotes(listLivingSituationFields)#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;qryExDrugs&quot; datasource=&quot;#session.datasrc#&quot;&gt;
		SELECT      pt.programtext_id,pt.summary, pt.answerfield, pt.rec, pt.actions
		FROM        programtext pt
		WHERE     
		pt.template = 'EXCLUDEDRUG' 
		and answerfield IN (#PreserveSingleQuotes(listExcludedeDrugs)#)  
	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#PreserveSingleQuotes(listExcludedeDrugs)#</strong><br>
                    

                <hr>
            <b>2 queries found in rx/dspfiles/dspExcludedOptions.cfm!</b><br />
            &lt;cfquery name=&quot;qryExDrugs&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT      pt.summary, pt.answerfield, pt.rec, pt.actions
		FROM        programtext pt
		WHERE     
		pt.template = 'EXCLUDEDRUG' 
		and answerfield IN (#PreserveSingleQuotes(listExcludedeDrugs)#)  
	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#PreserveSingleQuotes(listExcludedeDrugs)#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;qrylivSit&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT      pt.summary, pt.answerfield, pt.rec, pt.actions
		FROM        programtext pt
		WHERE     
		pt.template = 'EXCLUDEDRUG' 
		and answerfield IN (#PreserveSingleQuotes(listLivingSituationFields)#)  
	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#PreserveSingleQuotes(listLivingSituationFields)#</strong><br>
                    

                <hr>
            <b>1 queries found in rx/dspfiles/dspLISOther.cfm!</b><br />
            &lt;cfquery name=&quot;qryContent&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT      pt.Programtext_id, pt.summary, pt.rec, pt.type, pt.benefit, pt.actions
	FROM        programtext pt
	WHERE     
    pt.benefit = (#benefit#) and pt.template = '#template#' and active  = 1
	and answerfield = '#answerfield#'
&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#benefit#</strong><br>
                    
                    <strong>'#template#'</strong><br>
                    
                    <strong>'#answerfield#'</strong><br>
                    

                <hr>
            <b>1 queries found in rx/dspfiles/dspMedicareEnroll.cfm!</b><br />
            &lt;cfquery datasource=&quot;#application.dbSrc#&quot; name=&quot;getMedicare&quot;&gt; 
&lt;cfif isdefined('url.prg_id')&gt;
SELECT tbl_prg_all.prg_id, tbl_prg_all.prg_nm, tbl_RX_PrgDetail.DNumber
FROM         tbl_prg_all INNER JOIN tbl_RX_PrgDetail ON tbl_prg_all.prg_id = tbl_RX_PrgDetail.PRG_ID
where
tbl_prg_all.prg_id = tbl_RX_PrgDetail.prg_id and
tbl_prg_all.prg_id = '#url.prg_id#'

&lt;cfelse&gt;
SELECT tbl_prg_all.prg_id, tbl_prg_all.prg_nm, tbl_RX_PrgDetail.DNumber
FROM         tbl_prg_all INNER JOIN
                      tbl_user_prgid ON tbl_prg_all.prg_id = tbl_user_prgid.prg_id INNER JOIN
                      tbl_RX_PrgDetail ON tbl_user_prgid.prg_id = tbl_RX_PrgDetail.PRG_ID
WHERE  
(tbl_user_prgid.unseen IS NULL) and (tbl_user_prgid.clientnum = '#clientnum#') AND (tbl_prg_all.Cat_ID = 333)
&lt;/cfif&gt; 
&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#url.prg_id#'</strong><br>
                    
                    <strong>'#clientnum#'</strong><br>
                    

                <hr>
            <b>1 queries found in rx/dspfiles/dspMedicareSavings.cfm!</b><br />
            &lt;cfquery name=&quot;qryMSP&quot; datasource=&quot;#session.datasrc#&quot;&gt;
	SELECT      pt.programtext_id, pt.summary, pt.rec, pt.type, pt.benefit, pt.actions
	FROM        programtext pt
	WHERE     
	pt.template = 'MSP' and pt.benefit = (#benefit#)
&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#benefit#</strong><br>
                    

                <hr>
            <b>2 queries found in rx/dspfiles/dspNonCreditable.cfm!</b><br />
            &lt;cfquery name=&quot;qryLIS&quot; datasource=&quot;#session.datasrc#&quot;&gt;
	SELECT      pt.summary, pt.rec, pt.type, pt.benefit, pt.actions
	FROM        programtext pt
	WHERE     
	pt.template = 'LIS' and pt.benefit = (#benefit#)
	and answerfield = '#answerfield#'
&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#benefit#</strong><br>
                    
                    <strong>'#answerfield#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;qryLISNOTES&quot; datasource=&quot;#session.datasrc#&quot;&gt;
				SELECT      pt.summary, pt.rec, pt.type, pt.benefit
				FROM        programtext pt
				WHERE     
				pt.template = 'LISNOTE' and benefit = (#benefit#)
				and (answerfield = '#answerfield#' or answerfield = '#answerfield2#')
			&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#benefit#</strong><br>
                    
                    <strong>'#answerfield#'</strong><br>
                    
                    <strong>'#answerfield2#'</strong><br>
                    

                <hr>
            <b>1 queries found in rx/dspfiles/dspNotes.cfm!</b><br />
            &lt;cfquery name=&quot;qryLISNOTES&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

				SELECT      pt.summary, pt.rec, pt.type, pt.benefit

				FROM        programtext pt

				WHERE     

				pt.template = 'LISNOTE' and benefit = (#request.notesbenefit#) and active=1

				and (answerfield = '#request.answerfieldnotes#')

			&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#request.notesbenefit#</strong><br>
                    
                    <strong>'#request.answerfieldnotes#'</strong><br>
                    

                <hr>
            <b>1 queries found in rx/dspfiles/dspOtherCoverage.cfm!</b><br />
            &lt;cfquery name=&quot;qryLIS&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT      pt.programtext_id, pt.summary, pt.rec, pt.type, pt.benefit, pt.actions
	FROM        programtext pt
	WHERE     
	pt.template = 'LIS' and pt.benefit = (#benefit#)
	and answerfield = '#answerfield#'
&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#benefit#</strong><br>
                    
                    <strong>'#answerfield#'</strong><br>
                    

                <hr>
            <b>1 queries found in rx/dspfiles/dspPartD.cfm!</b><br />
            &lt;cfquery name=&quot;qryLIS&quot; datasource=&quot;#session.datasrc#&quot;&gt;
SELECT      pt.programtext_id, pt.summary, pt.rec, pt.type, pt.benefit, pt.actions
FROM        programtext pt
WHERE     	pt.template = 'LIS' 
and pt.benefit = (#benefit#) 
and Active=1
and answerfield = '#answerfield#'
&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#benefit#</strong><br>
                    
                    <strong>'#answerfield#'</strong><br>
                    

                <hr>
            <b>1 queries found in rx/dspfiles/dspVA.cfm!</b><br />
            &lt;cfquery name=&quot;qryVA&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT      pt.summary, pt.rec, pt.type, pt.benefit
		FROM        programtext pt
		WHERE     	pt.type = '#TYPE#' and pt.template = 'VA' AND benefit = (#lisbenefit#)
		&lt;cfif TYPE neq 'ELIGIBLE'&gt;
		AND answerfield = '#answerfield#'
		&lt;/cfif&gt;
	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#TYPE#'</strong><br>
                    
                    <strong>#lisbenefit#</strong><br>
                    
                    <strong>'#answerfield#'</strong><br>
                    

                <hr>
            <b>1 queries found in rx/dspfiles/qryMedApproved.cfm!</b><br />
            &lt;cfquery name=&quot;qryMedApproved&quot; datasource=&quot;#application.dbSrc#&quot;  &gt;

	SELECT     tbl_prg_all.prg_id, prg_nm,DNumber, LocatorEnable, CMSEnable

	FROM        tbl_prg_all,tbl_RX_PrgDetail

	WHERE     cat_id = #Cat_id#   and  tbl_prg_all.prg_id in (#preservesinglequotes(prg_list)#)

	and tbl_prg_all.prg_id = tbl_RX_PrgDetail.prg_id

	ORDER BY DNumber ASC

&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>#Cat_id#</strong><br>
                    
                    <strong>#preservesinglequotes(prg_list)#</strong><br>
                    

                <hr>
            <b>1 queries found in rx/dspfiles/qryPAP.cfm!</b><br />
            &lt;cfquery name=&quot;qryPAP&quot; datasource=&quot;#application.dbSrc#&quot;  &gt;

SELECT     prg_id, prg_nm
FROM         tbl_prg_all
WHERE     (Cat_ID = 331)

&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				

                <hr>
            <b>3 queries found in rx/dspfiles/qryStatePrograms.cfm!</b><br />
            &lt;cfquery name=&quot;qryStateReceive&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT a.answerfield, p.prg_id, p.order_num
	FROM tbl_prg_all p, program_answerfield pa, answerfield a
	WHERE p.st = '#session.st#'
			and p.RecID=pa.program_id
			and pa.answerfield_id=a.answerfield_id
			and a.answerfield like 'rec_#session.st#%'
	order by p.order_num desc,a.answerfield desc, p.prg_id
&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>#session.st#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;qryStatePrg&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT      p.prg_id, p.prg_nm, pt.programtext_id, pt.summary, pt.rec, pt.type, pt.benefit, pt.actions
	FROM          tbl_prg_all p, programtext pt
	WHERE     
	p.recid = pt.program_id
	and p.st = ('#session.ST#')  and pt.Active=1
	and pt.type = '#stateType#' and benefit = #LIS# 
	and  p.prg_id in (#preservesinglequotes(prg_list)#) and pt.template = 'SPAP'
	order by p.order_num, p.prg_nm
	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#session.ST#'</strong><br>
                    
                    <strong>'#stateType#'</strong><br>
                    
                    <strong>#LIS#</strong><br>
                    
                    <strong>#preservesinglequotes(prg_list)#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;qryStatePrg&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		&lt;cfif session.st eq &quot;OH&quot; or session.st eq &quot;IL&quot; or session.st eq &quot;VT&quot; or session.st eq &quot;OR&quot;&gt;
		SELECT      p.prg_id, p.prg_nm, pt.programtext_id, pt.summary, pt.rec, pt.type, pt.benefit, pt.actions, p.order_num
		FROM          tbl_prg_all p, programtext pt
		WHERE     
		p.recid = pt.program_id
		and p.st = ('#session.ST#')
		and pt.type = 'eligible' and benefit = #LIS# and pt.Active=1
		and  p.prg_id in (#preservesinglequotes(prg_list)#) and pt.template = 'SPAP'
		union all
		&lt;/cfif&gt;	
		SELECT p.prg_id, p.prg_nm, pt.programtext_id, pt.summary, pt.rec, pt.type, pt.benefit, pt.actions, p.order_num
		FROM tbl_prg_all p, program_answerfield pa, answerfield a, programtext pt
		WHERE (
				&lt;cfif isdefined('session.rec_oh_bestrx') and isdefined('session.rec_oh_buckeye') and session.rec_oh_buckeye eq 'y' 	and session.rec_oh_bestrx eq 'y'&gt;
				 (a.answerfield = 'rec_oh_bestrx' or a.answerfield = 'rec_oh_buckeye') 
				
				&lt;cfelseif isdefined('session.rec_or_pdap_2') and isdefined('session.rec_or_pdap') and session.rec_or_pdap_2 eq 'y' 	and session.rec_or_pdap eq 'y'&gt;
				 (a.answerfield = 'rec_or_pdap' or a.answerfield = 'rec_or_pdap_2')  
				&lt;cfelse&gt;
				 p.prg_id = '#stateReceive_prg_id#'
				 and a.answerfield = '#stateReceive#'
				&lt;/cfif&gt;
		and p.st = ('#session.ST#')
		and p.recid = pa.program_id
		and pa.answerfield_id=a.answerfield_id
		and p.recid = pt.program_id
		and pt.type = '#stateType#'
		and pt.benefit = #LIS#
		and pt.Active=1
		and pt.template = 'SPAP' )
		order by p.order_num, p.prg_nm 
	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#session.ST#'</strong><br>
                    
                    <strong>#LIS#</strong><br>
                    
                    <strong>#preservesinglequotes(prg_list)#</strong><br>
                    
                    <strong>'#stateReceive_prg_id#'</strong><br>
                    
                    <strong>'#stateReceive#'</strong><br>
                    
                    <strong>'#session.ST#'</strong><br>
                    
                    <strong>'#stateType#'</strong><br>
                    
                    <strong>#LIS#</strong><br>
                    
			<hr>
            <b>1 queries found in rx/dspfiles/qryStateSSI.cfm!</b><br />
            &lt;cfquery name=&quot;qryStateSSI&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
SELECT sp.program_id, p.prg_id, p.prg_nm
	FROM xsubset_program AS sp, tbl_prg_all AS p
	WHERE sp.subset_id=20
		AND (sp.exclude_flag &lt;&gt; 1 OR sp.exclude_flag IS NULL)
	    AND sp.program_id=p.recid
		AND p.st = '#session.st#'
	ORDER BY p.prg_nm, p.prg_id

&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#session.st#'</strong><br>
                    

                <hr>
            <b>3 queries found in rx/dspfiles/tagCheckDrug.cfm!</b><br />
            &lt;cfquery name=&quot;matchingdrugs&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT a.answerfield, substring(dl.display_text, 1, 255) option_nm
		FROM tbl_prg_all p, program_answerfield pa, answerfield a, display_language dl
		WHERE p.prg_id = '#prg_id#'
			AND p.recid=pa.program_id
			and pa.answerfield_id=a.answerfield_id
			AND a.answerfieldtype_id in (13, 14)
			AND a.display_id=dl.display_id
			and dl.language_id='#session.language_id#'
		ORDER BY option_nm
	&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				
                    <strong>'#prg_id#'</strong><br>
                    
                    <strong>'#session.language_id#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;genericMatch&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
			select answerfield, answerfield option_nm
			from answerfield
			where answerfield_id is null
		&lt;/cfquery&gt;<br>
                Table: <strong>tbl_prg_all</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;genericMatch&quot; datasource=&quot;#application.dbSrc#&quot; &gt;
			select a.answerfield, substring(dl.display_text, 1, 255) as option_nm
			from answerfield_relationship ar, answerfield a, display_language dl
			where ar.right_answerfield_id in (#genericList#)
				and ar.relationship_id=1
				and ar.left_answerfield_id=a.answerfield_id
				and a.answerfieldtype_id=13
				and a.display_id=dl.display_id
				and dl.language_id='#session.language_id#'
			order by option_nm
		&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>#genericList#</strong><br>
                    
                    <strong>'#session.language_id#'</strong><br>
                    
				
                <hr>
            <b>1 queries found in rx/dspRecap.cfm!</b><br />
            &lt;cfquery name=&quot;qryRecap&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
SELECT     rec, answerfield
FROM         programtext
WHERE     (template = 'PROFILE') 
order by sortorder ASC
&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
				<!--- MH: 5/12/10 Removed reference to tbl_subset since it is being archived on BCUQA 
                <hr>
            <b>1 queries found in rx/qryMedicaid.cfm!</b><br />
            &lt;cfquery name=&quot;qryMedicaid&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

SELECT     tbl_subset_prg.prg_id

FROM         tbl_subset_prg, tbl_prg_all

WHERE     (subset_id = 8)  and tbl_subset_prg.prg_id = tbl_prg_all.prg_id and ST = ('#session.ST#')

and  tbl_subset_prg.prg_id in (#preservesinglequotes(prg_list)#)

order by tbl_prg_all.prg_nm asc

&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>'#session.ST#'</strong><br>
                    
                    <strong>#preservesinglequotes(prg_list)#</strong><br>
                    --->

                <hr>
            <b>1 queries found in rx/qryRecommendedPrograms.cfm!</b><br />
            &lt;cfquery datasource=&quot;#application.dbSrc#&quot; name=&quot;qryUpdateUserPrg&quot;&gt;

  Update tbl_user_prgid

  SET Unseen = 1

  where clientnum = '#session.clientnum#'

  and prg_id = '#temp_prg_id#'

  &lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>'#session.clientnum#'</strong><br>
                    
                    <strong>'#temp_prg_id#'</strong><br>
                    

                <hr>
            <b>1 queries found in rx/qryStateScenarios.cfm!</b><br />
            &lt;cfquery name=&quot;qryStateScenarios&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

SELECT     Template_name, Display_level

FROM         tbl_RX_Scenarios

WHERE     (State = '#ST#') and Scenario = '#Scenario#'

order by Display_level,SortOrder



&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>'#ST#'</strong><br>
                    
                    <strong>'#Scenario#'</strong><br>
                    

                <hr>
            <b>2 queries found in rx/qrySubmission.cfm!</b><br />
            &lt;cfquery name=&quot;qrySubmission&quot; datasource=&quot;#application.dbSrc#&quot;&gt;



SELECT     prev_screening_id



FROM         screening



WHERE     screening_id = #session.screening_id#



&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;qrySubmission&quot; datasource=&quot;#application.dbSrc#&quot;&gt;



SELECT     *



FROM         screening_submission



WHERE     screening_id = #receipt_screening_id#



&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>#receipt_screening_id#</strong><br>
                    

                <hr>
            <b>3 queries found in rx/tagDrugCheck.cfm!</b><br />
            &lt;cfquery name=&quot;matchingdrugs&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT a.answerfield, substring(dl.display_text, 1, 255) option_nm
		FROM tbl_prg_all p, program_answerfield pa, answerfield a, display_language dl
		WHERE p.prg_id = '#prg_id#'
			AND p.recid=pa.program_id
			and pa.answerfield_id=a.answerfield_id
			AND a.answerfieldtype_id in (13, 14)
			AND a.display_id=dl.display_id
			and dl.language_id='#session.language_id#'
		ORDER BY option_nm
	&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>'#prg_id#'</strong><br>
                    
                    <strong>'#session.language_id#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;genericMatch&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
			select answerfield, answerfield option_nm
			from answerfield
			where answerfield_id is null
		&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;genericMatch&quot; datasource=&quot;#application.dbSrc#&quot; &gt;
			select a.answerfield, substring(dl.display_text, 1, 255) as option_nm
			from answerfield_relationship ar, answerfield a, display_language dl
			where ar.right_answerfield_id in (#genericList#)
				and ar.relationship_id=1
				and ar.left_answerfield_id=a.answerfield_id
				and a.answerfieldtype_id=13
				and a.display_id=dl.display_id
				and dl.language_id='#session.language_id#'
			order by option_nm
		&lt;/cfquery&gt;<br>
                Table: <strong>answerfield_relationship</strong><br>
				Params:<br>
				
                    <strong>#genericList#</strong><br>
                    
                    <strong>'#session.language_id#'</strong><br>
                    

                <hr>
            <b>2 queries found in rx/tagGetDrugList.cfm!</b><br />
            &lt;CFQUERY DATASOURCE=&quot;#application.dbSrc#&quot; NAME=&quot;getName&quot;&gt;
			select answerfield_id as generic_id, a.answerfield, substring(dl.display_text, 1, 255) as option_nm
			from answerfield a left outer join display_language dl
			on a.display_id=dl.display_id
				and dl.language_id='EN'
			where a.answerfieldtype_id=14 and a.answerfield = '#LCase(chosendrug)#'
	&lt;/CFQUERY&gt;<br>
                Table: <strong>answerfield</strong><br>
				Params:<br>
				
                    <strong>'#LCase(chosendrug)#'</strong><br>
                    

                <hr>
            &lt;CFQUERY DATASOURCE=&quot;#application.dbSrc#&quot; NAME=&quot;getName&quot;&gt;
	select a.answerfield,substring(dl.display_text, 1, 255) as option_nm
	from answerfield a left outer join display_language dl
	on a.display_id=dl.display_id and dl.language_id='EN'
	where a.answerfieldtype_id=13 and lower(a.answerfield) = '#LCase(chosendrug)#'
	&lt;/CFQUERY&gt;<br>
                Table: <strong>answerfield</strong><br>
				Params:<br>
				
                    <strong>'#LCase(chosendrug)#'</strong><br>
                    

                <hr>
            <b>2 queries found in rx/tagGetDrugListBullets.cfm!</b><br />
            &lt;CFQUERY DATASOURCE=&quot;#application.dbSrc#&quot; NAME=&quot;getName&quot;&gt;
			select answerfield_id as generic_id, a.answerfield, substring(dl.display_text, 1, 255) as option_nm
			from answerfield a left outer join display_language dl
			on a.display_id=dl.display_id
				and dl.language_id='EN'
			where a.answerfieldtype_id=14 and a.answerfield = '#LCase(chosendrug)#'
	&lt;/CFQUERY&gt;<br>
                Table: <strong>answerfield</strong><br>
				Params:<br>
				
                    <strong>'#LCase(chosendrug)#'</strong><br>
                    

                <hr>
            &lt;CFQUERY DATASOURCE=&quot;#application.dbSrc#&quot; NAME=&quot;getName&quot;&gt;
	select a.answerfield,substring(dl.display_text, 1, 255) as option_nm
	from answerfield a left outer join display_language dl
	on a.display_id=dl.display_id and dl.language_id='EN'
	where a.answerfieldtype_id=13 and lower(a.answerfield) = '#LCase(chosendrug)#'
	&lt;/CFQUERY&gt;<br>
                Table: <strong>answerfield</strong><br>
				Params:<br>
				
                    <strong>'#LCase(chosendrug)#'</strong><br>
                    

                <hr>
            <b>1 queries found in schip.cfm!</b><br />
            &lt;cfquery name=&quot;ep&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	select e.entrypoint_id, s.state_name
	from program_entrypointgroup pe, entrypoint_entrypointgroup eg, entrypoint e, state s
	where pe.program_id=#pobj.id#
		and pe.entrypointgroup_id=eg.entrypointgroup_id
		and eg.entrypoint_id=e.entrypoint_id
		and e.active_flag=1
		and e.state_id=s.state_id
	order by s.statetype_id, s.state_name, e.city, e.zipcode
&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>#pobj.id#</strong><br>
                    

                <hr>
            <b>1 queries found in sessionerror.cfm!</b><br />
            &lt;cfquery name=&quot;findOldSession&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT * FROM screening WHERE cfid = '#cfid#' AND cftoken = '#cftoken#' ORDER BY start_datetime DESC
&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>'#cfid#'</strong><br>
                    
                    <strong>'#cftoken#'</strong><br>
                    

                <hr>
            <b>1 queries found in share.cfm!</b><br />
            &lt;cfquery name=&quot;ins_survey&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		insert into survey
			(screening_id, first_name, last_name, city, state_id, phone, email, learn)
		values
			(#session.screening_id#, '#first_name#', '#last_name#', '#city#', '#st#', '#phone#', '#email#', '#learn#')
	&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>'#first_name#'</strong><br>
                    
                    <strong>'#last_name#'</strong><br>
                    
                    <strong>'#city#'</strong><br>
                    
                    <strong>'#st#'</strong><br>
                    
                    <strong>'#phone#'</strong><br>
                    
                    <strong>'#email#'</strong><br>
                    
                    <strong>'#learn#'</strong><br>
                    

                <hr>
            <b>2 queries found in subset.cfm!</b><br />
            &lt;cfquery name=&quot;subsets&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT subset_id, subset_name
	FROM xsubset
	WHERE subsettype_id in (1&lt;cfif IsDefined('session.subsetTest') eq 1&gt;, 2&lt;/cfif&gt;)
	ORDER BY subset_id
&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;partners&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT partner_id, partner_code
	FROM tbl_partner
	ORDER BY partner_id
&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				

                <hr>
            <b>5 queries found in synergyxmlparser.cfm!</b><br />
            &lt;cfquery name=&quot;helperPrg&quot; datasource=&quot;#session.datasrc#&quot;&gt;































		SELECT p.prg_id AS helper_prg_id































		FROM subset_program_base spb RIGHT OUTER JOIN subset_program_sum sps































				ON spb.subset_id=sps.subset_id AND spb.program_id=sps.program_id































			INNER JOIN tbl_prg_all p































				ON sps.program_id=p.RecID































		WHERE sps.subset_id=#session.subset_id#































			AND spb.subset_id IS NULL































		ORDER BY p.prg_id































	&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;insertprograms&quot; DATASOURCE=&quot;#session.datasrc#&quot;&gt;































		INSERT INTO screening_program































			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)































		VALUES































			(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenAdjustedVal#, 0, 0)































	&lt;/CFQUERY&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#</strong><br>
                    
                    <strong>#unseenAdjustedVal#</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;insertchips&quot; DATASOURCE=&quot;#session.datasrc#&quot;&gt;































		INSERT INTO screening_program































			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)































		VALUES































			(#session.screening_id#, #StructFind(application.prgvars, '103-309-2191-FD-FD')#, #unseenVal#, 0, 0)































	&lt;/CFQUERY&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, '103-309-2191-FD-FD')#</strong><br>
                    
                    <strong>#unseenVal#</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;insertgeneric&quot; DATASOURCE=&quot;#session.datasrc#&quot;&gt;































		INSERT INTO screening_program































			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)































		VALUES































			(#session.screening_id#, #StructFind(application.prgvars, 'XXX-311-2387-FD-FD')#, #unseenVal#, 0, 0)































	&lt;/CFQUERY&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, 'XXX-311-2387-FD-FD')#</strong><br>
                    
                    <strong>#unseenVal#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;insertbuffers&quot; DATASOURCE=&quot;#session.datasrc#&quot;&gt;































		INSERT INTO screening_program































			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)































		VALUES































			(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenVal#, 1, 0)

	&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#</strong><br>
                    
                    <strong>#unseenVal#</strong><br>
                    

                <hr>
            <b>1 queries found in tagCheckCookCty.cfm!</b><br />
            &lt;cfquery name=&quot;qryGetCookCtyZips&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
 SELECT DISTINCT Zip, PostalCity
 FROM tblCookCountyCities
 WHERE Zip = #FORM.zip#
&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>#FORM.zip#</strong><br>
                    

                <hr>
            <b>7 queries found in tagGetIncomeTables.cfm!</b><br />
            &lt;cfquery name=&quot;sec8&quot; datasource = &quot;#application.dbSrc#&quot;&gt;
SELECT mem#householdcount# AS tbl
FROM tbl_inc_new
WHERE tbl_nm='Section 8' AND st='#session.st#'
&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>#householdcount#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;ph&quot; datasource = &quot;#application.dbSrc#&quot;&gt;
SELECT mem#householdcount# AS tbl
FROM tbl_inc_new
WHERE tbl_nm='Public Housing' AND st='#session.st#'
&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>#householdcount#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;weather&quot; datasource = &quot;#application.dbSrc#&quot;&gt;
SELECT mem#householdcount# AS tbl
FROM tbl_inc_new
WHERE tbl_nm='WEATHER' AND st='#session.st#'
&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>#householdcount#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;liheap&quot; datasource = &quot;#application.dbSrc#&quot;&gt;
SELECT mem#householdcount# AS tbl
FROM tbl_inc_new
WHERE tbl_nm='LIHEAP' AND st='#session.st#'
&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>#householdcount#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;lasset&quot; datasource = &quot;#application.dbSrc#&quot;&gt;
SELECT mem#householdcount# AS tbl
FROM tbl_inc_new
WHERE tbl_nm='LASSET' AND st='#session.st#'
&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>#householdcount#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;tanf&quot; datasource = &quot;#application.dbSrc#&quot;&gt;
		SELECT mem#childcount# AS tbl
		FROM tbl_inc_new
		WHERE tbl_nm='TANF'
			AND st='#session.st#'
	&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>#childcount#</strong><br>
                    
                    <strong>'#session.st#'</strong><br>
                    

                <hr>
            &lt;cfquery name = &quot;build_income_array&quot; datasource = &quot;#application.dbSrc#&quot;&gt;
SELECT mem#householdcount# AS mem, mem#dependcount# AS depmem, mem#childcount# AS chdmem, proc_id
FROM tbl_inc_new
WHERE tbl_nm not in ('liheap','lasset','weather','public housing','section 8','TANF')
ORDER BY proc_id
&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>#householdcount#</strong><br>
                    
                    <strong>#dependcount#</strong><br>
                    
                    <strong>#childcount#</strong><br>
                    

                <hr>
            <b>1 queries found in tagGetMxAssetVals.cfm!</b><br />
            &lt;cfquery name=&quot;getMxAssetVals&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
SELECT single, couple
FROM tbl_mx_asset
WHERE st = '#session.st#'
AND tbl_nm = '#strTable#'
&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>'#strTable#'</strong><br>
                    

                <hr>
            <b>1 queries found in tagGetMxIncVals.cfm!</b><br />
            &lt;cfquery name=&quot;getMxIncVals&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
SELECT single_max, single_min, couple_max, couple_min
FROM tbl_mx_income
WHERE st = '#session.st#'
AND tbl_nm = '#strTable#'
&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>'#session.st#'</strong><br>
                    
                    <strong>'#strTable#'</strong><br>
                    

                <hr>
            <b>1 queries found in tagShowBufferProgs.cfm!</b><br />
            &lt;CFQUERY DATASOURCE=&quot;#application.dbSrc#&quot; NAME=&quot;buffer_prgs&quot;&gt;
SELECT prg_id, prg_nm, order_num, st, Cat_ID, major_cat, id_number
FROM tbl_prg_all, tbl_major_cat_list
WHERE
&lt;cfif Not IsDefined('session.subset_id') Or session.subset_id eq 0 Or session.subset_id eq 21 Or session.subset_id eq ''&gt;
	tbl_major_cat_list.id_number NOT IN (333, 334) AND
&lt;/cfif&gt;
	tbl_major_cat_list.id_number = tbl_prg_all.Cat_ID
	AND prg_id IN (#preservesinglequotes(session.buff_list)#)
	ORDER BY order_num
&lt;/CFQUERY&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>#preservesinglequotes(session.buff_list)#</strong><br>
                    

                <hr>
            <b>1 queries found in util/dspPrgDesc.cfm!</b><br />
            &lt;cfquery datasource=#application.dbSrc# name=&quot;desc&quot; &gt;
SELECT     prg_id, prg_nm, prg_desc
FROM         tbl_prg_all
&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				
                    <strong>#application.dbSrc#</strong><br>
                    

                <hr>
            <b>5 queries found in util/dspTAEnrollmentCount.cfm!</b><br />
            &lt;cfquery name=&quot;CountTA&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

SELECT     COUNT(DISTINCT ConfirmationNumber) AS total, COUNT(*) AS totalall

FROM         tbl_user_ta

where createDate &gt; '12/20/2004'

&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;CountTADistinct1&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

SELECT  distinct ConfirmationNumber, FirstName, LastName

FROM         tbl_user_ta

where createDate &gt; '12/20/2004' and createDate &lt; '01/01/2005'

&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;CountTADistinct2&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

SELECT  distinct ConfirmationNumber, FirstName, LastName

FROM         tbl_user_ta

where createDate &gt; '01/01/2005'

&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;CountTACMSExport1&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

SELECT  distinct ConfirmationNumber

FROM         medEnrollment

WHERE     (submitdate &lt; '01/01/2005')

&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;CountTACMSExport2&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

SELECT  distinct ConfirmationNumber

FROM         medEnrollment

WHERE     (submitdate &gt; '01/01/2005')

&lt;/cfquery&gt;<br>
                Table: <strong>program_entrypointgroup</strong><br>
				Params:<br>
				

                <hr>
            <b>1 queries found in util/getBatchResultsCount.cfm!</b><br />
            &lt;cfquery name=&quot;results&quot;  datasource=&quot;#application.dbSrc#&quot;  &gt;
select  ss.screening_id, client_id,post_start_time, submission_status from screening s, screening_submission ss 
where ss.screening_id = s.screening_id
and partner_id = 23 and post_start_time &gt; '07/18/2007' and subset_id = 41 and post_start_time &lt; '07/19/2007'
&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				

                <hr>
            <b>12 queries found in util/procGetReport.cfm!</b><br />
            &lt;cfquery name=&quot;GetUserPrgs&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT prg_id
	FROM tbl_user_prgid
	WHERE clientnum = (#clientnum#)
	&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#clientnum#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;GetUserPrgs&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT     tbl_prg_all.prg_id
	FROM         screening_program INNER JOIN
	tbl_prg_all ON screening_program.program_id = tbl_prg_all.RecID 
	and screening_id = (#clientnum#)
	&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#clientnum#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;GetClientID&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT client_id
	FROM tbl_user_info
	WHERE clientnum = (#clientnum#)
	&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#clientnum#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;GetClientID&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT client_id
	FROM screening
	WHERE screening_id  = (#clientnum#)
	&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#clientnum#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;GetUserData&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	SELECT wantChips, County, ST, ZIP, City, cso_id, idnumber
	FROM tbl_user_ans
	WHERE clientnum = (#clientnum#)
	&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#clientnum#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;GetOrgData&quot; datasource=&quot;#application.dbSrcOE#&quot;&gt;
		SELECT id
		FROM ORGANIZATION
		WHERE cso_id=#GetUserData.cso_id#
		&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#GetUserData.cso_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;GetUserData&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	select org_id, partner_id, screening_id from screening
	WHERE screening_id = (#clientnum#)
	&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#clientnum#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;GetVars&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT     response
		FROM         screening_answerfield INNER JOIN
        tbl_answerfield_list ON screening_answerfield.answerfield_id = tbl_answerfield_list.RecID
		WHERE     screening_answerfield.screening_id = ( #clientnum#) and answerfield_id = (4341) 
	&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#clientnum#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;GetVars&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT     response
		FROM         screening_answerfield INNER JOIN
        tbl_answerfield_list ON screening_answerfield.answerfield_id = tbl_answerfield_list.RecID
		WHERE     screening_answerfield.screening_id = ( #clientnum#) and answerfield_id = (47) 
	&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#clientnum#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;GetVars&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT     response
		FROM         screening_answerfield INNER JOIN
        tbl_answerfield_list ON screening_answerfield.answerfield_id = tbl_answerfield_list.RecID
		WHERE     screening_answerfield.screening_id = (#clientnum#) and answerfield_id = (542) 
	&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#clientnum#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;GetVars&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT     response
		FROM         screening_answerfield INNER JOIN
        tbl_answerfield_list ON screening_answerfield.answerfield_id = tbl_answerfield_list.RecID
		WHERE     screening_answerfield.screening_id = (#clientnum#) and answerfield_id = (177) 
	&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#clientnum#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;GetVars&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT     response
		FROM         screening_answerfield INNER JOIN
        tbl_answerfield_list ON screening_answerfield.answerfield_id = tbl_answerfield_list.RecID
		WHERE     screening_answerfield.screening_id = (#clientnum#) and answerfield_id = (543) 
	&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#clientnum#</strong><br>
                    

                <hr>
            <b>2 queries found in util/updatePrgInfo.cfm!</b><br />
            &lt;cfquery name=&quot;GetPrgs&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
SELECT     prg_id, prg_nm, CardName, SponsorName, Address
FROM         temp_rx_detail

&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;GetPrgs&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
UPDATE    tbl_RX_PrgDetail
SET              SponsorName = '#SponsorName#', CardName = '#CardName#', Address = '#Address#'
WHERE     (PRG_ID = '#prg_id#')

&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>'#SponsorName#'</strong><br>
                    
                    <strong>'#CardName#'</strong><br>
                    
                    <strong>'#Address#'</strong><br>
                    
                    <strong>'#prg_id#'</strong><br>
                    

                <hr>
            <b>3 queries found in vsi/entrypointTest.cfm!</b><br />
            &lt;cfquery name=&quot;getprg&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	select program_id, program_code
	from program
	where active_flag=1
	order by program_code
&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;citychk&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
			select c.city_id cid, c.city_name, c.state_id
			from view_city_zip_preferred cz, city c
			where cz.zipcode='#zipcode#'
				and cz.city_id=c.city_id
			order by c.city_name
		&lt;/cfquery&gt;<br>
                Table: <strong>view_city_zip_preferred</strong><br>
				Params:<br>
				
                    <strong>'#zipcode#'</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;zipchk&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	select zipcode
	from zip
	where zipcode='#zipcode#'
		and valid=1
&lt;/cfquery&gt;<br>
                Table: <strong>view_city_zip_preferred</strong><br>
				Params:<br>
				
                    <strong>'#zipcode#'</strong><br>
                    

                <hr>
            <b>2 queries found in vsi/screeningInspect.cfm!</b><br />
            &lt;cfquery name=&quot;screen&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	select screening_id, prev_screening_id, cfid, cftoken, source_id, org_id, partner_id,
		subset_id, language_id, access_id, client_id, user_id, preset_state_id, test_flag,
		start_datetime, end_datetime
	from screening s
	where screening_id=#id#
	order by screening_id desc
&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;ans&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	select pg, ans, type, response, retain, derive, approx, submit
	from (
			select sa.pagenum pg, a.answerfield ans, abs((sa.responsetype % 3) - 3) type,
				ifnull(sa.response, ifnull(o.option_code, '#nullstring#')) response,
				1 - ifnull(sa.retained_flag, 0) retain, 1 - ifnull(sa.derived_flag, 0) derive,
				1 - ifnull(sa.approximation_flag, 0) approx, sa.submit_datetime submit
			from screening_answerfield sa inner join answerfield a
					on sa.answerfield_id = a.answerfield_id
				left outer join `option` o 
					on sa.option_id = o.option_id
			where sa.screening_id=#id#
		) q
	order by &lt;cfif by neq 'ans'&gt;#by# #defdir#, &lt;/cfif&gt;ans #ansdir#
&lt;/cfquery&gt;<br>
                Table: <strong>screening_answerfield</strong><br>
				Params:<br>
				
                    <strong>'#nullstring#'</strong><br>
                    
                    <strong>#id#</strong><br>
                    
                    <strong>#by#</strong><br>
                    
                    <strong>#defdir#</strong><br>
                    
                    <strong>#ansdir#</strong><br>
                    

                <hr>
            <b>1 queries found in vsi/screeningList.cfm!</b><br />
            &lt;cfquery name=&quot;screen&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
	select screening_id, prev_screening_id, cfid, cftoken, source_id, org_id, partner_id,
		subset_id, language_id, access_id, client_id, user_id, preset_state_id, test_flag,
		start_datetime, end_datetime
	from screening s
	order by screening_id desc limit 0, #rows#
&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#rows#</strong><br>
                    

                <hr>
            <b>7 queries found in webservicescreening.cfc!</b><br />
            &lt;cfquery name=&quot;subsetInfo&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

			SELECT subsettype_id, subset_name, subset_longname, subset_description, subset_text,

				all_flag, grid_flag, schip_flag, drug_flag, optional_flag, rec_flag, eform_flag

			FROM xsubset

			WHERE subset_id=#session.subset_id#

		&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;subsetPartnerInfo&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

			SELECT resultpage_id

			FROM subset_partner

			WHERE subset_id=#session.subset_id#

				AND partner_id=#session.partner_id#

				AND resultpage_id IS NOT NULL

		&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>#session.partner_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;helperPrg&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

			SELECT p.prg_id AS helper_prg_id

			FROM subset_program_base spb RIGHT OUTER JOIN subset_program_sum sps

					ON spb.subset_id=sps.subset_id AND spb.program_id=sps.program_id

				INNER JOIN tbl_prg_all p

					ON sps.program_id=p.RecID

			WHERE sps.subset_id=#session.subset_id#

				AND spb.subset_id IS NULL

			ORDER BY p.prg_id

		&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;insertprograms&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;

			INSERT INTO screening_program

				(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)

			VALUES

				(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenAdjustedVal#, 0, 0)

		&lt;/CFQUERY&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#</strong><br>
                    
                    <strong>#unseenAdjustedVal#</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;insertchips&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;

			INSERT INTO screening_program

				(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)

			VALUES

				(#session.screening_id#, #StructFind(application.prgvars, '103-309-2191-FD-FD')#, #unseenVal#, 0, 0)

		&lt;/CFQUERY&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, '103-309-2191-FD-FD')#</strong><br>
                    
                    <strong>#unseenVal#</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;insertgeneric&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;

			INSERT INTO screening_program

				(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)

			VALUES

				(#session.screening_id#, #StructFind(application.prgvars, 'XXX-311-2387-FD-FD')#, #unseenVal#, 0, 0)

		&lt;/CFQUERY&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, 'XXX-311-2387-FD-FD')#</strong><br>
                    
                    <strong>#unseenVal#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;insertbuffers&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;

			INSERT INTO screening_program

				(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)

			VALUES

				(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenVal#, 1, 0)

		&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#</strong><br>
                    
                    <strong>#unseenVal#</strong><br>
                    

                <hr>
            <b>7 queries found in webservicescreening.cfm!</b><br />
            &lt;cfquery name=&quot;subsetInfo&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

			SELECT subsettype_id, subset_name, subset_longname, subset_description, subset_text,

				all_flag, grid_flag, schip_flag, drug_flag, optional_flag, rec_flag, eform_flag

			FROM xsubset

			WHERE subset_id=#session.subset_id#

		&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;subsetPartnerInfo&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

			SELECT resultpage_id

			FROM subset_partner

			WHERE subset_id=#session.subset_id#

				AND partner_id=#session.partner_id#

				AND resultpage_id IS NOT NULL

		&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    
                    <strong>#session.partner_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;helperPrg&quot; datasource=&quot;#application.dbSrc#&quot;&gt;

			SELECT p.prg_id AS helper_prg_id

			FROM subset_program_base spb RIGHT OUTER JOIN subset_program_sum sps

					ON spb.subset_id=sps.subset_id AND spb.program_id=sps.program_id

				INNER JOIN tbl_prg_all p

					ON sps.program_id=p.RecID

			WHERE sps.subset_id=#session.subset_id#

				AND spb.subset_id IS NULL

			ORDER BY p.prg_id

		&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#session.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;insertprograms&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;

			INSERT INTO screening_program

				(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)

			VALUES

				(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenAdjustedVal#, 0, 0)

		&lt;/CFQUERY&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#</strong><br>
                    
                    <strong>#unseenAdjustedVal#</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;insertchips&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;

			INSERT INTO screening_program

				(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)

			VALUES

				(#session.screening_id#, #StructFind(application.prgvars, '103-309-2191-FD-FD')#, #unseenVal#, 0, 0)

		&lt;/CFQUERY&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, '103-309-2191-FD-FD')#</strong><br>
                    
                    <strong>#unseenVal#</strong><br>
                    

                <hr>
            &lt;CFQUERY NAME=&quot;insertgeneric&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;

			INSERT INTO screening_program

				(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)

			VALUES
				(#session.screening_id#, #StructFind(application.prgvars, 'XXX-311-2387-FD-FD')#, #unseenVal#, 0, 0)
		&lt;/CFQUERY&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, 'XXX-311-2387-FD-FD')#</strong><br>
                    
                    <strong>#unseenVal#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;insertbuffers&quot; DATASOURCE=&quot;#application.dbSrc#&quot;&gt;
			INSERT INTO screening_program
				(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
			VALUES
				(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenVal#, 1, 0)
		&lt;/cfquery&gt;<br>
                Table: <strong>screening</strong><br>
				Params:<br>
				
                    <strong>#session.screening_id#</strong><br>
                    
                    <strong>#StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#</strong><br>
                    
                    <strong>#unseenVal#</strong><br>
                    

                <hr>
            <b>3 queries found in writecover.cfm!</b><br />
            &lt;cfquery name=&quot;cobrandInfo&quot; datasource=&quot;#application.dbSrcOE#&quot;&gt;
		select o.site_name Pro_Name, o.slogan Pro_Slogon, o.site_bg_color Pro_BkColor, o.logo_path Pro_LogoPath, o.url Pro_URL, r.intro Pro_CSOInfo, '' Pro_LocalInfo
		from ORGANIZATION o, REPORT r
		where o.id=#session.org_id#
			and o.id=r.org_id
	&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#session.org_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;cobrandPublicInfo&quot; datasource=&quot;#application.dbSrcOE#&quot;&gt;
		SELECT a.line_1 Pro_PbAddress1, a.line_2 Pro_PbAddress2, '' Pro_PbAddress3, a.city Pro_PbCity, a.state Pro_PbState, a.zip Pro_PbZipCode, op.number Pro_PbOffPhone1, '' Pro_PbOffPhone1_Ext, '' Pro_PbContact_FName, r.contact_name Pro_PbContact_LName, tp.number Pro_PbTDD, '' Pro_PbTDD_Ext, r.cover_comments Pro_PbPhone_Comment
		FROM ORGANIZATION o
			LEFT JOIN REPORT r
		    	ON r.org_id = o.id
			LEFT JOIN ADDRESS a
		    	ON a.org_id = o.id
			LEFT JOIN PHONE op
		    	ON op.org_id = o.id
					AND op.phonetype_id = 1
			LEFT JOIN PHONE tp
				ON tp.org_id = o.id
					AND tp.phonetype_id = 6
		WHERE o.id = #session.org_id#
	&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#session.org_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;cobrandCityInfo&quot; datasource=&quot;#application.dbSrcOE#&quot;&gt;
		SELECT a.city Cty_Name
		FROM ADDRESS a
		WHERE a.org_id = #session.org_id#
	&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#session.org_id#</strong><br>
                    

                <hr>
            <b>3 queries found in writecovercookcty.cfm!</b><br />
            &lt;cfquery name=&quot;cobrandInfo&quot; datasource=&quot;#application.dbSrcOE#&quot;&gt;
		select o.site_name Pro_Name, o.slogan Pro_Slogon, o.site_bg_color Pro_BkColor, o.logo_path Pro_LogoPath, o.url Pro_URL, r.intro Pro_CSOInfo, '' Pro_LocalInfo
		from ORGANIZATION o, REPORT r
		where o.id=#session.org_id#
			and o.id=r.org_id
	&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#session.org_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;cobrandPublicInfo&quot; datasource=&quot;#application.dbSrcOE#&quot;&gt;
		SELECT a.line_1 Pro_PbAddress1, a.line_2 Pro_PbAddress2, '' Pro_PbAddress3, a.city Pro_PbCity, a.state Pro_PbState, a.zip Pro_PbZipCode, op.number Pro_PbOffPhone1, '' Pro_PbOffPhone1_Ext, '' Pro_PbContact_FName, r.contact_name Pro_PbContact_LName, tp.number Pro_PbTDD, '' Pro_PbTDD_Ext, r.cover_comments Pro_PbPhone_Comment
		FROM ORGANIZATION o
			LEFT JOIN REPORT r
		    	ON r.org_id = o.id
			LEFT JOIN ADDRESS a
		    	ON a.org_id = o.id
			LEFT JOIN PHONE op
		    	ON op.org_id = o.id
					AND op.phonetype_id = 1
			LEFT JOIN PHONE tp
				ON tp.org_id = o.id
					AND tp.phonetype_id = 6
		WHERE o.id = #session.org_id#
	&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#session.org_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;cobrandCityInfo&quot; datasource=&quot;#application.dbSrcOE#&quot;&gt;
		SELECT a.city Cty_Name
		FROM ADDRESS a
		WHERE a.org_id = #session.org_id#
	&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#session.org_id#</strong><br>
                    

                <hr>
            <b>4 queries found in writefile.cfm!</b><br />
            &lt;cfquery name=&quot;localinfo&quot; datasource=&quot;#application.dbSrcOE#&quot;&gt;
		select o.site_name Pro_Name, '' Pro_LocalInfo, r.intro Pro_CSOInfo
		from ORGANIZATION o, REPORT r
		where o.id=#session.org_id#
			and o.id=r.org_id
	&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#session.org_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;qryGetProgSortOrderAndCatName&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
SELECT     p.prg_id, c.major_cat
FROM       tbl_prg_all p 
   INNER JOIN
           tbl_major_cat_list c 
   ON p.Cat_ID = c.id_number
WHERE p.prg_id IN (#preserveSingleQuotes(lstProgNormal)#)
ORDER BY p.order_num
&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#preserveSingleQuotes(lstProgNormal)#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;qryGetBuffSortOrderAndCatName&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
   SELECT     p.prg_id, c.major_cat
   FROM       tbl_prg_all p 
      INNER JOIN
              tbl_major_cat_list c 
      ON p.Cat_ID = c.id_number
   WHERE p.prg_id IN (#preserveSingleQuotes(lstProgBuffer)#)
   ORDER BY p.order_num
   &lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#preserveSingleQuotes(lstProgBuffer)#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;proginfo&quot; datasource=&quot;#application.dbSrcOE#&quot;&gt;
		SELECT lp.name Prg_Name, lp.description Prg_Desc
		FROM LOCAL_PROGRAM lp, PRIORITY p
		WHERE lp.org_id = #session.org_id#
			AND lp.priority_id = p.id
		ORDER BY p.sort_order, lp.name
	&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				
                    <strong>#session.org_id#</strong><br>
                    

                <hr>
            <b>4 queries found in ztest.cfm!</b><br />
            &lt;cfquery name=&quot;svars&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		SELECT subset_id, code
		FROM subset
		ORDER BY code
	&lt;/cfquery&gt;<br>
                Table: <strong>ORGANIZATION</strong><br>
				Params:<br>
				

                <hr>
            &lt;cfquery name=&quot;svars&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		select s.subset_id, st.subsettype_name as stype, s.code, s.alt_display_id,
			s.spq_display_id, s.intro_display_id, r.code as rpage, s.shadow_subset_id,
			s.branding_partner_id, s.active_flag, s.test_flag, s.eform_flag
		from subset s inner join subsettype st
				on s.subsettype_id=st.subsettype_id
			left outer join resultpage r
				on s.resultpage_id=r.resultpage_id
		where s.subset_id=#attributes.subset_id#
	&lt;/cfquery&gt;<br>
                Table: <strong>subset</strong><br>
				Params:<br>
				
                    <strong>#attributes.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;psvars&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		select partner_id, shadow_subset_id
		from subset_partner_shadow
		where subset_id=#attributes.subset_id#
		order by partner_id
	&lt;/cfquery&gt;<br>
                Table: <strong>subset</strong><br>
				Params:<br>
				
                    <strong>#attributes.subset_id#</strong><br>
                    

                <hr>
            &lt;cfquery name=&quot;rqvars&quot; datasource=&quot;#application.dbSrc#&quot;&gt;
		select rq.code, srq.sort
		from subset_requisite srq, requisite rq
		where srq.subset_id=#attributes.subset_id#
			and srq.requisite_id=rq.requisite_id
		order by srq.sort
	&lt;/cfquery&gt;<br>
                Table: <strong>subset_requisite</strong><br>
				Params:<br>
				
                    <strong>#attributes.subset_id#</strong><br>
                    

                <hr>
            
    
    <b>
    500 templates<br>
    243 queries<br>
    </b>
    
    
    
