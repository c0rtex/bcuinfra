<cfquery dataSource="#application.dbSrc#">
<!--- BUG 6810 rxgov_fd_medicare_lis--->
UPDATE display_language
SET display_text = '<b>How can this program help me?</b><br>
Medicare has a program that helps pay for your prescription medicine. 
It’s called Medicare Prescription Drug Coverage or Medicare Part D. This 
program pays for some, but not all, of your prescription drug costs.  If 
you have Medicare Part D and have limited income and resources, you may 
be able to get “Extra Help” from this program. This means that you can 
get more help paying for your medicine. Extra Help gives you three 
levels of help. How much assistance you get depends on your income and 
resources.<br><br>

<b>Can I apply?</b><br>

First, you need to get Medicare Part D. Once you enroll in Medicare Part 
D, you may be able to get the Extra Help program based on your income 
and resources.  You must meet one of the three levels in 2012:

<ul><li><b>Level 1:</b>  If you are single, your income must be less 
than $10,890 and resources must be less than $8,440.  If you are 
married, your income must be less than $14,710 and your resources must 
be less than $13,410.</ul></li>

<ul><li><b>Level 2:</b>  If you are single, your income must be less 
than $14,701.50 and resources must be less than $8,440.  If you are 
married, your income must be less than $19,858.50 and your resources 
must be less than $13,410.</ul></li>

<ul><li><b>Level 3:</b>  If you are single, your income must be less 
than $16,335 and resources must be less than $13,070.  If you are 
married, your income must be less than $22,065 and your resources must 
be less than $26,120.</ul></li>

<b>NOTE:</b>  If you work, support family members who live with you, or 
live in Alaska and Hawaii, the income limits may be higher.  The 
resource amounts include savings you can use toward burial costs ($1,500 
for singles and $3,000 for couples). <br><br> 

<b>How much will I pay?</b><br>
Depending on the income and resource level you fall under, the costs for 
the program may be different.  The following is a list of the costs you 
will have to pay if you enroll in Extra Help for prescription drugs 
covered by your plan: <br><br>

<b>Level 1:</b>
<ul><li>No monthly premium and no deductible
</li>
<li>$1.10 copay for generic drugs</li>
<li>$3.30 copay for brand-name drugs</li> 
<li>No copays after your total drug costs are more than 
$6,657.50</ul></li>

<b> Level 2:</b> 
<ul><li>No monthly premium and no deductible
</li>
<li>$2.60 copay for generic drugs</li>
<li>$6.50 copay for brand-name drugs</li>  
<li>No copays after your total drug costs are more than 
$6,657.50</ul></li>  
<b>Level 3:</b> 
<ul><li>A monthly premium based on your income</li>
<li>$65 deductible</li>
<li>15% of the cost of drugs</li>
<li>$2.60 copay for generic drugs and $6.50 copay for brand-name drugs, 
if your total drug costs are more than $6,657.50</ul></li>


<b>How do I apply for Extra Help and join a Medicare Prescription Drug 
Plan?</b><br>

If you meet the guidelines for the Extra Help program, you can <a href=" 
http://www.mymedicarematters.org/PrescriptionDrugs/ExtraHelp/do_i_qualify.php"target="_blank"> 
enroll in the program at any time.</a><br><br>

If you have Medicare and also get Medicaid, Supplemental Security Income 
(SSI), or a Medicare Savings Program, you do not need to apply for the 
Extra Help program – you have already been enrolled.<br><br>

<b>Here are ways you can apply for the Extra Help:</b><br>

<ul><li> <a href="http://www.benefitscheckup.org/cf/redirectssa.cfm" 
target="_blank"> Apply online now</a> OR go to <a 
href="https://secure.ssa.gov/i1020/start" target="_blank"> 
https://secure.ssa.gov/i1020/start</a> to apply through Social Security 
Administration (SSA).
</b></ul></li>
<ul><li>Call SSA at (800) 772-1213 or (800) 325-0778 (TTY) to order a 
paper application or to complete an application over the phone.  SSA can 
also help you complete your application. </ul></li>


<b>If you apply and get the Extra Help program, you must join a Medicare 
drug plan and you have two options:</b>
<ol><li><b>Medicare Prescription Drug Plans:</b> These plans add drug 
coverage to Original Medicare and some other Medicare health plans.    
These plans are sometimes called "PDPs."  For example, if you have 
Original Medicare with or without a Medicare Supplement (called 
Medigap), you will need to add a Medicare Part D plan to get help paying 
for your prescription medicine. </li></ol>
<ol start="2"><li><b>Medicare Advantage Plans (like an HMO or PPO) or 
other Medicare health plans that offer Medicare prescription drug 
coverage:</b> You can join a Medicare health care plan that includes 
coverage for Medicare Part A, Part B, and Part D. They are sometimes 
called "MA-PDs". In addition, they cover many of your health care costs 
such as: doctor visits, surgery, and prescription drugs.</li></ol>



<b>For more information about Medicare Prescription Drug Coverage and 
the Extra Help:</b>
<ul><li>To compare or enroll in a Medicare Prescription Drug Plan, go to 
the [[track|planfind|Medicare Plan Finder]]. </ul></li>
<ul><li>To learn more about Medicare Prescription Drug Coverage, Extra 
Help, and other Medicare benefits, visit <a 
href="http://www.mymedicarematters.org" target="_blank"> 
MyMedicareMatters</a>. </ul></li>'
WHERE display_id = 5816
AND language_id = 'EN';
</cfquery>

<cfquery dataSource="#application.dbSrc#">
<!--- BUG 6810 rxgov_fd_lis_mapping_long --->
UPDATE display_language
SET display_text = '<b>Medicare Part D Low-Income Subsidy (Extra Help) 
benefits and costs</b> - The Medicare Part D Low-Income Subsidy (usually 
called Extra Help or LIS) helps Medicare Part D beneficiaries with the 
costs of their Part D plan premiums, deductible, and copayments, and 
provides coverage during the “coverage gap” or donut hole. There are 
different levels of subsidy available, depending on a person’s income 
and assets.<br><br> 

In 2012:<br><br>

People who are single and who have annual  incomes lower than $10,890** 
and resources lower than $8,180*** or married couples with annual 
incomes lower than $14,710** and resources lower than $13,020*** will 
pay:
<ul><li>No monthly premium, no deductible
<li>$1.10 co-payment for generic  drugs and $3.30 co-payment for 
brand-name drugs that the plan covers
<li>No co-payments after their total drug costs (paid by Extra Help and 
by their out-of-pocket expenditures on drugs covered by their plan  and 
purchased at a pharmacy the plan recognizes) have exceeded $6,657.50 
during 2012</ul></li>

People who are single and who have annual incomes lower than 
$14,701.50** and resources lower than $8,180*** or married couples with 
annual incomes lower than $19,858.50** and resources lower than 
$13,020*** will pay:
<ul><li>No monthly premium, no deductible
<li>$2.60 co-payment for generic drugs and $6.50 co-payment for 
brand-name drugs that the plan covers
<li>No co-payments after total drug costs (paid by Extra Help and the 
plan for drugs the plan covers at drug stores in the plan’s network) 
have exceeded $6,657.50</ul></li>

People who are single and who have annual incomes lower than $16,335** 
and resources (savings) lower than $13,070*** or married couples with 
incomes lower than $22,065 ** and resources lower than $26,120*** will 
pay:

<ul><li>A monthly premium based on their income
<li>A $65 deductible
<li>15% of the cost of drugs that the plan covers
<li>Co-payments of $2.60 for generic drugs and $6.50 for brand-name 
drugs after their total drug costs (paid by Extra Help and the plan for 
drugs the plan covers at drug stores in the plan’s network) have 
exceeded $6,657.50</ul></li>

** These income limits are higher if individuals live in Alaska and 
Hawaii, work, or support family members who live with them.<br>
*** Resource limits include a $1,500 burial allowance (for singles) and 
a $3,000 burial allowance (for couples).<br><br>

Applying for LIS - People with Medicare who also get Medicaid, 
Supplemental Security Income (SSI), and/or one of the Medicare Savings 
Programs (QMB, SLMB or QI), do not need to apply for LIS – they are 
automatically enrolled. <br><br> 

However, people who are not automatically enrolled must apply for LIS.  
They can do so:<br>

<blockquote>On the web, by going to:<br> 
<a href="http://www.benefitscheckup.org/lisapp/" target="_blank"> 
http://www.BenefitsCheckUp.org/lisapp </a>or
<a href="https://secure.ssa.gov/i1020/start" target="_blank"> 
https://secure.ssa.gov/i1020/start</a></blockquote>
<blockquote>By phone, by calling the Social Security Administration 
at:<br> 1-800-772-1213. TTY users should call 1-800-325-0778.<br>
(Applicants have the option to order a paper application or to complete 
an application over the phone.)</blockquote>

For help applying for LIS, contact your State Health Insurance 
Assistance Program. This program offers one-on-one, objective counseling 
and assistance to people with Medicare and their families. A directory 
of the programs by state appears at:  <a 
href="https://www.shiptalk.org/About/SHIProfileSearchForm.aspx?mf=Display 
" target="_blank"> 
https://www.shiptalk.org/About/SHIProfileSearchForm.aspx?mf=Display 
</a><br><br>  

To learn more about the Extra Help/Low-Income Subsidy and other 
Medicare-related benefits, visit:<br> 
<a 
href="http://www.mymedicarematters.org/PrescriptionDrugs/ExtraHelp/extra_help_paying.php" 
target="_blank"> 
http://www.mymedicarematters.org/PrescriptionDrugs/ExtraHelp/extra_help_paying.php 
</a><br><br>

<b>People applying for LIS should have the following materials 
available:</b><br>

Documents Showing Medicare Eligibility<br>
Proof of Income and Resources'
WHERE display_id = 83254
AND language_id = 'EN';
</cfquery>

<cfquery dataSource="#application.dbSrc#">
<!--- BUG 6810 entry point id= 53034--->
Update entrypoint
set address2 = '<b>To join a Medicare Prescription Drug Plan, 
contact:</b><br>Medicare<br>Phone: 1-800-MEDICARE (1-800-633-4227), TTY 
users should call 1-877-486-2048<br><a 
href="https://www.medicare.gov/find-a-plan" target="_blank"> 
Website</a>'
where entrypoint_id = 53034
</cfquery>


<cfquery dataSource="#application.dbSrc#">
<!--- BUG 6810 taxrelief_ks_safe_senior --->
UPDATE display_language
SET display_text = '<b>How can this program help me?</b><br>
This program provides you a property tax refund on up to 45% of the 
property tax that you paid. <br><br>
<b>Can I apply? </b><br>
You can take part in this program if you are 65 years of age or older 
and have limited income.  You must live in the home and pay property 
tax.<br><br><b>Please Note</b>:  You cannot take part in this program if 
you owe property taxes or your home is in foreclosure.<br><br>
<b>How do I apply?</b><br>
To apply for this program, you can print and fill out the application 
form and mail it to your local office.<br><br> 
<b>Note:</b>
Before you submit a completed Kansas Safe Senior application form you 
should also review the Kansas Homestead exemption program.  Both 
programs provide a refund on the property tax you paid.  You can apply 
for the program that provides the highest refund amount, but you cannot 
apply for both programs. Please review the <A 
HREF="http://www.ksrevenue.org/pdf/SafeSeniorHSchart.xls">Kansas 
Department of Revenue guide</A> to see what program is best for you.'
WHERE display_id = 80800
AND language_id = 'EN';
</cfquery>

<cfquery dataSource="#application.dbSrc#">
<!--- BUG 6810 taxrelief_ks_safe_senior --->
UPDATE program
SET url = 'http://www.ksrevenue.org/safesenior.html'
WHERE program_id = 1790
</cfquery>
<p>All updates applied.</p>
