
var newmsn = true; //for publishing switchover to new msn 

var is_msncobrand = false;
var window_params = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resize=no,copyhistory=0,width=300,height=535';

if(location.href.indexOf("msn.") != -1)
	{
	is_msncobrand = true;
	}

//keep this function for legacy places in publishing code
function email_article(guid_source, guid_source_id, encodedurl)
	{
	email_article(guid_source, encodedurl);
	}

function email_article(guid_source, RelativeUrl) {
	if (is_msncobrand)
		{
		window.location = "/email_friend?guid=" + guid_source + "&uri=" + RelativeUrl;
		}
	else
		{
		window.open("/email_friend?guid=" + guid_source + "&uri=" + RelativeUrl,"",window_params);
		}
    }

//non cms pages
function email_friend(url,title,description) {
	var eml_str;
	eml_str = "/email_friend?uri=" + url + "&title=" + title + "&desc=" + description;
	if (is_msncobrand)
		{
		window.location = eml_str;
		}
	else
		{
		window.open(eml_str,"",window_params);
		}
    }

function PopupOpener(appUrl,urlParam,windowParam)
	{
		window.open(appUrl + urlParam,"",windowParam)
	}

//defining a javascript function to extract a cookie value
function getcookie(cookiename) 
{
	//Get the cookie string
	var cookiestring=""+document.cookie;

	//Locate the cookie name location
	var index1=cookiestring.indexOf(cookiename);

	//If the cookie does not exist the return empty string
	if (index1==-1 || cookiename=="") return ""; 

	//locate the end of the cookie
	var index2=cookiestring.indexOf(';',index1);
	if (index2==-1) index2=cookiestring.length; 

	//extract and send the value back
	return unescape(cookiestring.substring(index1+cookiename.length+1,index2));
}
