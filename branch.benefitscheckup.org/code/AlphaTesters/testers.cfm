<cfset localSrc="BCU_NonApp">
<cfset mailTable="tbl_CSOAlphaTestersPhase2">
<cfset testerArray=ArrayNew(2)>
<cfset testerList="Jim,Firman,AlphaT001,123456,james.firman@ncoa.org,Frank,Slobig,AlphaT002,123456,frank.slobig@ncoa.org,Dan,Evans,AlphaT003,123456,daniel.evans@ncoa.org,Donna,Phillips,AlphaT004,123456,donna.phillips@ncoa.org,Renae,Polk,AlphaT005,123456,renae.polk@ncoa.org,Deb,Briceland,AlphaT006,123456,deb.briceland@ncoa.org,Alixe,McNeill,AlphaT007,123456,alixe.mcneill@ncoa.org,Gene,Royster,AlphaT008,123456,drroyster@ameritech.net,Marlene,Schneider,AlphaT009,123456,mss@beneiftscheckup.org,Chuck,Mondin,AlphaT010,123456,chuck.mondin@ncoa.org,Jim,DeRado,AlphaT011,123456,jim.derado@ncoa.org,Scott,Parkin,AlphaT012,123456,scott.parkin@ncoa.org,Marcia,Naas,AlphaT013,123456,mnaas@cityofchicago.org,Jonathan,Lavin,AlphaT014,123456,jlavin@s3a.com,Monique,James,AlphaT015,123456,mjames@s3a.com,Lynn,Wieland,AlphaT016,123456,wielal@odjfs.state.oh.us,Jeff,Rubin,AlphaT018,123456,jeff@benefitscheckup.org,Ken,Cameron,AlphaT019,123456,camerkj@dshs.wa.gov,Jim,Fultz,AlphaT020,123456,jFultz@age.state.oh.us,Eric,Vande Berg,AlphaT021,123456,e.vande.berg@computer.org,Reba,Schafer,AlphaT022,123456,rs55003@alltel.net,Linda,Collins,AlphaT023,123456,LCollins@lifelongmedical.org,Ann,Gray,AlphaT024,123456,averonicagray@yahoo.com,Daphene,Johnson,AlphaT025,123456,johnson.daphene@hcds.com,Tami,Dinsmore,AlphaT026,123456,tdinsmore@rmcl.org,Holly,Gartmayer,AlphaT027,123456,hgartmayer@rmcl.org,David,Stern,AlphaT028,123456,dstern@jasa.org,Sue,Chandler,AlphaT029,123456,searchandcare@mindspring.com,Beverly,Jackson,AlphaT030,123456,NYIsaac1@aol.com,Brian,DeShong,AlphaT031,123456,brian@deshong.net,Stephen,Engles,AlphaT032,123456,sgengels@yahoo.com,Carol,Zernial,AlphaT033,123456,czernial@aacog.com,Deb,Cutler,AlphaT035,123456,dcutler@cssny.org,Vineel,Shah,AlphaT038,123456,vineel@vineel.com,Howard,Bedlin,AlphaT039,123456,howard.bedlin@ncoa.org,Sean,Shacklett,AlphaT040,123456,SHACKS@ODJFS.STATE.OH.US,Jack,York,AlphaT042,123456,jyork@IN2L.com,Marjean,Drost,AlphaT043,123456,MDnRockies@aol.com,Ramsey,Alwin,AlphaT044,123456,ralwin@sso.org,Rey,Muradaz,AlphaT045,123456,rey@muradaz.com,Neal,Cutler,AlphaT046,123456,ncutler@ssw.upenn.edu,Lisa,Gables,AlphaT048,123456,lisa.gables@ncoa.org,Matt,King,AlphaT049,123456,m_king@mail.com,Matt,Proctor,AlphaT050,123456,proc113@yahoo.com,Matt,Malone,AlphaT051,123456,malone@enteract.com,Matt,Caron,AlphaT052,123456,mcaron@shiva.hunter.cuny.edu,Nancy,Whitelaw,AlphaT056,123456,nwhitela@hfhs.org,Marie,Squillace,AlphaT057,123456,marie.squillace@ncoa.org,Sue,Schilling,AlphaT058,123456,schilling@searchandcare.org,Sue,Siroto,AlphaT059,123456,Siroto@searchandcare.org,Sue,Sternberg,AlphaT060,123456,sternberg@searchandcare.org,Sue,Wilson,AlphaT061,123456,wilson@searchandcre.org,David ,Dring,AlphaT062,123456,dave@dring.org,Jay,Greenberg,AlphaT063,123456,LTCJAY@aol.com,Rosemary,Williams,AlphaT064,123456,RTWAG@co.boulder.co.us,James,Vaugh,FCDOA45,123456,VaughnJ99@aol.com,Jay,Analovitch,Margrave001,123456,janalovitch@lifesourceservices.com,Bill,Aragon,Margrave002,123456,bill.aragon@state.co.us,George,Beard,Margrave003,123456,Birdiebeard@aol.com,Deanna,Beaudoin,Margrave004,123456,Deanna_E._Beaudoin@hud.gov,Stephen ,Bender,Margrave005,123456,Stephen.Bender@med.va.gov,Sue,Bozinovski,Margrave006,123456,sbozinovski.drcog@usa.net,Mary Ann,Bradley,Margrave007,123456,samb@cityoflafayette,Alicia ,Cuaron,Margrave008,123456,cenbsj@IN2L.com,Annette,Choszczyk,Margrave009,123456,achoszczyk@ald.lib.co.us,Pat,Critchfield,Margrave010,123456,pachg@co.boulder.co.us,Ramon,DelCastillo,Margrave011,123456,rdelcast@regis.edu,Steve,DelCastillo,Margrave012,123456,chope@aol.com,Jean,Dent,Margrave013,123456,jdent@srcaging.org,Alex,Denerstein,Margrave014,123456,adenerstein@srcaging.org,Therese,Ellery,Margrave015,123456,tellery@rcfdenver.org,Noreen,Ellison,Margrave016,123456,NoreenEllisonSC@Centura.Org,Diane,Evans,Margrave018,123456,EvansD@ci.boulder.co.us,Karl,Ferguson,Margrave019,123456,parrockies@aol.com,Baldimar,Garza,Margrave020,123456,bgarza@IN2l.com,Kenneth,Gloss,Margrave021,123456,kgloss@co.arapahoe.co.us,Amanda,Graham-West,Margrave022,123456,agraham@douglas.CO.US,Maureen,Hanrahan,Margrave023,123456,maureen.b.hanrahan@kp.org,Amy,Hayes,Margrave024,123456,ahayes@homecaremanagement.com,Regina,Jackson,Margrave025,123456,jackson_regina@hotmail.com,Frances,Jefferson,Margrave026,123456,jefferson-frances@dol.gov,Grant,Jones,Margrave027,123456,grant@denverblackchurch.org,Bonnie,Kelly,Margrave028,123456,bkelly@drcog.org,Lourae,King,Margrave029,123456,cogking@adelphia.net,Ann,Ludvigsen,Margrave030,123456,Aludvigsen@SRCaging.org,Emmanuel,Manos,Margrave031,123456,emmanuel.manos@dhs.co.denver.co.us,James ""Chico"",Martinez,Margrave032,123456,martinezfam1@mindspring.com,Margaret,Martinez,Margrave033,123456,margaret.martinez@dhs.co.denver.co.us,Randy,Martinez,Margrave034,123456,randy.martinez@dhs.co.denver.co.us,Dail,Neugarten,Margrave035,123456,dneugart@carbon.cudenver.edu,Palmer,Pekarek,Margrave036,123456,PalmerJ1@aol.com,Doris,Puga,Margrave037,123456,doris.pugad@dhs.co.denver.co.us,Dolores,Quinlisk,Margrave038,123456,dquinlisk@pcisys.net,John,Riggle,Margrave039,123456,RiggleJci.boulder.co.us,Gino,Rinaldi,Margrave040,123456,GinoRinaldi@cs.com,Margaret,Roberts,Margrave041,123456,margaretroberts@qwest.net,Valerie,Robson,Margrave042,123456,vrobson@douglas.co.us,Beth,Sidebotham,Margrave043,123456,bsidebotham@SRC.org,Art,Smith,Margrave044,123456,art@in2l.com,Ryan,Smith,Margrave045,123456,rsmith@drcog.org,John,Treinen,Margrave046,123456,john.treinen@state.co.us,Michele,Waite,Margrave048,123456,Michele_Waite@ci.longmont.co.us,Barbara,Warren,Margrave049,123456,Barbara.Warren@dhha.org,Keith ,Williams,Margrave050,123456,williak@ci.louisville.co.us,Rosemary,Williams,Margrave051,123456,rtwag@co.boulder.co.us,John,Zabowa,Margrave053,123456,zabawasrc@aol.com,Bonnie,Kelly,Margrave054,123456,bkelly@drcog.org,Peter,Wycok,Margrave173,123456,ptwyckoff1@yahoo.com,sally,bartsch,Margrave174,123456,sally.bartsch@phoenix.gov,Melinda,Ludwiczak,Margrave175,123456,Melinda.Ludwiczak@ci.minneapolis.mn.us,Karen,Tucker,Margrave176,123456,karenkipcenter@hotmail.com,Lisa,Stewart,Margrave180,123456,lisastewart@mindspring.com,Frank,Johnson,Margrave181,123456,frank.johnson@baltimorecity.gov,Thelma,Winn,Margrave182,123456,thelma.winn@baltimorecity.gov,Lisa,Veale,Margrave183,123456,lisa.verale@baltimorecity.gov,Margaret,Hougart,Margrave184,123456,margaret.hougart@baltimorecity.gov,Neetu,Dhawan-Gray,Margrave185,123456,neetu.dhawn-gray@baltimorecity.gov,Dakota,Burgress,Margrave186,123456,DB@mail.ooa.state.md.us,Stepheanie,Garriety,Margrave187,123456,sag@mail.ooa.state.md.us,James,Macgill,Margrave188,123456,jmj@mail.ooa.state.md.us,Sandra,Wagner,Margrave200,123456,scdenverco@aol.com,Bill,Shunn,Margrave171,123456,bill@benefitscheckup.org">

<cfset testerCount=1>
<cfset testerElement=1>
<cfloop index="i" list="#testerList#">
	<cfset testerArray[testerCount][testerElement]="#i#">
	<cfset testerElement=testerElement + 1>
	<cfif testerElement gt 5>
		<cfset testerCount=testerCount + 1>
		<cfset testerElement=1>
	</cfif>
</cfloop>

<cfset testerCount=1>
<cfloop condition="#testerCount# lte #ArrayLen(testerArray)#">
	<cfset testerElement=1>
	<cfoutput>#testerCount#</cfoutput>
	<cfloop condition="#testerElement# lte 5">
		<cfoutput>-- #testerArray[testerCount][testerElement]#</cfoutput>
		<cfset testerElement=testerElement + 1>
	</cfloop>
	<cfquery name="update" datasource="#localSrc#">
		update #mailTable#
		set Login_ID='#testerArray[testerCount][3]#'
		where Usr_NCOA_ID=#testerCount#
	</cfquery>
	-- <i>updated</i><br>
	<cfset testerCount=testerCount + 1>
</cfloop>