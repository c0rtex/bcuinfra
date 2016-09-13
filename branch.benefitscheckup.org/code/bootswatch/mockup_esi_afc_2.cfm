<cfinclude template="mockupplheader_3.cfm">

<!-- set table values -->





	<div class="span12">
	<!--nav bar start-->
	<div class="span3">
   	<div class="well sidebar" style="z-index: 999; position: static; top: 199px;">
	
         <legend><i class="icon-list-alt "></i> Info</legend>
        <div id="menu0">
        <ol class="nav nav-list">
            <li  id = "menu_home"><a href="http://www.benefitscheckup.org/ec/index.cfm?menu_tab=index&partner_id=11&org_id=&user_id=">How to Use</a></li>
			<li id = "menu_findh"><a href="http://www.benefitscheckup.org/ec/drugs.cfm?menu_tab=drug&partner_id=11&org_id=&user_id=&drugs=brand">Search by Drug</a></li>
        	<li  id = "menu_about"><a href="http://www.benefitscheckup.org/ec/category.cfm?menu_tab=category&partner_id=11&org_id=&user_id=&cat=PAP">Search by Category</a>		</li>
			<li  id = "menu_news"><a href="http://www.benefitscheckup.org/ec/state.cfm?menu_tab=state&partner_id=11&org_id=&user_id=&cat=ST">Search by State</a></li>
			<li  id = "menu_partners"><a href="http://www.benefitscheckup.org/ec/date.cfm?menu_tab=date&partner_id=11&org_id=&user_id=&cat=pub">Search by Date</a></li>
            
            
            <li> <form action="procGetPrg.cfm?cat=DRUG,menu_tab=drug,drugs=brand" method="post" name="formDrug">
<table cellpadding="5" align="right" bgcolor="#EAEAD2" width="">
<tr>
<td style="font-size: 8pt;"><b>Selected Medications</b><br>
<i>Click medication name to remove from list</i>
			
					<ul></ul>


					<input type="hidden" name="selectedDrugNm" value="dn_ABIL1,sym=1">
					<input type="hidden" name="shownumber" value="2">
					<input type="submit" value="View Forms"></td></tr>
				</table></form>
			</li>
		</ol>            
  </div>
 </div>
		<div style="display: none; width: 260px; height: 472px"></div>	  
</div><!--side bar end-->
    
    

<div class="span8">
<div class="well">
<legend><i class="icon-fixed-width"></i> Your Medications</legend>
	<div class="well"><h5>Find each medication you take by searching below.  Click a letter to get a list of all supported medications beginning with that letter, or enter the first few letters of a medication name in the search box and click "Find".  When you have found each medication, click its name to add it to the green "Selected Medications" box below right.  When all your medications appear in the green box, click "View Forms".</h5></div>


<div class="well">
<b>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=#">#</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=A">A</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=B">B</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=C">C</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=D">D</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=E">E</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=F">F</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=G">G</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=H">H</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=I">I</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=J">J</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=K">K</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=L">L</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=M">M</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=N">N</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=O">O</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=P">P</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=Q">Q</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=R">R</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=S">S</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=T">T</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=U">U</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=V">V</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=W">W</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=X">X</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=Y">Y</a>
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=Z">Z</a>
</b>
	<form action="https://www.benefitscheckup.org/ec/frmDrugQuestions.cfm" method="get">
		<input type="text" name="ltr" value="" size="40" />
		<input type="submit" value="Find" />
        <br /><span style="font-size: 7pt; font-weight: bold;">BRAND NAME</span>
		<input type="hidden" name="cfid" value="2514296">
        <input type="hidden" name="cftoken" value="83904977">
        <input type="hidden" name="source_id" value="1">
        <input type="hidden" name="prev_id" value="0">
        <input type="hidden" name="org_id" value="0">
        <input type="hidden" name="partner_id" value="11">
        <input type="hidden" name="subset_id" value="0">
        <input type="hidden" name="language_id" value="EN">
        <input type="hidden" name="access_id" value="0">
        <input type="hidden" name="client_id" value="NULL">
        <input type="hidden" name="test_id" value="0">
        <input type="hidden" name="menu_tab" value="drug">
        <input type="hidden" name="drugs" value="brand">
	</form>
</div>

<!--start medications list-->
<div class="well" align="left">
<ul>
 
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ABIL1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ABIL1,sym=1';">
			Abilify (aripiprazole)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_abra1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_abra1,sym=1';">
			Abraxane for Injectable Suspension (paclitaxel)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACCO1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACCO1,sym=1';">
			Accolate (zafirlukast)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACCU1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACCU1,sym=1';">
			Accupril (quinapril HCl)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACCU2,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACCU2,sym=1';">
			Accuretic (quinapril HCl/hydrochlorothiazide)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACEO1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACEO1,sym=1';">
			Aceon (perindopril erbumine)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACIP1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACIP1,sym=1';">
			Aciphex (rabeprazole sodium) Tablets
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACLO1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACLO1,sym=1';">
			Aclovate Cream (aclometasone dipropionate)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACTH1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACTH1,sym=1';">
			Acthar Gel (corticotropin)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACTI2,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACTI2,sym=1';">
			Activella (estradiol/norethindrone acetate tablets)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACTO3,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACTO3,sym=1';">
			Actoplus met (pioglitazone HCL and metformin HCL)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACTO2,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ACTO2,sym=1';">
			Actos (pioglitazone HCl)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_acul2,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_acul2,sym=1';">
			Acular LS Opththalmic Solution 0.40 (ketorolac tromethamine) 
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_acul1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_acul1,sym=1';">
			Acular Opththalmic Solution 0.45 (ketorolac tromethamine) 
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_acuv1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_acuv1,sym=1';">
			Acuvail (ketorolac)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_aczo1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_aczo1,sym=1';">
			Aczone (dapsone)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_adac1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_adac1,sym=1';">
			Adacel (tetanus, diphtheria, acellular pertussis vaccine)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ADAL1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ADAL1,sym=1';">
			Adalat CC  (nifedipine)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_adce1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_adce1,sym=1';">
			Adcetris (brentuximab vedotin)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ADVA1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ADVA1,sym=1';">
			Advair Diskus (fluticasone propionate/salmeterol)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_adva2,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_adva2,sym=1';">
			Advair HFA Inhalation Aerosol (fluticasone propionate/salmeterol)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ADVI1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ADVI1,sym=1';">
			Advicor (niacin/lovastatin SR)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_AERO2,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_AERO2,sym=1';">
			Aerochamber/Mask (delivery device for respiratory medications)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_afin1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_afin1,sym=1';">
			Afinitor (everolimus)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_AGGR1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_AGGR1,sym=1';">
			Aggrenox (aspirin/dipyridamole)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ALAM1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ALAM1,sym=1';">
			Alamast (pemirolast potassium) Ophthalmic Solution
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_alca1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_alca1,sym=1';">
			Alcaine .5% (proparacaine hydrochloride) 
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ALDA2,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ALDA2,sym=1';">
			Aldactazide (spironolactone/hydrochlorothiazide)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ALDA3,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ALDA3,sym=1';">
			Aldactone (spironolactone)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ALIM1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ALIM1,sym=1';">
			Alimta (pemetrexed)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_alin2,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_alin2,sym=1';">
			Alinia Suspension (nitazoxanide)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_alin1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_alin1,sym=1';">
			Alinia Tablets (nitazoxanide)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_alod1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_alod1,sym=1';">
			Alodox (doxycycline hyclate)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_alom1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_alom1,sym=1';">
			Alomide .1% (lodoxamide tromethamine)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ALOX1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ALOX1,sym=1';">
			Aloxi (palonosetron HCL injection)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_alph5,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_alph5,sym=1';">
			Alphagan Opththalmic Solution .15% (brimonidine tartrate) 
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ALPH2,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ALPH2,sym=1';">
			Alphagan P (brimonidine tartrate)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_alph4,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_alph4,sym=1';">
			Alphanate Injection (antihemophilic factor/von willebrand factor complex)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_alph3,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_alph3,sym=1';">
			AlphaNine SD (coagulation factor ix)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_alre1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_alre1,sym=1';">
			Alrex Suspension (loteprednol etabonate ophthalmic suspension)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_alta3,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_alta3,sym=1';">
			Altabax (retapamulin ointment)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_alta2,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_alta2,sym=1';">
			Altabax Ointment (retapamulin)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ALTA1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ALTA1,sym=1';">
			Altace (ramipril)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_AMAR1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_AMAR1,sym=1';">
			Amaryl (glimepiride)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_AMBI1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_AMBI1,sym=1';">
			Ambien (zolpidem)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_AMER1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_AMER1,sym=1';">
			Amerge (naratriptan HCl)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_amit1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_amit1,sym=1';">
			Amitiza (lubiprostone)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_amit2,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_amit2,sym=1';">
			Amitriptyline Tablet (amitriptyline)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_amtu1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_amtu1,sym=1';">
			Amturnide (aliskiren, amlodipine and hydrochlorothize)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_anal1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_anal1,sym=1';">
			Analpram (hydrocortisone/pramoxine)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ANAP1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ANAP1,sym=1';">
			Anaprox/Anaprox DS (naproxen)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ANCO1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ANCO1,sym=1';">
			Ancobon Caps (flucytosine)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ANDR1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ANDR1,sym=1';">
			AndroGel 1% (testosterone gel) 
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ange1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ange1,sym=1';">
			Angeliq (drospirenone/estradiol)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ANTI1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ANTI1,sym=1';">
			Antivert (meclizine HCl)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_apid1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_apid1,sym=1';">
			Apidra (insulin glulisine)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_apli1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_apli1,sym=1';">
			Apligraf (apligraf)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_APTI1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_APTI1,sym=1';">
			Aptivus (tipranavir)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_apti2,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_apti2,sym=1';">
			Aptivus Oral Solution (tipranavir)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_aral2,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_aral2,sym=1';">
			Aralast NP (alpha1-proteinase inhibitor, human)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ARAN1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ARAN1,sym=1';">
			Aranesp (darbepoetin alpha)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ARAV1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ARAV1,sym=1';">
			Arava (leflunomide)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_arca1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_arca1,sym=1';">
			Arcapta Neohaler (indacaterol inhalation powder)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ARIC1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ARIC1,sym=1';">
			Aricept (donepezil HCI) 
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ARIM1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ARIM1,sym=1';">
			Arimidex (anastrozole) 
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ARIX1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ARIX1,sym=1';">
			Arixtra (fondaparinux)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ARMO1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ARMO1,sym=1';">
			Armour Thyroid (thyroid desiccated)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_AROM1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_AROM1,sym=1';">
			Aromasin (exemestane)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_arra1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_arra1,sym=1';">
			Arranon (nelarabine)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ARTH1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ARTH1,sym=1';">
			Arthrotec (diclofenac sodium/misoprostol)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_arze1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_arze1,sym=1';">
			Arzerra Injection (ofatumumab)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_asma2,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_asma2,sym=1';">
			Asmanex (mometasone furoate inhalation powder)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ATAC1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ATAC1,sym=1';">
			Atacand (candesartan cilexetil)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ATAC2,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ATAC2,sym=1';">
			Atacand HCT (candesartan cilexetil/hydrochlorothiazide)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_atga1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_atga1,sym=1';">
			Atgam (lymphocyte immune globulin/anti-thymocyte globulin)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ativ1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ativ1,sym=1';">
			Ativan (lorazepam)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_atri1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_atri1,sym=1';">
			Atripla (efavirenz/emtricitabine/tenofovir)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_ATRO1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_ATRO1,sym=1';">
			Atrovent HFA Inhalation Aerosol (ipratopium bromide)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_AVAL1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_AVAL1,sym=1';">
			Avalide (irbesartan-hydrochlorothiazide)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_AVAN2,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_AVAN2,sym=1';">
			Avandamet (rosiglitazone maleate/metformin HCl)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_avan3,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_avan3,sym=1';">
			Avandaryl (rosiglitazone maleate and glimepiride)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_AVAN1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_AVAN1,sym=1';">
			Avandia (rosiglitazone maleate)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_AVAP1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_AVAP1,sym=1';">
			Avapro (irbesartan)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_AVAS1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_AVAS1,sym=1';">
			Avastin (bevacizumab)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_AVEL1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_AVEL1,sym=1';">
			Avelox (moxifloxacin HCl)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_avin1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_avin1,sym=1';">
			Avinza CII (morphine sulfate extended-release)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_AVOD1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_AVOD1,sym=1';">
			Avodart (dutasteride)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_AXER1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_AXER1,sym=1';">
			Axert (almotriptan malate)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_AYGE1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_AYGE1,sym=1';">
			Aygestin (norethindrone acetate)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_azil1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_azil1,sym=1';">
			Azilect (rasagiline)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_AZOP1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_AZOP1,sym=1';">
			Azopt (brinzolamide)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_azor1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_azor1,sym=1';">
			Azor (amlodipine and olmesartan medoxomil)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_AZUL1,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_AZUL1,sym=1';">
			Azulfidine (sulfasalazine, enteric coated)
		</a>
		
		</li>
	
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=brand&ltr=a&drg=dn_azul2,sym=1"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=brand&ltr=a&drg=dn_azul2,sym=1';">
			Azulfidine EN-Tabs (sulfasalazine, USP) 
		</a>
		
		</li>
	
</ul>

<form>
<input type="button" name="popup" value="Medication not in list?" onclick="javascript:help2('../RxNotListed.cfm')"><br><br>
</form>
</div>




</font></td></tr>	
</table>
</form>

</td></tr>
</table>


<script language="JavaScript">
<!--
function openComment() {
    url = "http://beta.benefitscheckup.org/cso/contact/form.jsp?src=bcudev";
    window.open(url, "comment", "toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=640,height=420");
}
// -->
</script>
</td>


</tr>
</table>

</div>
</div>
</div>