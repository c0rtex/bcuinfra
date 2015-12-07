
function GetLanguageIndex()
/* 
	Retrieves the language parameter found on most pages as a hidden form field.
	Then converts it to an array index position where:
		0 - English
		1 - Spanish
*/
{
	var sLanguage;
	sLanguage = document.frmNavigate.language.value;
	var nLangPs;
	
	switch (sLanguage){
		case 'English' :
			nLangPs = 0;
			break;
		case 'Spanish' :
			nLangPs = 1;
			break;
		default : nLangPs = 0;
	}

	return nLangPs;
}

function validateCountySelection(){

	var nLangPs = GetLanguageIndex();
	var saLangText = new Array(2);

	if (document.frmZipCustomize.County[0].selected == true){
		saLangText[0] = "Please select a county from the list box before you proceed.";
		saLangText[1] = "Please select a county from the list box before you proceed.";
		alert (saLangText[nLangPs]);
		return false;
	}
}

function validateSecondSetofQuestions(){

	var nLangPs = GetLanguageIndex();
	var saLangText = new Array(2);
	
	if (document.frmBenefitsPrograms.County) {
		// we need to do this check, because sometimes we have County as a hidden input
		if (document.frmBenefitsPrograms.County.type != "hidden") {
			if (document.frmBenefitsPrograms.County[0].selected == true) {
				saLangText[0] = "Please select a value for the County Question.";
				saLangText[1] = "Favor de seleccionar un valor para la pregunta de condado.";
				alert (saLangText[nLangPs]);
				return false;
			}
		}
	}

	if (document.frmBenefitsPrograms.IHS) {
		if (document.frmBenefitsPrograms.IHS[0].selected == true){
			saLangText[0] = "Please select a value for Question 4 (American Indian Health Services pharmacies Question).";
			saLangText[1] = "Favor de seleccionar un valor para la pregunta 4 (pregunta sobre las farmacias de Servicios de Atención Médica para Indígenas Americanos).";
			alert (saLangText[nLangPs]);
			return false;
		}
	}
	
	if (document.frmBenefitsPrograms.LTC) {
		if (document.frmBenefitsPrograms.LTC[0].selected == true){
			saLangText[0] = "Please select a value for Question 5 (Long Term Care pharmacies Question).";
			saLangText[1] = "Favor de seleccionar un valor para la pregunta 5 (pregunta sobre las farmacias de cuidado a largo plazo).";
			alert (saLangText[nLangPs]);
			return false;
		}
	}
	
	//Begin M+C Enhancements - July 2004
	if (document.frmBenefitsPrograms.MPlusC) {
		if (document.frmBenefitsPrograms.MPlusC[0].selected == true){
			saLangText[0] = "Please select a value for Question 6 (Medicare Advantage Question).";
			saLangText[1] = "Favor de seleccionar un valor para la pregunta 6 (pregunta sobre Medicare Advantage).";
			alert (saLangText[nLangPs]);
			return false;
		}
	}
	//End M+C Enhancements


}

function validateParameters(){

	var nLangPs = GetLanguageIndex();
	var saLangText = new Array(2);
	
	if (document.frmBenefitsPrograms.MedicarePart[0].selected == true){
		saLangText[0] = "Please select a value for Question 1 (Medicare Question).";
		saLangText[1] = "Favor de seleccionar un valor para la pregunta 1 (pregunta sobre el Medicare).";
		alert (saLangText[nLangPs]);
		return false;
	}
	
	if ((document.frmBenefitsPrograms.Vet[0].checked == false) &&
		(document.frmBenefitsPrograms.Vet[1].checked == false) &&
		(document.frmBenefitsPrograms.Vet[2].checked == false) &&
		(document.frmBenefitsPrograms.Vet[3].checked == false) &&
		(document.frmBenefitsPrograms.Vet[4].checked == false))
	{
		saLangText[0] = "Please check at least one value for Question 2 (Eligible or Receiving Question).";
		saLangText[1] = "Usted debe seleccionar por lo menos una respuesta a la pregunta 2. Si no es aplicable a usted, favor de marcar la opción 'Ninguno de los anteriores'.";
		alert (saLangText[nLangPs]);
		return false;
	}

	var sValue = document.frmBenefitsPrograms.zip.value
	if (sValue.length != 5)
	{
		saLangText[0] = "Please make sure you entered a valid five digit ZIP Code.";
		saLangText[1] = "Favor asegúrese de asentar un código postal (ZIP, por sus siglas en inglés) de cinco dígitos válido.";
		alert(saLangText[nLangPs]);
		return false;
	}
	if (isNaN(sValue))
	{
		saLangText[0] = "Please make sure you entered a valid five digit ZIP Code.";
		saLangText[1] = "Favor asegúrese de asentar un código postal (ZIP, por sus siglas en inglés) de cinco dígitos válido.";
		alert(saLangText[nLangPs]);
		return false;
	}
}

function changeValuesForVet(){
	document.frmBenefitsPrograms.Vet[4].checked = false;
}

function changeValuesForVetForNone(){
	document.frmBenefitsPrograms.Vet[0].checked = false;
	document.frmBenefitsPrograms.Vet[1].checked = false;
	document.frmBenefitsPrograms.Vet[2].checked = false;
	document.frmBenefitsPrograms.Vet[3].checked = false;
}

function checkForNoneCheckBox(){
	if ((document.frmBenefitsPrograms.Vet[0].checked == true) ||
		(document.frmBenefitsPrograms.Vet[1].checked == true) ||
		(document.frmBenefitsPrograms.Vet[2].checked == true) ||
		(document.frmBenefitsPrograms.Vet[3].checked == true)){
		document.frmBenefitsPrograms.Vet[4].checked = false;
	}else{
		document.frmBenefitsPrograms.Vet[4].checked = true;
	}
}

function changeValues(qID, aID){
	
	//if the veteran question was answered, then check if "none" was selected or not
	if (qID == 5){
		if (aID == 12){
			changeValuesForVetForNone();
		}
		else{
			changeValuesForVet();
		}
		checkForNoneCheckBox()
	}
}