<?php
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
$responseType = 2;
$answerfieldValue_ck_cash  = getScreeningAnswerfield(7207,$screeningID,$responseType);

if ($questionCode == 'esi_grossmonthlyincome_question'){
echo "<strong>The value of </strong>".$answerfieldValue_ck_cash."<br><br>
	<div class='input'>                      	               	  
    	<div class='rownothing'>					
        	<div class='span2'>
				<div id='div_income_pri_retire' class='checkbox pull-right'>
					<label class='checkbox'><input type='checkbox' name='ck_pri_retire' id='ck_income_pri_retire' value='y' class='checkboxSubQuestionAdditional'></label> 
				</div>
			</div>
			<div class='span9' ><label>Pension / Retirement Benefits</label></div>
		</div>
		<div class='rownothing' id='subQuestionAdditional_ck_income_pri_retire' style='display:none'>
			<div class='rownothing' id='s_income_pri_retire'>
				<div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
				<div class='span7 input-prepend input-append'><span class='add-on'>$</span>
					<input type='text' name='s_income_pri_retire' value='' size='10' maxlength='10' onblur='chkDollar(this,value);'>
					<span class='add-on'>.00</span>
				</div>
			</div>
			<div class='rownothing' id='sp_income_pri_retire' >
				<div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_pri_retire' value='' size='10' maxlength='10' onblur='chkDollar(this,value);'><span class='add-on'>.00</span></label>
				</div>
			</div>
			<div class='rownothing' id='s_sp_income_pri_retire' >
				<div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_pri_retire_simple' value='' size='10' maxlength='10' onblur='chkDollar(this,value);'><span class='add-on'>.00</span></label></div>
			</div>
			<div class='rownothing' id='hh_income_pri_retire' >
				<div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_pri_retire_simple' value='' size='10' maxlength='10' onblur='chkDollar(this,value);'><span class='add-on'>.00</span></label>
				</div>
			</div>
		</div> <!-- end of subQuestionAdditonal class -->
	</div>
	<div class='rownothing subQuestion' >
		<div class='span2'>
			<div id='div_ck_income_dividends' class='checkbox pull-right'>
            	<label class='checkbox'><input type='checkbox' name='ck_dividends' id='ck_income_dividends' value='y' class='checkboxSubQuestionAdditional'></label> 
         	</div>
		</div>
		<div class='span9' ><label>Dividends/Interest</label></div>
	</div>

	<div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_dividends' style='display:none'>
		<div class='rownothing' id='s_income_dividends' >
			<div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
				<div class='span7 input-prepend input-append'><span class='add-on'>$</span>
					<input type='text' name='s_income_dividends' value='' size='10' maxlength='10' onblur='chkDollar(this,value);'><span class='add-on'>.00</span>
				</div>
			</div>
			<div class='rownothing' id='sp_income_dividends' >
				<div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_dividends' value='' size='10' maxlength='10' onblur='chkDollar(this,value);'><span class='add-on'>.00</span></label>
				</div>
			</div>
			<div class='rownothing' id='s_sp_income_dividends' >
            	<div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_dividends_simple' value='' size='10' maxlength='10' onblur='chkDollar(this,value);'><span class='add-on'>.00</span></label>
				</div>
			</div>
			<div class='rownothing' id='hh_income_dividends' >
            	<div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_dividends_simple' value='' size='10' maxlength='10' onblur='chkDollar(this,value);'><span class='add-on'>.00</span></label>
			</div>
		</div>
	</div>
	<div class='rownothing ' >
		<div class='span2'>
        	<div id='div_ck_income_ssi' class='checkbox pull-right'>
          		<label class='checkbox'><input type='checkbox' name='ck_ssi' id='ck_income_ssi' value='y' class='checkboxSubQuestionAdditional'></label> 
        	</div>
      	</div>
		<div class='span9' ><label>Supplemental Security Income</label></div>
	</div>
	<div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_ssi' style='display:none'>
     	<div class='rownothing' id='s_income_ssi' >
			<div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        	<div class='span7 input-prepend input-append'><span class='add-on'>$</span>
				<input type='text' name='s_income_ssi' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          		<span class='add-on'>.00</span>
			</div>
      	</div>
      	<div class='rownothing' id='sp_income_ssi' >
			<div class='span4'><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_ssi' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
      		</div>
   		</div>
    	<div class='rownothing' id='s_sp_income_ssi' >
        	<div class='span4'><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div>
			<div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_ssi_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
 		</div>
    	<div class='rownothing' id='hh_income_ssi' >
        	<div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div>
			<div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_ssi_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
      	</div>
	</div>
	<div class='rownothing subQuestion' >
		<div class='span2'>
        	<div id='div_ck_income_ss_disable' class='checkbox pull-right'>
          		<label class='checkbox'><input type='checkbox' name='ck_ss_disable' id='ck_income_ss_disable' value='y' class='checkboxSubQuestionAdditional'></label> 
        	</div>
      	</div>
		<div class='span9' ><label>Social Security Disability</label></div>

    </div>
	
    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_ss_disable' style='display:none'>
      	<div class='rownothing' id='s_income_ss_disable' >
			<div class='span4'><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        	<div class='span7 input-prepend input-append'><span class='add-on'>$</span>
				<input type='text' name='s_income_ss_disable' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          		<span class='add-on'>.00</span>
			</div>
    	</div>
      	<div class='rownothing' id='sp_income_ss_disable' >
			<div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div>
			<div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_ss_disable' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
      	</div>
      	<div class='rownothing' id='s_sp_income_ss_disable' >
        	<div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div>
			<div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_ss_disable_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
  		</div>
      	<div class='rownothing' id='hh_income_ss_disable' >
        	<div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div>
			<div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_ss_disable_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
      	</div>
	</div>
	<div class='rownothing subQuestion' >
		<div class='span2'>
        	<div id='div_ck_income_ss_retire' class='checkbox pull-right'>
          		<label class='checkbox'><input type='checkbox' name='ck_ss_retire' id='ck_income_ss_retire' value='y' class='checkboxSubQuestionAdditional'></label> 
        	</div>
      	</div>
		<div class='span9' ><label>Social Security Retirement / Survivor Benefits</label></div>
	</div>
	<div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_ss_retire' style='display:none'>
      	<div class='rownothing' id='s_income_ss_retire' >

        	<div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        	<div class='span7 input-prepend input-append'><span class='add-on'>$</span>

          		<input type='text' name='s_income_ss_retire' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          		<span class='add-on'>.00</span>
			</div>
    	</div>
    	<div class='rownothing' id='sp_income_ss_retire' >

     		<div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div>
			<div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_ss_retire' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
   		</div>
   		<div class='rownothing' id='s_sp_income_ss_retire' >
        	<div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_ss_retire_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
      	</div>
      	<div class='rownothing' id='hh_income_ss_retire' >
        	<div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div>
			<div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_ss_retire_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
      	</div>
	</div>

	<div class='rownothing subQuestion' >

      <div class='span2'>
        <div id='div_ck_income_rr_ben' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_rr_ben' id='ck_income_rr_ben' value='y' class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>

      <div class='span9' ><label>Railroad Retirements Benefits</label> 
      </div>

   	</div>

    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_rr_ben' style='display:none'>
      	<div class='rownothing' id='s_income_rr_ben' >

        	<div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        	<div class='span7 input-prepend input-append'><span class='add-on'>$</span>
				<input type='text' name='s_income_rr_ben' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          		<span class='add-on'>.00</span>
			</div>
      	</div>
      	<div class='rownothing' id='sp_income_rr_ben' >
			<div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div>
			<div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_rr_ben' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
   		</div>
    	<div class='rownothing' id='s_sp_income_rr_ben' >
    		<div class='span4'><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_rr_ben_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
      	</div>
      	<div class='rownothing' id='hh_income_rr_ben' >
        	<div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_rr_ben_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        	</div>
      	</div>
	</div>

<div class='rownothing subQuestion' >

      <div class='span2'>
        <div id='div_ck_income_vet_ben' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_vet_ben' id='ck_income_vet_ben' value='y' class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>

      <div class='span9' ><label>Veterans Benefits</label> 
      </div>

    </div>

    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_vet_ben' style='display:none'>
      <div class='rownothing' id='s_income_vet_ben' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>

          <input type='text' name='s_income_vet_ben' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>

        </div>
      </div>
      <div class='rownothing' id='sp_income_vet_ben' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_vet_ben' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_income_vet_ben' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_vet_ben_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_income_vet_ben' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_vet_ben_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>


    </div>

<div class='rownothing subQuestion' >

      <div class='span2'>
        <div id='div_ck_income_unemployment' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_unemployment' id='ck_income_unemployment' value='y' class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>

      <div class='span9' ><label>Unemployment Insurance</label> 
      </div>

    </div>

    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_unemployment' style='display:none'>
      <div class='rownothing' id='s_income_unemployment' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>

          <input type='text' name='s_income_unemployment' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>

        </div>
      </div>
      <div class='rownothing' id='sp_income_unemployment' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_unemployment' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_income_unemployment' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_unemployment_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_income_unemployment' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_unemployment_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>


    </div>

<div class='rownothing subQuestion' >

      <div class='span2'>
        <div id='div_ck_income_unemploy' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_unemploy' id='ck_income_unemploy' value='y' class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>

      <div class='span9' ><label>Workers Compensation</label> 
      </div>

    </div>

    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_unemploy' style='display:none'>
      <div class='rownothing' id='s_income_unemploy' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>

          <input type='text' name='s_income_unemploy' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>

        </div>
      </div>
      <div class='rownothing' id='sp_income_unemploy' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_unemploy' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_income_unemploy' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_unemploy_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_income_unemploy' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_unemploy_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>


    </div>

<div class='rownothing subQuestion' >

      <div class='span2'>
        <div id='div_ck_income_tanf' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_tanf' id='ck_income_tanf' value='y' class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>

      <div class='span9' ><label><a title='' data-content='Temporary Assistance to Needy Families' data-placement='top' data-toggle='popover' href='#' data-original-title='TANF'>TANF</a></label> 
      </div>

    </div>

    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_tanf' style='display:none'>
      <div class='rownothing' id='s_income_tanf' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>

          <input type='text' name='s_income_tanf' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>

        </div>
      </div>
      <div class='rownothing' id='sp_income_tanf' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_tanf' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_income_tanf' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_tanf_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_income_tanf' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_tanf_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>


    </div>

<div class='rownothing subQuestion' >

      <div class='span2'>
        <div id='div_ck_income_cash_assist' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_cash_assist' id='ck_income_cash_assist' value='y' class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>

      <div class='span9' ><label><a title='' data-content='Include programs such as: Public Assistance, General Assistance, or any other state income assistance program.' data-placement='top' data-toggle='popover' href='#' data-original-title='Cash Assistance'>Cash Assistance</a></label> 
      </div>

    </div>

    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_cash_assist' style='display:none'>
      <div class='rownothing' id='s_income_cash_assist' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>

          <input type='text' name='s_income_cash_assist' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>

        </div>
      </div>
      <div class='rownothing' id='sp_income_cash_assist' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_cash_assist' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_income_cash_assist' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_cash_assist_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_income_cash_assist' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_cash_assist_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>


    </div>

<div class='rownothing subQuestion' >

      <div class='span2'>
        <div id='div_ck_income_other_nw' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_other_nw' id='ck_income_other_nw' value='y' class='checkboxSubQuestionAdditional'></label> 
        </div>
      </div>

      <div class='span9' ><label><a title='' data-content='Include all other income not included above such as: private disability insurance benefits, union benefits, rental or boarder income, alimony, black lung benefits, etc.' data-placement='top' data-toggle='popover' href='#' data-original-title='Other Non-Work Income'>Other Non-Work Income</a></label> 
      </div>

    </div>

    <div class='subQuestionAdditional' id='subQuestionAdditional_ck_income_other_nw' style='display:none'>
      <div class='rownothing' id='s_income_other_nw' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Self&nbsp;</label></div>
        <div class='span7 input-prepend input-append'><span class='add-on'>$</span>

          <input type='text' name='s_income_other_nw' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>

        </div>
      </div>
      <div class='rownothing' id='sp_income_other_nw' >

        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_other_nw' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_income_other_nw' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_other_nw_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_income_other_nw' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_other_nw_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>


    </div>

<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_income_earned' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_earned' id='ck_income_earned' value='y' class='checkboxSubQuestionAdditional'></label> 
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
          <input type='text' name='s_income_earned' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_income_earned' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_income_earned' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_income_earned' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_income_earned_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_income_earned' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_income_earned_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
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
          <label class='checkbox'><input type='checkbox' name='ck_cash' id='ck_asset_cash' value='y' class='checkboxSubQuestionAdditional'></label> 
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
          <input type='text' name='s_asset_cash' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_cash' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_cash' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_cash' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_cash_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_cash' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_cash_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>
<!-- Auto 1 -->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_auto1' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_auto1' id='ck_asset_auto1' value='y' class='checkboxSubQuestionAdditional'></label> 
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
          <input type='text' name='s_asset_auto1' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_auto1' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_auto1' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_auto1' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_auto1_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_auto1' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_auto1_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>

<!-- Auto 2 -->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_auto2' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_auto2' id='ck_asset_auto2' value='y' class='checkboxSubQuestionAdditional'></label> 
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
          <input type='text' name='s_asset_auto2' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_auto2' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_auto2' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_auto2' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_auto2_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_auto2' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_auto2_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>  
                 
 <!-- home -->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_home' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_home' id='ck_asset_home' value='y' class='checkboxSubQuestionAdditional'></label> 
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
          <input type='text' name='s_asset_home' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_home' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_home' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_home' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_home_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_home' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_home_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>                			
                        
 <!-- retirement-->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_retirement' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_retirement' id='ck_asset_retirement' value='y' class='checkboxSubQuestionAdditional'></label> 
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
          <input type='text' name='s_asset_retirement' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_retirement' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_retirement' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_retirement' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_retirement_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_retirement' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_retirement_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>  


 <!-- investment -->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_stocks' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_stocks' id='ck_asset_stocks' value='y' class='checkboxSubQuestionAdditional'></label> 
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
          <input type='text' name='s_asset_stocks' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_stocks' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_stocks' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_stocks' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_stocks_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_stocks' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_stocks_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>       
 
  <!-- life cash -->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_life_cash' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_life_cash' id='ck_asset_life_cash' value='y' class='checkboxSubQuestionAdditional'></label> 
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
          <input type='text' name='s_asset_life_cash' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_life_cash' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_life_cash' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_life_cash' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_life_cash_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_life_cash' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_life_cash_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>      

 <!-- life face -->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_life_face' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_life_face' id='ck_asset_life_face' value='y' class='checkboxSubQuestionAdditional'></label> 
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
          <input type='text' name='s_asset_life_face' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_life_face' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_life_face' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_life_face' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_life_face_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_life_face' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_life_face_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>                     			

<!-- Revocable -->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_revocable' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_revocable' id='ck_asset_revocable' value='y' class='checkboxSubQuestionAdditional'></label> 
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
          <input type='text' name='s_asset_revocable' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_revocable' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_revocable' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_revocable' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_revocable_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_revocable' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_revocable_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div>                           
          					
<!-- irrevocable -->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_irrevocable' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_irrevocable' id='ck_asset_irrevocable' value='y' class='checkboxSubQuestionAdditional'></label> 
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
          <input type='text' name='s_asset_irrevocable' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_irrevocable' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_irrevocable' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_irrevocable' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_irrevocable_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_irrevocable' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_irrevocable_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div> 						

<!-- 0ther -->
<div class='rownothing subQuestion' >
      <div class='span2'>
        <div id='div_ck_asset_other' class='checkbox pull-right'>
          <label class='checkbox'><input type='checkbox' name='ck_other' id='ck_asset_other' value='y' class='checkboxSubQuestionAdditional'></label> 
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
          <input type='text' name='s_asset_other' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'>
          <span class='add-on'>.00</span>
        </div>
      </div>
      <div class='rownothing' id='sp_asset_other' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Spouse&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='sp_asset_other' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='s_sp_asset_other' >
        <div class='span4'  ><label for='NormalSelect' class='pull-right'>Joint&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='s_sp_asset_other_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
      <div class='rownothing' id='hh_asset_other' >
        <div class='span4' ><label for='NormalSelect' class='pull-right'><a title='' data-content='A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households.' data-placement='top' data-toggle='popover' href='#' data-original-title='Household'><strong>Household</strong></a>&nbsp;</label></div><div class='span7 input-prepend input-append'><span class='add-on'>$</span><input type='text' name='hh_asset_other_simple' value='' size='10' maxlength='10' onblur='chkDollar(this, value);'><span class='add-on'>.00</span></label>
        </div>
      </div>
</div> 
             			
                     		
</div>
";
}

?> 
