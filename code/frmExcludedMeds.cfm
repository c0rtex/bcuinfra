<cfparam name="src" default="">
<cf_tagHeader>
<table width=100% border="0" align="center" cellpadding="12" cellspacing="2">
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<!--Dynamic Area--><font face="arial" size="4" color="#000000">
<FONT face="Arial"><FONT SIZE=+2><B>Information on Medications Not Covered by the 
Medicare Prescription Drug Coverage</B></FONT>
<hr>
	<cfif src eq 'eforms'>
		<cf_buttons goText="Back to Application Guide" goURL="frmAccess.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelseif src eq 'elig'>
		<cf_buttons goText="Back to Results" goURL="frmeligibility.cfm?sr=#sr#&cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelseif src eq 'ec'>
		<cf_buttons goText="Back to Application Forms Center" goURL="javascript:history.go(-1)">
		<br>
	<cfelseif src neq 'frame'>
		<cf_buttons goText="Back to Recommendations" goURL="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	</cfif>

<p>
Most types of prescription drugs are covered by the new Medicare Prescription Drug Coverage.  However, the Medicare drug coverage will not include certain medications that fall into specific categories.  In order to help you find out if the medication(s) you are taking will not be included in the Medicare drug coverage, we have created a list of situations (&quot;I am taking...&quot;).  If you are taking a medication for one or more of the situations listed below, you can click on a link to see the medications that will not be covered by category. 
</p>
<strong>I am taking a medication for: </strong>
<uL><li><strong>anxiety or nervousness;</strong></li>
<li><strong>panic attacks;   </strong></li>
<li><strong>seizures or epilepsy; </strong></li>
<li><strong>trouble falling asleep; OR</strong></li>
<li><strong>muscle spasms.</strong></li>
</ul>

<p>The Medicare drug coverage will not cover Barbiturates and Benzodiazepines medications which are generally prescribed for these types of conditions.  Click <a href="#Barb">here</a> to see the list of medications that are not covered for these conditions.</p>


<strong>I am taking a medication to help me:</strong>
<ul><li><strong>gain weight; OR</strong></li>
<li><strong>loose weight. </strong> </li>
</ul>

Click <a href="#Weight">here</a> to see the list of medications for weight gain or weight loss that are not covered.</p>

<p><b>I am taking a vitamin that is prescribed by my doctor.</b>
Click <a href="#Vitamin">here</a> to see the list of vitamins that are not covered.</p>
<p>
<strong>I am taking a prescription medication on a regular basis for a cough, cold, or nasal stuffiness/congestion.</strong> Click <a href="#cough">here</a> to see the list of medications that are not covered for Cough and Colds.</p>
<p>
<strong>I am taking a prescription drug that is not covered by the Medicare Prescription Drug Coverage.  What are my options to get help paying for my medications that are not covered?</strong> Click <a href="#Other">here</a> to view Other Programs to Consider and Generic Medications.</p>
<div align="center">
  <table cellspacing="0" cellpadding="0" border="1">
    <tr>
      <td width="443" colspan="2" valign="bottom"><p align="center"><strong><a name="Barb"></a>Barbiturates and Benzodiazepines </strong></p></td>
    </tr>
    <tr>
      <td width="443" colspan="2" valign="bottom"><p align="center"><strong>Brand Name and Generic Medication List </strong></p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Alprazolam</p></td>
      <td width="205" valign="bottom"><p>lorazepam</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Alurate</p></td>
      <td width="205" valign="bottom"><p>Luminal</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Amobarbital</p></td>
      <td width="205" valign="bottom"><p>Mebaral</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>amobarbital and secobarbital</p></td>
      <td width="205" valign="bottom"><p>mephobarbital</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Amytal</p></td>
      <td width="205" valign="bottom"><p>midazolam</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Aprobarbital</p></td>
      <td width="205" valign="bottom"><p>Nembutal</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Ativan</p></td>
      <td width="205" valign="bottom"><p>oxazepam</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Butibarbital</p></td>
      <td width="205" valign="bottom"><p>Paxipam</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Butisol Sodium</p></td>
      <td width="205" valign="bottom"><p>pentobarbital</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Centrax</p></td>
      <td width="205" valign="bottom"><p>phenobarbital</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Chlordiazepoxide</p></td>
      <td width="205" valign="bottom"><p>phenobarbital</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>chlordiazepoxide and amitriptyline</p></td>
      <td width="205" valign="bottom"><p>prazepam</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Clonazepam</p></td>
      <td width="205" valign="bottom"><p>ProSom</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Clorazepate</p></td>
      <td width="205" valign="bottom"><p>quazepam</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Dalmane</p></td>
      <td width="205" valign="bottom"><p>Restoril</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Diastat</p></td>
      <td width="205" valign="bottom"><p>secobarbital</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Diazepam</p></td>
      <td width="205" valign="bottom"><p>Seconal</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Diazepam</p></td>
      <td width="205" valign="bottom"><p>Serax</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Doral</p></td>
      <td width="205" valign="bottom"><p>Solfoton</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Estazolam</p></td>
      <td width="205" valign="bottom"><p>temazepam</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Flurazepam</p></td>
      <td width="205" valign="bottom"><p>Tranxene</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Halazepam</p></td>
      <td width="205" valign="bottom"><p>triazolam</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Halcion</p></td>
      <td width="205" valign="bottom"><p>Tuinal</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Klonopin</p></td>
      <td width="205" valign="bottom"><p>Valium</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Librium</p></td>
      <td width="205" valign="bottom"><p>Versed</p></td>
    </tr>
    <tr>
      <td width="238" valign="bottom"><p>Limbitrol</p></td>
      <td width="205" valign="bottom"><p>Xanax</p></td>
    </tr>
  </table>
<strong>&nbsp;</strong></div>
<div align="center">
  <table cellspacing="0" cellpadding="0" border="1">
    <tr>
      <td width="444" valign="bottom"><p align="center"><strong><a name="cough"></a>Prescription Cough and Cold Medications </strong></p></td>
    </tr>
    <tr>
      <td width="444" valign="bottom"><p align="center"><strong>Brand Name and Generic Medication List </strong></p></td>
    </tr>
    <tr>
      <td width="444" valign="bottom"><p>* All prescription cough and cold medications are not covered.</p></td>
    </tr>
  </table>
<strong>&nbsp;</strong></div>
<div align="center">
  <table cellspacing="0" cellpadding="0" border="1">
    <tr>
      <td width="501" colspan="2" valign="bottom"><p align="center"><strong><a name="Vitamin"></a>Prescription Vitamin &amp; Mineral Products </strong></p></td>
    </tr>
    <tr>
      <td width="501" colspan="2" valign="bottom"><p align="center"><strong>Brand Name and Generic Medication List </strong></p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Berocca Plus Tablets</p></td>
      <td width="269" valign="bottom"><p>Niferex-150 Forte</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Berocca Tablets</p></td>
      <td width="269" valign="bottom"><p>PABA</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Calcijex</p></td>
      <td width="269" valign="bottom"><p>paricalcitrol</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>calcium acetate</p></td>
      <td width="269" valign="bottom"><p>PhosLo</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>calcium acetate</p></td>
      <td width="269" valign="bottom"><p>phosporus</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Calderol</p></td>
      <td width="269" valign="bottom"><p>Potaba</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Calphron</p></td>
      <td width="269" valign="bottom"><p>Renax</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Cardiotek Rx Tablets</p></td>
      <td width="269" valign="bottom"><p>Rocatrol</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Cefol Filmtab</p></td>
      <td width="269" valign="bottom"><p>Senilezol Liquid</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Cyanoject</p></td>
      <td width="269" valign="bottom"><p>Strovite Forte </p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Diatx</p></td>
      <td width="269" valign="bottom"><p>Strovite Plus Caplets</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Drisdol</p></td>
      <td width="269" valign="bottom"><p>Theragran Hematinic</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Eldercaps Capsules</p></td>
      <td width="269" valign="bottom"><p>Trinsicon capsules</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Folgard</p></td>
      <td width="269" valign="bottom"><p>Vicon Forte Capsules</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>folic acid</p></td>
      <td width="269" valign="bottom"><p>vit B12/cyanocobalamin</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Folic Acid 1mg</p></td>
      <td width="269" valign="bottom"><p>vitamin B comb., vitamin C, and iron</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>FOLTX</p></td>
      <td width="269" valign="bottom"><p>vitamin B combinations</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>K-Phos Neutral</p></td>
      <td width="269" valign="bottom"><p>vitamin B combinations</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Megatron Elixer</p></td>
      <td width="269" valign="bottom"><p>vitamin B combinations</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Mephyton</p></td>
      <td width="269" valign="bottom"><p>vitamin B combinations</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>multivitamin with iron</p></td>
      <td width="269" valign="bottom"><p>vitamin B combinations</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>multivitamin with iron</p></td>
      <td width="269" valign="bottom"><p>vitamin B combinations and vitamin c</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>multivitamin with minerals</p></td>
      <td width="269" valign="bottom"><p>vitamin B combinations and vitamin c</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>multivitamin with minerals</p></td>
      <td width="269" valign="bottom"><p>vitamin B combinations and vitamin c</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>multivitamin with minerals</p></td>
      <td width="269" valign="bottom"><p>vitamin B combinations and vitamin c</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>multivitamin with minerals</p></td>
      <td width="269" valign="bottom"><p>vitamin B combinations and vitamin c</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>multivitamin with minerals</p></td>
      <td width="269" valign="bottom"><p>vitamin B12</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>multivitamin with minerals</p></td>
      <td width="269" valign="bottom"><p>vitamin B12, iron, and intrinsic factor</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>multivitamin, minerals, and iron</p></td>
      <td width="269" valign="bottom"><p>vitamin D/calcitriol</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Nascobal</p></td>
      <td width="269" valign="bottom"><p>vitamin D/calcitriol</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Nephplex Rx Tablets</p></td>
      <td width="269" valign="bottom"><p>vitamin D/calcitriol</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Nephrocaps Capsules</p></td>
      <td width="269" valign="bottom"><p>vitamin D/ergocalciferol</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Nephron FA</p></td>
      <td width="269" valign="bottom"><p>vitamin K/phytonadione</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>Niacin/Nicotinic Acid 500mg</p></td>
      <td width="269" valign="bottom"><p>Zemplar</p></td>
    </tr>
    <tr>
      <td width="231" valign="bottom"><p>niacin/nicotinic Acid 500mg</p></td>
      <td width="269" valign="bottom"><p>Zincvit Capsules</p></td>
    </tr>
  </table>
</div>
<p align="center"><strong> &nbsp;</strong></p>
<div align="center">
  <table cellspacing="0" cellpadding="0" border="1">
    <tr>
      <td width="497" colspan="2" valign="bottom"><p align="center"><strong><a name="Weight"></a>Weight Loss and Weight Gain Medications </strong></p></td>
    </tr>
    <tr>
      <td width="497" colspan="2" valign="bottom"><p align="center"><strong>Brand Name and Generic Medication List </strong></p></td>
    </tr>
    <tr>
      <td width="241" valign="bottom"><p>Adipex-P</p></td>
      <td width="256" valign="bottom"><p>Oxandrin</p></td>
    </tr>
    <tr>
      <td width="241" valign="bottom"><p>benzphetamine</p></td>
      <td width="256" valign="bottom"><p>oxandrolone</p></td>
    </tr>
    <tr>
      <td width="241" valign="bottom"><p>Bontril</p></td>
      <td width="256" valign="bottom"><p> phendimetrazine </p></td>
    </tr>
    <tr>
      <td width="241" valign="bottom"><p>Didrex</p></td>
      <td width="256" valign="bottom"><p> phendimetrazine </p></td>
    </tr>
    <tr>
      <td width="241" valign="bottom"><p>diethylpropion</p></td>
      <td width="256" valign="bottom"><p>phentermine</p></td>
    </tr>
    <tr>
      <td width="241" valign="bottom"><p>diethylpropion</p></td>
      <td width="256" valign="bottom"><p>phentermine</p></td>
    </tr>
    <tr>
      <td width="241" valign="bottom"><p>dronabinol</p></td>
      <td width="256" valign="bottom"><p>phentermine</p></td>
    </tr>
    <tr>
      <td width="241" valign="bottom"><p>Ionamin</p></td>
      <td width="256" valign="bottom"><p>Prelu-2</p></td>
    </tr>
    <tr>
      <td width="241" valign="bottom"><p>Marinol</p></td>
      <td width="256" valign="bottom"><p>ProFast</p></td>
    </tr>
    <tr>
      <td width="241" valign="bottom"><p>Megace</p></td>
      <td width="256" valign="bottom"><p>sibutramine</p></td>
    </tr>
    <tr>
      <td width="241" valign="bottom"><p>megestrol</p></td>
      <td width="256" valign="bottom"><p>Tenuate</p></td>
    </tr>
    <tr>
      <td width="241" valign="bottom"><p>Meridia</p></td>
      <td width="256" valign="bottom"><p>Tenuate dospan</p></td>
    </tr>
    <tr>
      <td width="241" valign="bottom"><p>orlistat</p></td>
      <td width="256" valign="bottom"><p>Xenical</p></td>
    </tr>
  </table>
</div>
<p align="center">&nbsp;</p>
<b><a name="Other"></a>Other Programs to Consider</b> 
If you find that you are taking a prescription medication that is not covered by Medicare Prescription Drug Coverage, you may be able to get help from one or more of the following programs:
<uL>
<li><b>State Pharmacy Assistance Programs</b> - Many states offer programs that will "wrap around" the new Medicare benefit to fill gaps in drug coverage.  One of these gaps is medications excluded from coverage under Medicare.  The prescription benefits and eligibility requirements vary widely among these state programs.  
<li><b>Pharmaceutical company patient assistance programs </b> - You may be eligible for assistance offered by pharmaceutical companies. These programs provide certain medications at a very low cost based on a person's income and needs. 
<li><b>Pharmaceutical company discount cards</b> - Many pharmaceutical companies have programs or prescription cards that will allow people that meet certain eligibility requirements to get medications at a discounted price.  
<li><b>The Department of Veterans Affairs</b> - If you are a veteran, you may qualify for prescription drug benefits through the Department of Veterans Affairs (VA).  For more information about prescription drug and other health benefits available to veterans, log on to <a href="http://www1.va.gov/health_benefits/" title="Link to Department of Veterans Affairs" target="_blank">www1.va.gov/health_benefits/</a>. 
<li><b>TRICARE</b> - If you are retired from the military or are the spouse or widow of a retired military service member, you may qualify for health benefits, including prescription drug benefits, from TRICARE.  For more information about TRICARE, log on to <a href="http://www.tricare.osd.mil/" title="Link to Tricare" target="_blank">www.tricare.osd.mil/</a>.
</ul>
<p><b>Generic Medications Can Save You Money</b><br>
Many of the medications that are not covered by Medicare are available as generic medications.  A generic medication works like the brand-name medication in dosage, strength, performance and use, and must meet the same quality and safety standards. All generic medications are reviewed and approved by the U.S. Food and Drug Administration. In addition, generic medications generally cost less than a brand-name medication, which can save you money.  Check with your pharmacist to find out if a generic medication is available for one or more of your brand-name medications.</p>

	<cfif src eq 'eforms'>
		<cf_buttons goText="Back to Application Guide" goURL="frmAccess.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelseif src eq 'elig'>
		<cf_buttons goText="Back to Results" goURL="frmeligibility.cfm?sr=#sr#&cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelseif src eq 'ec'>
		<cf_buttons goText="Back to Application Forms Center" goURL="javascript:history.go(-1)">
		<br>
	<cfelseif src neq 'frame'>
		<cf_buttons goText="Back to Recommendations" goURL="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	</cfif>
</td></tr></Table>
</td></tr></Table>
<cf_tagfooter>