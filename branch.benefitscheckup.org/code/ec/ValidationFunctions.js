// =======================================
// DESCRIPTION: Contains all the basic javascript for validation and such
// CALLED BY: N/A
// GOES TO: N/A
// REQUIRED: N/A
// ============================================

function feedback(i) {
   var h = open(i, 'feedback', 
   "width=500,height=500,status=yes,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
} 

function lookup(i) {
    var d =open(i, 'Glossary', 
    "width=400,height=300,status=no,toolbar=no,menubar=no");
}

function helpold(i) {
   var h = window.open(i,'Hint',"scrollbars=yes,resizable=yes,width=400,height=200");
}

// 4-7-2001  replaced help old with new javascript function because the old one did not work on AOL 
function help(i) {
   var h = open(i, 'Help', 
    "width=400,height=200,status=yes,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
} 

function help2old(i) {
   var h = window.open(i,'Hint',
   "scrollbars=yes,resizable=yes,width=500,height=600,top=100,left=100,screenx=100");
}

function help2(i) {
   var h = open(i, 'Help', 
   "width=500,height=400,status=no,toolbar=no,scrollbars=yes,resizable=yes,menubar=no");
} 

function help3(i) {
   var h = open(i, 'Help', 
   "width=450,height=550,status=yes,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
} 

function help5(i) {
   var h = open(i, 'Print', 
   "width=800,height=600,status=yes,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
} 

function help4(i) {
   var h = open(i, 'Help', 
   "width=550,height=550,status=yes,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
} 

function recapwin(i) {
   var h = open(i, 'Help', 
   "width=500,height=600,status=no,toolbar=no,menubar=no");
}
    
function bufferwin(i){
   var d =window.open(i,'Glossary',"scrollbars=yes,resizable=yes,width=400,height=275");
}
   
function openWin2(i) {
  myWin= open(i, "displayWindow", 
  "width=400,height=300,status=no,toolbar=no,menubar=no");
} 
	
function chkDollar(Field,FieldValue){
	var x = FieldValue
	if (x.lastIndexOf(".") > 0)
	{x = x.substring(0,x.lastIndexOf("."));}
	x = x.replace(/[^0-9]/g,"");
	Field.value = x
}

function uncheckNoneSpouse() {
	var foundElement = false;
	for (var i = 0; i < document.questions.elements.length; i++) {
		if (document.questions.elements[i].name == 'miscspouse') {
			foundElement = true;
		}
	}
	if (foundElement) {
		document.questions.miscspouse.checked = false;
	}
}

function uncheckNoneSelf() {
	var foundElement = false;
	for (var i = 0; i < document.questions.elements.length; i++) {
		if (document.questions.elements[i].name == 'miscself') {
			foundElement = true;
		}
	}
	if (foundElement) {
		document.questions.miscself.checked = false;
	}
}

function uncheckAllSelf() {
   document.questions.gov.checked = false;
   document.questions.fed_gov.checked = false;
   document.questions.railroad.checked = false;
}

function uncheckAllSpouse() {
   document.questions.sp_gov.checked = false;
   document.questions.sp_fed_gov.checked = false;
   document.questions.sp_railroad.checked = false;
}

// This is code to validate text boxes any character that is valid for the answer must be included in the string valid

function validatetext(field) {
	var valid = "abcdefghijklmnopqrstuvwxyz/-ABCDEFGHIJKLMNOPQRSTUVWXYZ "
	var ok = "yes";
	var temp;
	for (var i=0; i<field.value.length; i++) {
   	temp = "" + field.value.substring(i, i+1);
	   if (valid.indexOf(temp) == "-1") ok = "no";
	}
	if (ok == "no") {
   	alert("Please remove any special characters (i.e. quotation marks or ampersands)");
	   field.focus();
   	field.select();
	}
}

// This is code to check the other text field and the gender radio buttons
function validateWelcome() {
	var client = document.formwelcome.client1
	var other = document.formwelcome.client_other
	var gender = document.formwelcome.gender
   var zip = document.formwelcome.zip
	if (client.value == "other")
		{
		if (other.value == "")
			{
			window.alert("Please fill in the box for Other. Ex. Friend, Cousin, Grandma, etc.");
			return false
			}
// 01/28/00--JL --- added code to check for spaces in Other answer
			// if (other.value.indexOf(' ', 0) > 0) 
			// {
			//	window.alert("Please remove any spaces in the Other box for question 1. (i.e. change 'My Uncle' to 'Uncle')");
			//	return false;
			// }
		}
	if (gender == "")
		{
		window.alert("Please select male or female.");
		return false
		}
   if (zip == "")
			{
			window.alert("Please enter a zip code.");
			return false
			}
	return true;
}

// This is to check and make sure that the zip code is at least numeric--->
	function validatezip(field) {
	var valid = "0123456789"
	var ok = "yes";
	var temp;
	for (var i=0; i<field.value.length; i++) {
   	temp = "" + field.value.substring(i, i+1);
   	if (valid.indexOf(temp) == "-1") ok = "no";
	}
	if (ok == "no") {
   	alert("The zipcode must be all numbers, please check again.");
	   field.focus();
   	field.select();
	}
}

// This is to check and make sure that only numbers are allowed on the income/asset grid
	function validateincomeasset(field) {
	var valid = "0123456789"
	var ok = "yes";
	var temp;
	for (var i=0; i<field.value.length; i++) {
   	temp = "" + field.value.substring(i, i+1);
	   if (valid.indexOf(temp) == "-1") ok = "no";
	}
	if (ok == "no") {
   	alert("Please do not use commas, dollar signs, or decimal points, as all entries must be numeric.");
   	field.focus();
	   field.select();
   }
}

// This is to check and make sure that only numbers are allowed on the income/asset grid and there are no blanks
	function validateincomeassetandblanks(field) {
	var valid = "0123456789"
	var ok = "yes";
	var temp;
	if (field.value == "")
	{
   	alert("Please complete all boxes in grid; use the number 0 for any questions that do not apply to you.");
	   field.focus();
   	field.select();
	}
	//for (var i=0; i<field.value.length; i++) {
	//temp = "" + field.value.substring(i, i+1);
	//if (valid.indexOf(temp) == "-1") ok = "no";
	//}
	//if (ok == "no") {
	//alert("Por favor remueva cualquier carácter especial (i.e. comillas o signos ortográficos o espacios).");
	//field.focus();
	//field.select();
	   //} 
}

// validate date and is date string work together-isDateString checks to see that it is a valid
// date,  but only returns true or false- so validate date calls the other and then checks for 
// the answer and returns alert box if appropriate

function validateDateSelf(stringHolder) {

   // get the value
   var stringValue = new String(stringHolder);
		
   // test it
   if ( stringValue != "" ) { 

      var stringTrue = new String(isDateString(stringValue));
      if ( stringTrue == "false" ) {
         alert("You have entered an invalid date of birth,  Please re-enter using the correct date format (ex. 02/02/1933). Be sure to use 2 digits for month, 2 digits for date, and 4 digits for year.  Please use the '/ ' key to separate month, date, and year.");
         document.questions.elements[2].focus();
      }     
   }
}

function validateDateSpouse(stringHolder) {

   // get the value
   var stringValue = new String(stringHolder);
		
   // test it
   if ( stringValue != "" ) { 

      var stringTrue = new String(isDateString(stringValue));
      if ( stringTrue == "false" ) {
         alert("You have entered an invalid date of birth,  Please re-enter using the correct date format (ex. 02/02/1933). Be sure to use 2 digits for month, 2 digits for date, and 4 digits for year.  Please use the '/ ' key to separate month, date, and year.");
         document.questions.elements[2].focus();
      }     
   }
}

function isDateString(stringValue) {

   var theString = new String(stringValue);
   tagCheck = theString.indexOf("0000");
   if(tagCheck != -1)
      return false;


   // determine the delimiter character (must be "/" "-" or space)
   var delimiterCharacter
   if ( theString.indexOf('/') > 0 )
      delimiterCharacter = '/';
   else
   if ( theString.indexOf('-') > 0 )
      delimiterCharacter = '-';
   else
   if ( theString.indexOf(' ') > 0 )
      delimiterCharacter = ' ';
   else
      return false;
					
   // split the string into an array of tokens
   var theTokens = theString.split(delimiterCharacter);
		
   // there must be either two or three tokens
   if ( theTokens.length < 2 || theTokens.length > 3 )
      return false;
		
   // convert the tokens to String objects, which will be needed later,
   // stripping a single leading 0
   var tokenIndex;
   for ( tokenIndex = 0; tokenIndex < theTokens.length; tokenIndex++ ) {
      theTokens[tokenIndex] = new String(theTokens[tokenIndex])			
      if ( theTokens[tokenIndex].charAt(0) == '0' ) {
         theTokens[tokenIndex] = theTokens[tokenIndex].substring(1, theTokens[tokenIndex].length);
		}
   }
   
   // all of the tokens must be positive integers
   for ( tokenIndex = 0; tokenIndex < theTokens.length; tokenIndex++ ) {
      if ( ! isNonnegativeInteger(theTokens[tokenIndex]) )
         return false;
   }
		
   // we need to identify the year, month, and day tokens
   var numericValue;
   var yearTokenIndex = -1;
   var monthTokenIndex = -1;
   var dayTokenIndex = -1;
   for ( tokenIndex = 0; tokenIndex < theTokens.length; tokenIndex++ ) {
					
      // convert the value
      numericValue = parseInt(theTokens[tokenIndex], 10);
					
      // could this token be a month?
      if ( numericValue <= 12 ) {
					
         // yes; do we already have a month?
         if ( monthTokenIndex == -1 ) {
   						
            // no; assign this token to the month and continue
            monthTokenIndex = tokenIndex;
            continue;

            // we already have a month; this token could
            // also be the day; do we already have a day?
   		} else if ( dayTokenIndex == -1 ) {
   						
            // no; assign this token to the day and continue
               dayTokenIndex = tokenIndex;
               continue;
               
            // we already have a day; this token could
            // also be the year; do we alreay have a year?
         } else if ( yearTokenIndex == -1 ) {
   						
            // no; assign this token to the year and continue
            dayTokenIndex = tokenIndex;
            continue;
         }

		} else {
						
         // the value is too large for a month;
         // could this token be a day?
         if ( numericValue <= 31 ) {
						
            // yes; do we already have a day?
            if ( dayTokenIndex == -1 ) {
						
               // no; assign this token to the day and continue
               dayTokenIndex = tokenIndex;
               continue;

               // we already have a day; this token could
               // also be the year; do we alreay have a year?
            } else if ( yearTokenIndex == -1 ) {
						
               // no; assign this token to the year and continue
               dayTokenIndex = tokenIndex;
               continue;
            }

         } else {
						
            // the value is too large for a day;
            // could this token be a year?
            if ( numericValue <= 9999 ) {
					
               // yes; do we already have a year?
               if ( yearTokenIndex == -1 ) {
						
                  // no; assign this token to the year
                  yearTokenIndex = tokenIndex;
               }
            }
         }
      }
   }	// end of for loop
		
   // evaluate, based on the number of tokens
   if ( theTokens.length == 2 ) {
			
      // two tokens can be either a month/year combination or a month/day
      // combination with the current year assumed; either way, we must have
      // a month
      if ( monthTokenIndex == -1 ) {
				
         // no month
         return false;

      }
				
      // do we have a year?
      if ( ! (yearTokenIndex == -1) ) {

         // yes; month/year combination; must be okay
         return true;
            
         // no year; do we have a day?
      } else if ( ! (dayTokenIndex == -1) ) {

         // yes; month/day combination; get the current year
         var today = new Date();
         var currentYear = today.getYear();
      
         // make sure it's a valid date (we were testing days using
         // 31, and that might be too many for the month)
         return isDate(currentYear, theTokens[monthTokenIndex], theTokens[dayTokenIndex]);

       } else {
				
               // we have neither a year nor a day
               return false;
       }

   } else {
			
      // three tokens; we should have found tokens for year, month, and day
      if ( yearTokenIndex == -1 || monthTokenIndex == -1 || dayTokenIndex == -1 ) {
	
         // missing one or more
         return false;
            
      // found all; however, VBScript can only handle the following sequences
      } else if ( monthTokenIndex == 0 ) {
	
         // must be m/d/y
         if ( dayTokenIndex != 1 || yearTokenIndex != 2)
            return false;

      } else if ( dayTokenIndex == 0 ) {
	
         // must be d/m/y
         if ( monthTokenIndex != 1 || yearTokenIndex != 2)
            return false;

       } else if ( yearTokenIndex == 0 ) {
	
            // must be y/m/d
            if ( monthTokenIndex != 1 || dayTokenIndex != 2)
               return false;

       } else {
			
            // something is wrong
            return false;

        }
				
      // make sure it's a valid date (we were testing days using a value
      // of 31, and that might be too many for the actual month)
      return isDate(theTokens[yearTokenIndex], theTokens[monthTokenIndex], theTokens[dayTokenIndex]);

   }
}

// most of the following was derived from Netscape's FormChek.js
// library, which should be reviewed for documentation and comments

var daysInMonth = makeArray(12);
daysInMonth[1] = 31;
daysInMonth[2] = 29;
daysInMonth[3] = 31;
daysInMonth[4] = 30;
daysInMonth[5] = 31;
daysInMonth[6] = 30;
daysInMonth[7] = 31;
daysInMonth[8] = 31;
daysInMonth[9] = 30;
daysInMonth[10] = 31;
daysInMonth[11] = 30;
daysInMonth[12] = 31;

var whitespace = " \t\n\r";

function charInString(c, s) {
for (i = 0; i < s.length; i++) {
if (s.charAt(i) == c)
	return true;
  }
  return false
}

function daysInFebruary(year) {
  return ( ((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}

function isDate(year, month, day) {
  if ( ! ( isYear(year) && isMonth(month) && isDay(day) ) ) return false;
  var intYear = parseInt(year);
  var intMonth = parseInt(month);
  var intDay = parseInt(day);
  if ( intDay > daysInMonth[intMonth] ) return false; 
  if ( ( intMonth == 2 ) && ( intDay > daysInFebruary(intYear) ) ) return false;
  return true;
}

function isDay(s) {
  return isIntegerInRange(s, 1, 31);
}

function isDigit(c) {
return ( ( c >= "0" ) && ( c <= "9" ) )
}

function isInteger(s) {
var i;
  for ( i = 0; i < s.length; i++ )
  {   
      var c = s.charAt(i);
      if ( ! isDigit(c) ) return false;
  }
  return true;
}

function isIntegerInRange(s, a, b) {
  if ( ! isInteger(s) ) return false;
  var num = parseInt (s);
  return ( ( num >= a ) && ( num <= b ) );
}

function isMonth(s) {
  return isIntegerInRange (s, 1, 12);
}

function isNonnegativeInteger(s) {
  return ( isSignedInteger(s) && ( parseInt(s) >= 0 ) );
}

function isSignedInteger(s) {
  var startPos = 0;
  if ( ( s.charAt(0) == "-" ) || ( s.charAt(0) == "+" ) )
     startPos = 1;    
  return ( isInteger(s.substring(startPos, s.length)) )
}

function isYear(s) {
if ( ! isNonnegativeInteger(s) ) return false;
  return ( (s.length == 2) || (s.length == 4) );
}

function lTrim(s) {
var i = 0;
  while ( (i < s.length) && charInString(s.charAt(i), whitespace) )
     i++;
  return s.substring(i, s.length);
}

function makeArray(n) {
 for ( var i = 1; i <= n; i++ ) {
    this[i] = 0
 } 
 return this
}

function rTrim(s) {
var i = 0;
  while ( (i < s.length) && charInString(s.charAt(i), whitespace) )
     i++;
  return s.substring(i, s.length);
}

function trim(s) {
return lTrim(rTrim(s));
}
	
	

function jsConfirm() {
   if (confirm("Are you sure you want to start over? If you start over without first printing the report, you will lose the information contained in your report. Please select cancel if you want to go back to your report.")) {
      alert("Restarting Questionnaire");
      location.href = "before_you_start.cfm";
   } else {
      alert("Returning to Results Overview.");
   }
}
	
function StartOver() {
   parent.close();
}
	
function ExitReport() {
   parent.close(); 
}
	
function checkitbaby(element){
   if (element.value == "") {
      alert("Please enter a value for both questions!(That means you)");
   }
}

function recapwin(i) {
   var d = window.open(i,'Glossary',
   "scrollbars=yes,resizable=yes,width=400,height=375,top=150,screenY=150,left=150,screenX=150");
}
