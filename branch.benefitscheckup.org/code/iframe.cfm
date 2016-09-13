

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<script type="text/javascript">

document.domain="benefitscheckup.org";

function calcHeight()
{
  //calculate height
  var the_height=
    document.getElementById('bcuframe').contentWindow.
      document.body.scrollHeight;

  //minimal height of 600
  // if (the_height < 600) {the_height=600}

  //change height
  document.getElementById('bcuframe').height=
      the_height;
}

</script>

<!-- Style sheets start -->
<link rel=stylesheet href="http://bcuqa.benefitscheckup.org/css/bcu.css" type="text/css" media="screen" />
<link rel=stylesheet href="http://bcuqa.benefitscheckup.org//css/menu.css" type="text/css" media="screen" />


<!--[if IE]>
<link rel=stylesheet href="http://bcuqa.benefitscheckup.org//css/bcu.css" type="text/css" media="screen" />
<link rel=stylesheet href="http://bcuqa.benefitscheckup.org//css/menuie.css" type="text/css" media="screen" />
<![endif]-->
<!-- Style sheets end -->

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>IFrame Test</title>
</head>

<body>
<table height="100%">
<tr>
<td><IFRAME SRC="http://beta.benefitscheckup.org/AssistGuide" TITLE="BCU Iframe" id="bcuframe" height="1" width="800" frameborder="0" scrolling="no" onload="calcHeight();">
</IFRAME></td>
</tr>
</table>
</body>
</html>
