<CFQUERY datasource="#datasource#" Name="update_phone_no">
UPDATE tbl_entry2 (phone_no,phone_no_txt,phone_no1,phone_no1_txt,phone_no2,phone_no2_txt,phone_no3,phone_no3_txt,fax,fax2)
VALUES (#form.phone_no#,'#form.phone_no_txt#',#form.phone_no1#,'#form.phone_no1_txt#',#form.phone_no2#,'#form.phone_no2_txt#',#form.phone_no3#,'#form.phone_no3_txt#',#form.fax#,#form.fax2#)
WHERE org_id = #form.org_id# AND group_id = #form.group_id# AND RecId = #form.RecId#
</cfquery>

