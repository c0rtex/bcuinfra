<?php
$screeningID = 'null';
if (isset($_GET['screeningID'])) {
$screeningID = $_GET['screeningID'];
}
$query_gridRow = "
select g.code as gcode, g.sort as gsort
		from question q, question_gridrow qg, gridrow g
		where q.question_code='incomegrid'
			and q.question_id=qg.question_id
			and qg.gridrow_id=g.gridrow_id
			and g.exclude_flag=0
			and g.gridrow_id not in (
				select gridrow_id
				from subset_gridrow
				where subset_id=".$subset_id."
					and exclude_flag=1
			)
		union
		select g.code as gcode, g.sort as gsort
		from question q, question_gridrow qg, gridrow g
		where q.question_code='incomegrid'
			and q.question_id=qg.question_id
			and qg.gridrownothing_id=g.gridrownothing_id
			and g.exclude_flag=1
			and g.gridrownothing_id in (
				select gridrownothing_id
				from subset_gridrownothing
				where subset_id=".$subset_id."
					and exclude_flag=0
			)
		order by gsort
";
//$gridrow_query = $bcudb->get_results($query_gridRow);
//foreach($gridrownothing_query as $gridrownothingObj):
// $gridCode = $gridrownothingObj->code;
// echo '<h4>'.$gridCode.'</h4>';
//endforeach;

//get af values checked
$responseType = 2;
$answerfieldValue_s_asset_ = 0;
$answerfieldValue_s_income_ = 0;

//7195	ck_pri_retire
$answerfieldValue_ck_pri_retire  = getScreeningAnswerfield($soapClient,7195,$screeningID,$responseType);
//echo "check:".$answerfieldValue_ck_pri_retire;
if ($answerfieldValue_ck_pri_retire == 'y' ) {
$answerfieldValue_ck_pri_retire = 'checked';
}
$answerfieldValue_s_income_pri_retire =  getScreeningAnswerfield($soapClient,4342,$screeningID,1);
$answerfieldValue_sp_income_pri_retire =  getScreeningAnswerfield($soapClient,4343,$screeningID,1);
$answerfieldValue_s_sp_income_pri_retire_simple =  getScreeningAnswerfield($soapClient,5198,$screeningID,1);
$answerfieldValue_hh_income_pri_retire_simple =  getScreeningAnswerfield($soapClient,5199,$screeningID,1);


//7196	ck_dividends
$answerfieldValue_ck_dividends  = getScreeningAnswerfield($soapClient,7196,$screeningID,$responseType);
if ($answerfieldValue_ck_dividends == 'y' ) {
$answerfieldValue_ck_dividends = 'checked';
}
$answerfieldValue_s_income_dividends  =  getScreeningAnswerfield($soapClient,345,$screeningID,1);
$answerfieldValue_sp_income_dividends  =  getScreeningAnswerfield($soapClient,346,$screeningID,1);
$answerfieldValue_s_sp_income_dividends_simple  =  getScreeningAnswerfield($soapClient,5200,$screeningID,1);
$answerfieldValue_hh_income_dividends_simple  =  getScreeningAnswerfield($soapClient,5201,$screeningID,1);

//7197	ck_ssi
$answerfieldValue_ck_ssi  = getScreeningAnswerfield($soapClient,7197,$screeningID,$responseType);
if ($answerfieldValue_ck_ssi == 'y' ) {
$answerfieldValue_ck_ssi = 'checked';
}
$answerfieldValue_s_income_ssi =  getScreeningAnswerfield($soapClient,373,$screeningID,1);
$answerfieldValue_sp_income_ssi  =  getScreeningAnswerfield($soapClient,374,$screeningID,1);
$answerfieldValue_s_sp_income_ssi_simple =  getScreeningAnswerfield($soapClient,5202,$screeningID,1);
$answerfieldValue_hh_income_ssi_simple  =  getScreeningAnswerfield($soapClient,5203,$screeningID,1);

//7198	ck_ss_disable
$answerfieldValue_ck_ss_disable  = getScreeningAnswerfield($soapClient,7198,$screeningID,$responseType);
if ($answerfieldValue_ck_ss_disable == 'y' ) {
$answerfieldValue_ck_ss_disable = 'checked';
}
$answerfieldValue_s_income_ss_disable =  getScreeningAnswerfield($soapClient,365,$screeningID,1);
$answerfieldValue_sp_income_ss_disable  =  getScreeningAnswerfield($soapClient,366,$screeningID,1);
$answerfieldValue_s_sp_income_ss_disable_simple  =  getScreeningAnswerfield($soapClient,5204,$screeningID,1);
$answerfieldValue_hh_income_ss_disable_simple  =  getScreeningAnswerfield($soapClient,5205,$screeningID,1);

//7199	ck_ss_retire
$answerfieldValue_ck_ss_retire  = getScreeningAnswerfield($soapClient,7199,$screeningID,$responseType);
if ($answerfieldValue_ck_ss_retire == 'y' ) {
$answerfieldValue_ck_ss_retire = 'checked';
}
$answerfieldValue_s_income_ss_retire =  getScreeningAnswerfield($soapClient,369,$screeningID,1);
$answerfieldValue_sp_income_ss_retire  =  getScreeningAnswerfield($soapClient,370,$screeningID,1);
$answerfieldValue_s_sp_income_ss_retire_simple  =  getScreeningAnswerfield($soapClient,5206,$screeningID,1);
$answerfieldValue_hh_income_ss_retire_simple  =  getScreeningAnswerfield($soapClient,5207,$screeningID,1);

//7200	ck_vet_ben
$answerfieldValue_ck_vet_ben  = getScreeningAnswerfield($soapClient,7200,$screeningID,$responseType);
if ($answerfieldValue_ck_vet_ben == 'y' ) {
$answerfieldValue_ck_vet_ben = 'checked';
}
$answerfieldValue_s_income_vet_ben  =  getScreeningAnswerfield($soapClient,377,$screeningID,1);
$answerfieldValue_sp_income_vet_ben   =  getScreeningAnswerfield($soapClient,378,$screeningID,1);
$answerfieldValue_s_sp_income_vet_ben_simple  =  getScreeningAnswerfield($soapClient,5210,$screeningID,1);
$answerfieldValue_hh_income_vet_ben_simple  =  getScreeningAnswerfield($soapClient,5211,$screeningID,1);

//7201	ck_unemployment
$answerfieldValue_ck_unemployment  = getScreeningAnswerfield($soapClient,7201,$screeningID,$responseType);
if ($answerfieldValue_ck_unemployment == 'y' ) {
$answerfieldValue_ck_unemployment = 'checked';
}
$answerfieldValue_s_income_unemployment  =  getScreeningAnswerfield($soapClient,6827,$screeningID,1);
$answerfieldValue_sp_income_unemployment   =  getScreeningAnswerfield($soapClient,6828,$screeningID,1);
$answerfieldValue_s_sp_income_unemployment_simple  =  getScreeningAnswerfield($soapClient,6831,$screeningID,1);
$answerfieldValue_hh_income_unemployment_simple  =  getScreeningAnswerfield($soapClient,6832,$screeningID,1);

//7202	ck_unemploy
$answerfieldValue_ck_unemploy  = getScreeningAnswerfield($soapClient,7202,$screeningID,$responseType);
if ($answerfieldValue_ck_unemploy == 'y' ) {
$answerfieldValue_ck_unemploy = 'checked';
}
$answerfieldValue_s_income_unemploy  =  getScreeningAnswerfield($soapClient,381,$screeningID,1);
$answerfieldValue_sp_income_unemploy   =  getScreeningAnswerfield($soapClient,382,$screeningID,1);
//$answerfieldValue_s_sp_income_unemploy_simple  =  getScreeningAnswerfield($soapClient,6831,$screeningID,1);
$answerfieldValue_s_sp_income_unemploy_simple  =  getScreeningAnswerfield($soapClient,5212,$screeningID,1);
//$answerfieldValue_s_sp_income_unemploy_simple  =  getScreeningAnswerfield($soapClient,5225,$screeningID,1);
//$answerfieldValue_hh_income_unemploy_simple  =  getScreeningAnswerfield($soapClient,6832,$screeningID,1);
$answerfieldValue_hh_income_unemploy_simple  =  getScreeningAnswerfield($soapClient,5213,$screeningID,1);
//$answerfieldValue_hh_income_unemploy_simple  =  getScreeningAnswerfield($soapClient,5227,$screeningID,1);
//7203	ck_tanf
$answerfieldValue_ck_tanf = getScreeningAnswerfield($soapClient,7203,$screeningID,$responseType);
if ($answerfieldValue_ck_tanf == 'y' ) {
$answerfieldValue_ck_tanf = 'checked';
}
$answerfieldValue_s_income_tanf  =  getScreeningAnswerfield($soapClient,389,$screeningID,1);
$answerfieldValue_sp_income_tanf   =  getScreeningAnswerfield($soapClient,390,$screeningID,1);
$answerfieldValue_s_sp_income_tanf_simple  =  getScreeningAnswerfield($soapClient,5214,$screeningID,1);
$answerfieldValue_hh_income_tanf_simple  =  getScreeningAnswerfield($soapClient,5215,$screeningID,1);

//7204	ck_cash_assist
$answerfieldValue_ck_cash_assist  = getScreeningAnswerfield($soapClient,7204,$screeningID,$responseType);
if ($answerfieldValue_ck_cash_assist == 'y' ) {
$answerfieldValue_ck_cash_assist = 'checked';
}
$answerfieldValue_s_income_cash_assist  =  getScreeningAnswerfield($soapClient,393,$screeningID,1);
$answerfieldValue_sp_income_cash_assist   =  getScreeningAnswerfield($soapClient,394,$screeningID,1);
$answerfieldValue_s_sp_income_cash_assist_simple  =  getScreeningAnswerfield($soapClient,5216,$screeningID,1);
$answerfieldValue_hh_income_cash_assist_simple  =  getScreeningAnswerfield($soapClient,5217,$screeningID,1);

//7205	ck_other_nw
$answerfieldValue_ck_other_nw  = getScreeningAnswerfield($soapClient,7205,$screeningID,$responseType);
if ($answerfieldValue_ck_other_nw == 'y' ) {
$answerfieldValue_ck_other_nw = 'checked';
}
$answerfieldValue_s_income_other_nw  =  getScreeningAnswerfield($soapClient,417,$screeningID,1);
$answerfieldValue_sp_income_other_nw   =  getScreeningAnswerfield($soapClient,418,$screeningID,1);
$answerfieldValue_s_sp_income_other_nw_simple  =  getScreeningAnswerfield($soapClient,5218,$screeningID,1);
$answerfieldValue_hh_income_other_nw_simple  =  getScreeningAnswerfield($soapClient,5219,$screeningID,1);

//7206	ck_earned
$answerfieldValue_ck_earned  = getScreeningAnswerfield($soapClient,7206,$screeningID,$responseType);
if ($answerfieldValue_ck_earned == 'y' ) {
$answerfieldValue_ck_earned = 'checked';
}
$answerfieldValue_s_income_earned =  getScreeningAnswerfield($soapClient,401,$screeningID,1);
$answerfieldValue_sp_income_earned   =  getScreeningAnswerfield($soapClient,402,$screeningID,1);
//$answerfieldValue_s_sp_income_earned_simple  =  getScreeningAnswerfield($soapClient,5225,$screeningID,1);
$answerfieldValue_s_sp_income_earned_simple  =  getScreeningAnswerfield($soapClient,5220,$screeningID,1);
//$answerfieldValue_hh_income_earned_simple  =  getScreeningAnswerfield($soapClient,5227,$screeningID,1);
$answerfieldValue_hh_income_earned_simple  =  getScreeningAnswerfield($soapClient,5221,$screeningID,1);
//echo "prefill".$screeningID.$answerfieldValue_s_income_earned;

//7207	ck_cash
$answerfieldValue_ck_cash  = getScreeningAnswerfield($soapClient,7207,$screeningID,$responseType);
if ($answerfieldValue_ck_cash == 'y' ) {
$answerfieldValue_ck_cash = 'checked';
}
$answerfieldValue_s_asset_cash  =  getScreeningAnswerfield($soapClient,4346,$screeningID,1);
$answerfieldValue_sp_asset_cash   =  getScreeningAnswerfield($soapClient,4347,$screeningID,1);
$answerfieldValue_s_sp_asset_cash_simple   =  getScreeningAnswerfield($soapClient,5234,$screeningID,1);
$answerfieldValue_hh_asset_cash_simple  =  getScreeningAnswerfield($soapClient,5235,$screeningID,1);

//7208	ck_auto1
$answerfieldValue_ck_auto1  = getScreeningAnswerfield($soapClient,7208,$screeningID,$responseType);
if ($answerfieldValue_ck_auto1 == 'y' ) {  
$answerfieldValue_ck_auto1 = 'checked';
}
$answerfieldValue_s_asset_auto1  =  getScreeningAnswerfield($soapClient,441,$screeningID,1);
$answerfieldValue_sp_asset_auto1   =  getScreeningAnswerfield($soapClient,442,$screeningID,1);
$answerfieldValue_s_sp_asset_auto1_simple   =  getScreeningAnswerfield($soapClient,5242,$screeningID,1);
$answerfieldValue_hh_asset_auto1_simple  =  getScreeningAnswerfield($soapClient,5243,$screeningID,1);


//7209	ck_auto2
$answerfieldValue_ck_auto2  = getScreeningAnswerfield($soapClient,7209,$screeningID,$responseType);
if ($answerfieldValue_ck_auto2 == 'y' ) {
$answerfieldValue_ck_auto2 = 'checked';
}
$answerfieldValue_s_asset_auto2  =  getScreeningAnswerfield($soapClient,445,$screeningID,1);
$answerfieldValue_sp_asset_auto2   =  getScreeningAnswerfield($soapClient,446,$screeningID,1);
$answerfieldValue_s_sp_asset_auto2_simple   =  getScreeningAnswerfield($soapClient,5244,$screeningID,1);
$answerfieldValue_hh_asset_auto2_simple  =  getScreeningAnswerfield($soapClient,5245,$screeningID,1);


//7210	ck_home
$answerfieldValue_ck_home  = getScreeningAnswerfield($soapClient,7210,$screeningID,$responseType);
if ($answerfieldValue_ck_home == 'y' ) {
$answerfieldValue_ck_home = 'checked';
}
$answerfieldValue_s_asset_home  = getScreeningAnswerfield($soapClient,317,$screeningID,1);
$answerfieldValue_sp_asset_home   =  getScreeningAnswerfield($soapClient,318,$screeningID,1);
$answerfieldValue_s_sp_asset_home_simple   =  getScreeningAnswerfield($soapClient,5248,$screeningID,1);
$answerfieldValue_hh_asset_home_simple  =  getScreeningAnswerfield($soapClient,5249,$screeningID,1);


//7211	ck_retirement
$answerfieldValue_ck_retirement  = getScreeningAnswerfield($soapClient,7211,$screeningID,$responseType);
if ($answerfieldValue_ck_retirement == 'y' ) {
$answerfieldValue_ck_retirement = 'checked';
}
$answerfieldValue_s_asset_retirement  =  getScreeningAnswerfield($soapClient,309,$screeningID,1);
$answerfieldValue_sp_asset_retirement   = getScreeningAnswerfield($soapClient,310,$screeningID,1);
$answerfieldValue_s_sp_asset_retirement_simple   =  getScreeningAnswerfield($soapClient,5246,$screeningID,1);
$answerfieldValue_hh_asset_retirement_simple  =  getScreeningAnswerfield($soapClient,5247,$screeningID,1);


//7212	ck_stocks
$answerfieldValue_ck_stocks = getScreeningAnswerfield($soapClient,7212,$screeningID,$responseType);
if ($answerfieldValue_ck_stocks == 'y' ) {
$answerfieldValue_ck_stocks = 'checked';
}
$answerfieldValue_s_asset_stocks  =  getScreeningAnswerfield($soapClient,429,$screeningID,1);
$answerfieldValue_sp_asset_stocks   =  getScreeningAnswerfield($soapClient,430,$screeningID,1);
$answerfieldValue_s_sp_asset_stocks_simple   =  getScreeningAnswerfield($soapClient,5236,$screeningID,1);
$answerfieldValue_hh_asset_stocks_simple  =  getScreeningAnswerfield($soapClient,5237,$screeningID,1);


//7213	ck_life_cash
$answerfieldValue_ck_life_cash  = getScreeningAnswerfield($soapClient,7213,$screeningID,$responseType);
if ($answerfieldValue_ck_life_cash == 'y' ) {
$answerfieldValue_ck_life_cash = 'checked';
}
$answerfieldValue_s_asset_life_cash  =  getScreeningAnswerfield($soapClient,4350,$screeningID,1);
$answerfieldValue_sp_asset_life_cash   =  getScreeningAnswerfield($soapClient,4351,$screeningID,1);
$answerfieldValue_s_sp_asset_life_cash_simple   = getScreeningAnswerfield($soapClient,5238,$screeningID,1);
$answerfieldValue_hh_asset_life_cash_simple  =  getScreeningAnswerfield($soapClient,5239,$screeningID,1);

//7214	ck_life_face
$answerfieldValue_ck_life_face  = getScreeningAnswerfield($soapClient,7214,$screeningID,$responseType);
if ($answerfieldValue_ck_life_face == 'y' ) {
$answerfieldValue_ck_life_face = 'checked';
}
$answerfieldValue_s_asset_life_face  =  getScreeningAnswerfield($soapClient,437,$screeningID,1);
$answerfieldValue_sp_asset_life_face   =  getScreeningAnswerfield($soapClient,438,$screeningID,1);
$answerfieldValue_s_sp_asset_life_face_simple   =  getScreeningAnswerfield($soapClient,5240,$screeningID,1);
$answerfieldValue_hh_asset_life_face_simple  =  getScreeningAnswerfield($soapClient,5241,$screeningID,1);


//7215	ck_revocable
$answerfieldValue_ck_revocable  = getScreeningAnswerfield($soapClient,7215,$screeningID,$responseType);
if ($answerfieldValue_ck_revocable == 'y' ) {
$answerfieldValue_ck_revocable = 'checked';
}
$answerfieldValue_s_asset_revocable  =  getScreeningAnswerfield($soapClient,325,$screeningID,1);
$answerfieldValue_sp_asset_revocable   =  getScreeningAnswerfield($soapClient,326,$screeningID,1);
$answerfieldValue_s_sp_asset_revocable_simple   =  getScreeningAnswerfield($soapClient,5250,$screeningID,1);
$answerfieldValue_hh_asset_revocable_simple  =  getScreeningAnswerfield($soapClient,5251,$screeningID,1);


//7216	ck_irrevocable
$answerfieldValue_ck_irrevocable  = getScreeningAnswerfield($soapClient,7216,$screeningID,$responseType);
if ($answerfieldValue_ck_irrevocable == 'y' ) {
$answerfieldValue_ck_irrevocable = 'checked';
}
$answerfieldValue_s_asset_irrevocable  =  getScreeningAnswerfield($soapClient,329,$screeningID,1);
$answerfieldValue_sp_asset_irrevocable   =  getScreeningAnswerfield($soapClient,330,$screeningID,1);
$answerfieldValue_s_sp_asset_irrevocable_simple   =  getScreeningAnswerfield($soapClient,5252,$screeningID,1);
$answerfieldValue_hh_asset_irrevocable_simple  =  getScreeningAnswerfield($soapClient,5253,$screeningID,1);


//7217	ck_other_a
$answerfieldValue_ck_other_a  = getScreeningAnswerfield($soapClient,7217,$screeningID,$responseType);
if ($answerfieldValue_ck_other_a == 'y' ) {
$answerfieldValue_ck_other_a = 'checked';
}
$answerfieldValue_s_asset_other_a  =  getScreeningAnswerfield($soapClient,449,$screeningID,1);
$answerfieldValue_sp_asset_other_a   = getScreeningAnswerfield($soapClient,450,$screeningID,1);
$answerfieldValue_s_sp_asset_other_a_simple   =  getScreeningAnswerfield($soapClient,5254,$screeningID,1);
$answerfieldValue_hh_asset_other_a_simple  =  getScreeningAnswerfield($soapClient,5255,$screeningID,1);
 

//7218	ck_rr_ben
$answerfieldValue_ck_rr_ben  = getScreeningAnswerfield($soapClient,7218,$screeningID,$responseType);
if ($answerfieldValue_ck_rr_ben == 'y' ) {
$answerfieldValue_ck_rr_ben = 'checked';
}
$answerfieldValue_s_income_rr_ben  =  getScreeningAnswerfield($soapClient,385,$screeningID,1);
$answerfieldValue_sp_income_rr_ben   =  getScreeningAnswerfield($soapClient,386,$screeningID,1);
$answerfieldValue_s_sp_income_rr_ben_simple   =  getScreeningAnswerfield($soapClient,5208,$screeningID,1);
$answerfieldValue_hh_income_rr_ben_simple  =  getScreeningAnswerfield($soapClient,5209,$screeningID,1);


if ($questionCode == 'esi_grossmonthlyincome_question'){
echo "
	<div class='input'>                      	               	  
    	<div class='rownothing'>					
        	<div class='span2'>
				<div id='div_income_pri_retire' class='checkbox pull-right'>
					<label class='checkbox'><input type='checkbox' name='ck_pri_retire' id='ck_income_pri_retire' ".$answerfieldValue_ck_pri_retire." value='y' class='checkboxSubQuestionAdditional'></label> 
				</div>
			</div>
			<div class='span9' ><label>Pension / Retirement Benefits</label></div>
		</div>
		<div class='rownothing' id='subQuestionAdditional_ck_income_pri_retire' style='display:none'>
			<div class='rownothing' id='s_income_pri_retire'>
				<div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
				<div class='span7 input-prepend input-append'><span class='add-on'>$</span>
					<input type='text' name='s_income_pri_retire' value='".$answerfieldValue_s_income_pri_retire."' size='10' maxlength='10' onblur='chkDollar(this,value);'>
					<span class='add-on'>.00</span>
				</div>
			</div>
			<div class='rownothing' id='sp_income_pri_retire' >
				<div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_pri_retire' value='".$answerfieldValue_sp_income_pri_retire."' size='10' maxlength='10' onblur='chkDollar(this,value);'><span class='add-on'>.00</span></label>
				</div>
			</div>
			<div class='rownothing' id='s_sp_income_pri_retire' >
				<div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_pri_retire_simple' value='".$answerfieldValue_s_sp_income_pri_retire_simple."' size='10' maxlength='10' onblur='chkDollar(this,value);'><span class='add-on'>.00</span></label></div>
			</div>
			<div class='rownothing' id='hh_income_pri_retire' >
				<div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_pri_retire_simple' value='".$answerfieldValue_hh_income_pri_retire_simple."' size='10' maxlength='10' onblur='chkDollar(this,value);'><span class='add-on'>.00</span></label>
				</div>
			</div>
		</div> <!-- end of subQuestionAdditonal class -->
	</div>
	<div class='rownothing subQuestion' >
		<div class='span2'>
			<div id='div_ck_income_dividends' class='checkbox pull-right'>
            	<label class='checkbox'><input type='checkbox' name='ck_dividends' id='ck_income_dividends' value='y' ".$answerfieldValue_ck_dividends." class='checkboxSubQuestionAdditional'></label> 
         	</div>
		</div>
		<div class='span9' ><label>Dividends/Interest</label></div>
	</div>

	<div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_dividends' style='display:none'>
		<div class='rownothing' id='s_income_dividends' >
			<div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
				<div class='span7 input-prepend input-append'><span class='add-on'>$</span>
					<input type='text' name='s_income_dividends' value='".$answerfieldValue_s_income_dividends."' size='10' maxlength='10' onblur='chkDollar(this,value);'><span class='add-on'>.00</span>
				</div>
			</div>
			<div class='rownothing' id='sp_income_dividends' >
				<div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_dividends' value='".$answerfieldValue_sp_income_dividends."' size='10' maxlength='10' onblur='chkDollar(this,value);'><span class='add-on'>.00</span></label>
				</div>
			</div>
			<div class='rownothing' id='s_sp_income_dividends' >
            	<div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_dividends_simple' value='".$answerfieldValue_s_sp_income_dividends_simple."' size='10' maxlength='10' onblur='chkDollar(this,value);'><span class='add-on'>.00</span></label>
				</div>
			</div>
			<div class='rownothing' id='hh_income_dividends' >
            	<div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_dividends_simple' value='".$answerfieldValue_hh_income_dividends_simple."' size='10' maxlength='10' onblur='chkDollar(this,value);'><span class='add-on'>.00</span></label>
			</div>
		</div>
	</div>
	<div class='rownothing ' >
		<div class='span2'>
        	<div id='div_ck_income_ssi' class='checkbox pull-right'>
          		<label class='checkbox'><input type='checkbox' name='ck_ssi' id='ck_income_ssi' ".$answerfieldValue_ck_ssi." value='y' class='checkboxSubQuestionAdditional'></label> 
        	</div>
      	</div>
		<div class='span9' ><label>Supplemental Security Income</label></div>
	</div>
	<div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_ssi' style='display:none'>
     	<div class='rownothing' id='s_income_ssi' >
			<div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        	<div class='span7 input-prepend input-append'><span class='add-on'>$</span>
				<input type='text' name='s_income_ssi' value='".$answerfieldValue_s_income_ssi."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          		<span class='add-on'>.00</span>
			</div>
      	</div>
      	<div class='rownothing' id='sp_income_ssi' >
			<div class='span4'><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_ssi' value='".$answerfieldValue_sp_income_ssi."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
      		</div>
   		</div>
    	<div class='rownothing' id='s_sp_income_ssi' >
        	<div class='span4'><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div>
			<div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_ssi_simple' value='".$answerfieldValue_s_sp_income_ssi_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
 		</div>
    	<div class='rownothing' id='hh_income_ssi' >
        	<div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div>
			<div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_ssi_simple' value='".$answerfieldValue_hh_income_ssi_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
      	</div>
	</div>
	<div class='rownothing subQuestion' >
		<div class='span2'>
        	<div id='div_ck_income_ss_disable' class='checkbox pull-right'>
          		<label class='checkbox'><input type='checkbox' name='ck_ss_disable' id='ck_income_ss_disable' value='y' ".$answerfieldValue_ck_ss_disable." class='checkboxSubQuestionAdditional'></label> 
        	</div>
      	</div>
		<div class='span9' ><label>Social Security Disability</label></div>

    </div>
	
    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_ss_disable' style='display:none'>
      	<div class='rownothing' id='s_income_ss_disable' >
			<div class='span4'><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        	<div class='span7 input-prepend input-append'><span class='add-on'>$</span>
				<input type='text' name='s_income_ss_disable' value='".$answerfieldValue_s_income_ss_disable."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          		<span class='add-on'>.00</span>
			</div>
    	</div>
      	<div class='rownothing' id='sp_income_ss_disable' >
			<div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div>
			<div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_ss_disable' value='".$answerfieldValue_sp_income_ss_disable."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
      	</div>
      	<div class='rownothing' id='s_sp_income_ss_disable' >
        	<div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div>
			<div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_ss_disable_simple' value='".$answerfieldValue_s_sp_income_ss_disable_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
  		</div>
      	<div class='rownothing' id='hh_income_ss_disable' >
        	<div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div>
			<div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_ss_disable_simple' value='".$answerfieldValue_hh_income_ss_disable_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
      	</div>
	</div>
	<div class='rownothing subQuestion' >
		<div class='span2'>
        	<div id='div_ck_income_ss_retire' class='checkbox pull-right'>
          		<label class='checkbox'><input type='checkbox' name='ck_ss_retire' id='ck_income_ss_retire' value='y' ".$answerfieldValue_ck_ss_retire." class='checkboxSubQuestionAdditional'></label> 
        	</div>
      	</div>
		<div class='span9' ><label>Social Security Retirement / Survivor Benefits</label></div>
	</div>
	<div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_ss_retire' style='display:none'>
      	<div class='rownothing' id='s_income_ss_retire' >

        	<div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        	<div class='span7 input-prepend input-append'><span class='add-on'>$</span>

          		<input type='text' name='s_income_ss_retire' value='".$answerfieldValue_s_income_ss_retire."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          		<span class='add-on'>.00</span>
			</div>
    	</div>
    	<div class='rownothing' id='sp_income_ss_retire' >

     		<div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div>
			<div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_ss_retire' value='".$answerfieldValue_sp_income_ss_retire."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
   		</div>
   		<div class='rownothing' id='s_sp_income_ss_retire' >
        	<div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_ss_retire_simple' value='".$answerfieldValue_s_sp_income_ss_retire_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
      	</div>
      	<div class='rownothing' id='hh_income_ss_retire' >
        	<div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div>
			<div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_ss_retire_simple' value='".$answerfieldValue_hh_income_ss_retire_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
      	</div>
	</div>

	<div class='rownothing subQuestion' >

      <div class='span2'>
        <div id='div_ck_income_rr_ben' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_rr_ben' id='ck_income_rr_ben' value='y' ".$answerfieldValue_ck_rr_ben." class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>

      <div class='span9' ><label>Railroad Retirements Benefits</label> 
      </div>

   	</div>

    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_rr_ben' style='display:none'>
      	<div class='rownothing' id='s_income_rr_ben' >

        	<div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        	<div class='span7 input-prepend input-append'><span class='add-on'>$</span>
				<input type='text' name='s_income_rr_ben' value='".$answerfieldValue_s_income_rr_ben."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          		<span class='add-on'>.00</span>
			</div>
      	</div>
      	<div class='rownothing' id='sp_income_rr_ben' >
			<div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div>
			<div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_rr_ben' value='".$answerfieldValue_sp_income_rr_ben."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
   		</div>
    	<div class='rownothing' id='s_sp_income_rr_ben' >
    		<div class='span4'><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_rr_ben_simple' value='".$answerfieldValue_s_sp_income_rr_ben_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
      	</div>
      	<div class='rownothing' id='hh_income_rr_ben' >
        	<div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_rr_ben_simple' value='".$answerfieldValue_hh_income_rr_ben_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
      	</div>
	</div>

<div class='rownothing subQuestion' >

      <div class='span2'>
        <div id='div_ck_income_vet_ben' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_vet_ben' id='ck_income_vet_ben' value='y' ".$answerfieldValue_ck_vet_ben." class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>

      <div class='span9' ><label>Veterans Benefits</label> 
      </div>

    </div>

    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_vet_ben' style='display:none'>
      <div class='rownothing' id='s_income_vet_ben' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>

          <input type='text' name='s_income_vet_ben' value='".$answerfieldValue_s_income_vet_ben."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>

        </div>
      </div>
      <div class='rownothing' id='sp_income_vet_ben' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_vet_ben' value='".$answerfieldValue_sp_income_vet_ben."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_income_vet_ben' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_vet_ben_simple' value='".$answerfieldValue_s_sp_income_vet_ben_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_income_vet_ben' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_vet_ben_simple' value='".$answerfieldValue_hh_income_vet_ben_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>


    </div>

<div class='rownothing subQuestion' >

      <div class='span2'>
        <div id='div_ck_income_unemployment' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_unemployment' id='ck_income_unemployment' value='y' ".$answerfieldValue_ck_unemployment." class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>

      <div class='span9' ><label>Unemployment Insurance</label> 
      </div>

    </div>

    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_unemployment' style='display:none'>
      <div class='rownothing' id='s_income_unemployment' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>

          <input type='text' name='s_income_unemployment' value='".$answerfieldValue_s_income_unemployment."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>

        </div>
      </div>
      <div class='rownothing' id='sp_income_unemployment' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_unemployment' value='".$answerfieldValue_sp_income_unemployment."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_income_unemployment' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_unemployment_simple' value='".$answerfieldValue_s_sp_income_unemployment_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_income_unemployment' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_unemployment_simple' value='".$answerfieldValue_hh_income_unemployment_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>


    </div>

<div class='rownothing subQuestion' >

      <div class='span2'>
        <div id='div_ck_income_unemploy' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_unemploy' id='ck_income_unemploy' value='y' ".$answerfieldValue_ck_unemploy."  class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>

      <div class='span9' ><label>Workers Compensation</label> 
      </div>

    </div>

    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_unemploy' style='display:none'>
      <div class='rownothing' id='s_income_unemploy' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>

          <input type='text' name='s_income_unemploy' value='".$answerfieldValue_s_income_unemploy."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>

        </div>
      </div>
      <div class='rownothing' id='sp_income_unemploy' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_unemploy' value='".$answerfieldValue_sp_income_unemploy."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_income_unemploy' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_unemploy_simple' value='".$answerfieldValue_s_sp_income_unemploy_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_income_unemploy' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_unemploy_simple' value='".$answerfieldValue_hh_income_unemploy_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>


    </div>

<div class='rownothing subQuestion' >

      <div class='span2'>
        <div id='div_ck_income_tanf' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_tanf' id='ck_income_tanf' value='y' ".$answerfieldValue_ck_tanf." class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>

      <div class='span9' ><label><a title='' data-content='Temporary Assistance to Needy Families' data-placement='top' data-toggle='popover' href='#' data-original-title='TANF'>TANF</a></label> 
      </div>

    </div>

    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_tanf' style='display:none'>
      <div class='rownothing' id='s_income_tanf' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>

          <input type='text' name='s_income_tanf' value='".$answerfieldValue_s_income_tanf."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>

        </div>
      </div>
      <div class='rownothing' id='sp_income_tanf' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_tanf' value='".$answerfieldValue_sp_income_tanf."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_income_tanf' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_tanf_simple' value='".$answerfieldValue_s_sp_income_tanf_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_income_tanf' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_tanf_simple' value='".$answerfieldValue_hh_income_tanf_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>


    </div>

<div class='rownothing subQuestion' >

      <div class='span2'>
        <div id='div_ck_income_cash_assist' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_cash_assist' id='ck_income_cash_assist' ".$answerfieldValue_ck_cash_assist."  value='y' ".$answerfieldValue_ck_cash_assist." class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>

      <div class='span9' ><label><a title='' data-content='Include programs such as: Public Assistance, General Assistance, or any other state income assistance program.' data-placement='top' data-toggle='popover' href='#' data-original-title='Cash Assistance'>Cash Assistance</a></label> 
      </div>

    </div>

    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_cash_assist' style='display:none'>
      <div class='rownothing' id='s_income_cash_assist' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>

          <input type='text' name='s_income_cash_assist' value='".$answerfieldValue_s_income_cash_assist."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>

        </div>
      </div>
      <div class='rownothing' id='sp_income_cash_assist' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_cash_assist' value='".$answerfieldValue_sp_income_cash_assist."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_income_cash_assist' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_cash_assist_simple' value='".$answerfieldValue_s_sp_income_cash_assist_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_income_cash_assist' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_cash_assist_simple' value='".$answerfieldValue_hh_income_cash_assist_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>


    </div>

<div class='rownothing subQuestion' >

      <div class='span2'>
        <div id='div_ck_income_other_nw' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_other_nw' id='ck_income_other_nw' value='y' ".$answerfieldValue_ck_other_nw." class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>

      <div class='span9' ><label><a title='' data-content='Include all other income not included above such as: private disability insurance benefits, union benefits, rental or boarder income, alimony, black lung benefits, etc.' data-placement='top' data-toggle='popover' href='#' data-original-title='Other Non-Work Income'>Other Non-Work Income</a></label> 
      </div>

    </div>

    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_other_nw' style='display:none'>
      <div class='rownothing' id='s_income_other_nw' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>

          <input type='text' name='s_income_other_nw' value='".$answerfieldValue_s_income_other_nw."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>

        </div>
      </div>
      <div class='rownothing' id='sp_income_other_nw' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_other_nw' value='".$answerfieldValue_sp_income_other_nw."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_income_other_nw' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_other_nw_simple' value='".$answerfieldValue_s_sp_income_other_nw_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_income_other_nw' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_other_nw_simple' value='".$answerfieldValue_hh_income_other_nw_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>


    </div>

<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_income_earned' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_earned' id='ck_income_earned' value='y' ".$answerfieldValue_ck_earned." class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>
      		<div class='span9' >
				<label>Work Income</label>
			</div>
 </div>
    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_earned' style='display:none'>
      <div class='rownothing' id='s_income_earned' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>
          <input type='text' name='s_income_earned' value='".$answerfieldValue_s_income_earned."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_income_earned' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_earned' value='".$answerfieldValue_sp_income_earned."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_income_earned' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_earned_simple' value='".$answerfieldValue_s_sp_income_earned_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_income_earned' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_earned_simple' value='".$answerfieldValue_hh_income_earned_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>




";
}
elseif (1 == 1){
echo "
				<div class='input'>
                        	
                  			

<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_cash' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_cash' id='ck_asset_cash' value='y' ".$answerfieldValue_ck_cash." class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>
      		<div class='span9' >
				<label><a title='' data-content='Include all cash, bank accounts, checking accounts, savings accounts, credit union accounts, certificates of deposit, etc.' data-placement='top' data-toggle='popover' href='#' data-original-title='Cash/Cash Equivalent'>Cash/Cash Equivalent</a></label>
			</div>
 </div>
    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_asset_cash' style='display:none'>
      <div class='rownothing' id='s_asset_cash' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>
          <input type='text' name='s_asset_cash' value='".$answerfieldValue_s_asset_cash."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_cash' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_cash' value='".$answerfieldValue_sp_asset_cash."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_cash' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_cash_simple' value='".$answerfieldValue_s_sp_asset_cash_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_cash' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_cash_simple' value='".$answerfieldValue_hh_asset_cash_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>
<!-- Auto 1 -->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_auto1' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_auto1' id='ck_asset_auto1' value='y' ".$answerfieldValue_ck_auto1." class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>
      		<div class='span9' >
				<label><a title='' data-content='If this is your only vehicle, enter the Blue Book value of your vehicle in this rownothing.  If you have more than one vehicle, enter the Blue Book value of your most valuable vehicle in this rownothing.  If you do not know the Blue Book value of your car, you can go to www.kbb.com to find out.  You should also feel free to estimate, if necessary.' data-placement='top' data-toggle='popover' href='#' data-original-title='Automobile'>Automobile</a></label>
			</div>
 </div>
    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_asset_auto1' style='display:none'>
      <div class='rownothing' id='s_asset_auto1' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>
          <input type='text' name='s_asset_auto1' value='".$answerfieldValue_s_asset_auto1."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_auto1' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_auto1' value='".$answerfieldValue_sp_asset_auto1."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_auto1' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_auto1_simple' value='".$answerfieldValue_s_sp_asset_auto1_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_auto1' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_auto1_simple' value='".$answerfieldValue_hh_asset_auto1_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>

<!-- Auto 2 -->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_auto2' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_auto2' id='ck_asset_auto2' value='y' ".$answerfieldValue_ck_auto2." class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>
      		<div class='span9' >
				<label><a title='' data-content='Indicate value of second car in family, if any.' data-placement='top' data-toggle='popover' href='#' data-original-title='Automobile: Vehicle 2'>Automobile: Vehicle 2</a></label>
			</div>
 </div>
    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_asset_auto2' style='display:none'>
      <div class='rownothing' id='s_asset_auto2' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>
          <input type='text' name='s_asset_auto2' value='".$answerfieldValue_s_asset_auto2."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_auto2' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_auto2' value='".$answerfieldValue_sp_asset_auto2."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_auto2' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_auto2_simple' value='".$answerfieldValue_s_sp_asset_auto2_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_auto2' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_auto2_simple' value='".$answerfieldValue_hh_asset_auto2_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>  
                 
 <!-- home -->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_home' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_home' id='ck_asset_home' value='y' ".$answerfieldValue_ck_home." class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>
      		<div class='span9' >
				<label>Value of Home</label>
			</div>
 </div>
    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_asset_home' style='display:none'>
      <div class='rownothing' id='s_asset_home' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>
          <input type='text' name='s_asset_home' value='".$answerfieldValue_s_asset_home."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_home' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_home' value='".$answerfieldValue_sp_asset_home."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_home' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_home_simple' value='".$answerfieldValue_s_sp_asset_home_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_home' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_home_simple' value='".$answerfieldValue_hh_asset_home_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>                			
                        
 <!-- retirement-->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_retirement' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_retirement' id='ck_asset_retirement' value='y' ".$answerfieldValue_ck_retirement." class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>
      		<div class='span9' >
				<label><a title='' data-content='Include IRA, 401K, Keogh, and any other retirement accounts.' data-placement='top' data-toggle='popover' href='#' data-original-title='Retirement Accounts'>Retirement Accounts</a></label>
			</div>
 </div>
    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_asset_retirement' style='display:none'>
      <div class='rownothing' id='s_asset_retirement' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>
          <input type='text' name='s_asset_retirement' value='".$answerfieldValue_s_asset_retirement."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_retirement' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_retirement' value='".$answerfieldValue_sp_asset_retirement."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_retirement' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_retirement_simple' value='".$answerfieldValue_s_sp_asset_retirement_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_retirement' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_retirement_simple' value='".$answerfieldValue_hh_asset_retirement_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>  


 <!-- investment -->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_stocks' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_stocks' id='ck_asset_stocks' value='y' ".$answerfieldValue_ck_stocks." class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>
      		<div class='span9' >
				<label><a title='' data-content='Include any investment accounts such as stocks, bonds, savings bonds, annuities, mutual funds, etc.' data-placement='top' data-toggle='popover' href='#' data-original-title='Investment Accounts'>Investment Accounts</a></label>
			</div>
 </div>
    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_asset_stocks' style='display:none'>
      <div class='rownothing' id='s_asset_stocks' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>
          <input type='text' name='s_asset_stocks' value='".$answerfieldValue_s_asset_stocks."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_stocks' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_stocks' value='".$answerfieldValue_sp_asset_stocks."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_stocks' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_stocks_simple' value='".$answerfieldValue_s_sp_asset_stocks_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_stocks' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_stocks_simple' value='".$answerfieldValue_hh_asset_stocks_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>       
 
  <!-- life cash -->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_life_cash' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_life_cash' id='ck_asset_life_cash' value='y' ".$answerfieldValue_ck_life_cash." class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>
      		<div class='span9' >
				<label><a title='' data-content='Include the cash value of your life insurance policy. The cash value is the amount that you may borrownothing from the policy. The insurance company that issued you the life insurance policy can provide you with the cash value amount of the policy.' data-placement='top' data-toggle='popover' href='#' data-original-title='Life Insurance: Cash Value'>Life Insurance: Cash Value</a></label>
			</div>
 </div>
    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_asset_life_cash' style='display:none'>
      <div class='rownothing' id='s_asset_life_cash' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>
          <input type='text' name='s_asset_life_cash' value='".$answerfieldValue_s_asset_life_cash."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_life_cash' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_life_cash' value='".$answerfieldValue_sp_asset_life_cash."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_life_cash' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_life_cash_simple' value='".$answerfieldValue_s_sp_asset_life_cash_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_life_cash' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_life_cash_simple' value='".$answerfieldValue_hh_asset_life_cash_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>      

 <!-- life face -->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_life_face' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_life_face' id='ck_asset_life_face' value='y' ".$answerfieldValue_ck_life_face." class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>
      		<div class='span9' >
				<label><a title='' data-content='The face value of your life insurance is the amount the policy will pay upon death. It does not include additional money you may get due to an accidental death or other special reasons. The insurance company that issued you the life insurance policy can provide you with the cash value amount of the policy.' data-placement='top' data-toggle='popover' href='#' data-original-title='Life Insurance: Face Value'>Life Insurance: Face Value</a></label>
			</div>
 </div>
    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_asset_life_face' style='display:none'>
      <div class='rownothing' id='s_asset_life_face' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>
          <input type='text' name='s_asset_life_face' value='".$answerfieldValue_s_asset_life_face."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_life_face' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_life_face' value='".$answerfieldValue_sp_asset_life_face."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_life_face' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_life_face_simple' value='".$answerfieldValue_s_sp_asset_life_face_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_life_face' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_life_face_simple' value='".$answerfieldValue_hh_asset_life_face_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>                     			

<!-- Revocable -->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_revocable' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_revocable' id='ck_asset_revocable'  value='y' ".$answerfieldValue_ck_revocable." class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>
      		<div class='span9' >
				<label><a title='' data-content='Some life insurance policies include an allotment for burial expenses. A revocable burial account means you can draw that money out of your policy during your lifetime from the burial expenses allotments.  The insurance company that issued the life insurance policy can provide the amount set aside for burial expenses.' data-placement='top' data-toggle='popover' href='#' data-original-title='Revocable Burial Account'>Burial Accounts: Revocable</a></label>
			</div>
 </div>
    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_asset_revocable' style='display:none'>
      <div class='rownothing' id='s_asset_revocable' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>
          <input type='text' name='s_asset_revocable' value='".$answerfieldValue_s_asset_revocable."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_revocable' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_revocable' value='".$answerfieldValue_sp_asset_revocable."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_revocable' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_revocable_simple' value='".$answerfieldValue_s_sp_asset_revocable_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_revocable' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_revocable_simple' value='".$answerfieldValue_hh_asset_revocable_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>                           
          					
<!-- irrevocable -->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_irrevocable' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_irrevocable' id='ck_asset_irrevocable' value='y' ".$answerfieldValue_ck_irrevocable." class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>
      		<div class='span9' >
				<label><a title='' data-content='Some life insurance policies include an allotment for burial expenses. An irrevocable burial account means you cannot draw that money out of your policy during your lifetime from the burial expenses allotments.' data-placement='top' data-toggle='popover' href='#' data-original-title='Irrevocable Burial Account'>Burial Accounts: Irrevocable</a></label>
			</div>
 </div>
    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_asset_irrevocable' style='display:none'>
      <div class='rownothing' id='s_asset_irrevocable' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>
          <input type='text' name='s_asset_irrevocable' value='".$answerfieldValue_s_asset_irrevocable."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_irrevocable' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_irrevocable' value='".$answerfieldValue_sp_asset_irrevocable."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_irrevocable' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_irrevocable_simple' value='".$answerfieldValue_s_sp_asset_irrevocable_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_irrevocable' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_irrevocable_simple' value='".$answerfieldValue_hh_asset_irrevocable_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div> 						

<!-- 0ther -->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_other' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_other_a' id='ck_asset_other' value='y' ".$answerfieldValue_ck_other_a." class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>
      		<div class='span9' >
				<label><a title='' data-content='Include any other assets not listed above such as: other real estate or properties, etc.' data-placement='top' data-toggle='popover' href='#' data-original-title='Other Assets'>Other Assets</a> </label>
			</div>
 </div>
    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_asset_other' style='display:none'>
      <div class='rownothing' id='s_asset_other' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>
          <input type='text' name='s_asset_other_a' value='".$answerfieldValue_s_asset_other_a."' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_other' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_other_a' value='".$answerfieldValue_sp_asset_other_a."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_other' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_other_a_simple' value='".$answerfieldValue_s_sp_asset_other_a_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_other' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_other_a_simple' value='".$answerfieldValue_hh_asset_other_a_simple."' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div> 
             			
                     		
</div>
";
}

?> 
