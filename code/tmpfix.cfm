<CFQUERY DATASOURCE="BCU" NAME="opt3">
Insert into `option`
(option_id, INCLUDE_FLAG, option_code, display_id,create_user_id,create_date,modify_user_id,modify_date)
values
(2584,1,'ncoa_benefits_campaign',89976,4,'2012-02-14',4,'2012-02-14')
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt3">
select * from `option` o where o.option_id > 2580
</CFQUERY>
<cfdump var="#opt3#">
<cfabort>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,61,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,62,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,63,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,64,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,65,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,66,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,67,null,0)
</CFQUERY>

<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,68,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,69,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,60,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
update option_subset_partner 
set subset_id = null
where option_id = 2584
and subset_id <> 49


</CFQUERY>

<CFQUERY DATASOURCE="BCU" NAME="opt3">
select *
from option_subset_partner osp
where 

osp.option_id=2584
order by partner_id

</CFQUERY>

<cfabort>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
update option_subset_partner 
set subset_id = null
where option_id = 2584
and subset_id <> 49


</CFQUERY>

<CFQUERY DATASOURCE="BCU" NAME="opt3">
select *
from option_subset_partner osp
where 

osp.option_id=2584
order by partner_id

</CFQUERY>
<cfdump var="#opt3#">
<cfabort>

<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,51,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,52,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,53,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,54,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,55,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,56,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,57,null,0)
</CFQUERY>

<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,58,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,59,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,60,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt">
select *
from option_subset_partner osp
where

osp.option_id=2584
order by partner_id
</CFQUERY>
<cfdump var="#opt#">
<cfabort>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,71,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,72,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,73,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,74,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,75,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,76,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,77,null,0)
</CFQUERY>

<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,78,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,79,null,0)
</CFQUERY>
<CFQUERY DATASOURCE="BCU" NAME="opt2">
Insert into option_subset_partner 
(option_id, partner_id, subset_id, include_flag)
values
(2584,80,null,0)
</CFQUERY>

<CFQUERY DATASOURCE="BCU" NAME="opt">
select *
from option_subset_partner osp
where 

osp.option_id=2584
order by partner_id
</CFQUERY>
<cfdump var="#opt#">
