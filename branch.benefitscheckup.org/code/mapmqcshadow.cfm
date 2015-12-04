<!-- mapping MQC -->

<!-- default values -->
<cfset session.receive_csfp = "n">   
<cfset session.tefap_receive = "n">
<cfset session.medicare_receive = "y">
<!-- start mqc -->
<!-- client -->
<cfset session.client = session.mqc_client >
<!-- gender -->
<cfset session.gender = session.mqc_gender >
<!-- zipcode -->
<cfset session.zip = session.mqc_zipcode >
<!-- dob_month -->
<cfset session.dob_month = session.mqc_birth_month >
<!-- mqc_birth_day n/a in bcu -->
<!-- dob_year -->
<cfset session.dob_year = session.mqc_birth_year >
<!-- blind n/a in mqc answerfield -->
<!-- citizen n/a in mqc answerfield -->
<!-- disabled n/a in mqc answerfield -->
<!-- marital status -->
<cfset session.marital_stat = session.mqc_marital >
<!-- hh_depend n/a in mqc answerfield -->
<!-- no_hh_mebers n/a in mqc answerfield -->
<!-- pri_resident n/a in mqc answerfield -->
<!-- med_receive -->
<cfset session.med_receive = session.mqc_helpmedicaid >
<!-- medicare -->

<!-- recieve_lis -->
<cfset session.receive_lis = session.mqc_receivinglis >
<!-- receive_partd -->
<cfset session.receive_partd = session.mqc_receivepartd >
<cfset session.receive_msp = session.mqc_belongmsp >
<!-- ssi_receive n/a in mqc answerfield -->
<!-- st n/a in mqc answerfield -->
<!-- s_income_earned still 'in process' in mqc answerfield -->
<!-- s_asset_life_cash still 'in process' in mqc answerfield -->
<!-- s_sp_asset_life_cash still 'in process' in mqc answerfield -->

<!-- END MQC -->

