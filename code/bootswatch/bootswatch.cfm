<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Bootswatch: Styles For NCOA</title>
 
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

<cfinclude template="stylesheet_switch.cfm">    
    <link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="bootstrap/css/bootswatch.css" rel="stylesheet">


  </head>

  <body class="preview" id="top" data-spy="scroll" data-target=".subnav" data-offset="80">
   
<cfinclude template="testing_menu.cfm">

  <!-- Navbar
    ================================================== -->
 <div class="navbar navbar-fixed-top">
   <div class="navbar-inner">
     <div class="container">
       <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
         <span class="icon-bar"></span>
         <span class="icon-bar"></span>
         <span class="icon-bar"></span>
       </a>
       <a class="brand" href="../">Bootswatch</a>
       <div class="nav-collapse collapse" id="main-menu">
        <ul class="nav" id="main-menu-left">
          <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">Style Preview <b class="caret"></b></a>
            <ul class="dropdown-menu" id="swatch-menu">
              <li><a href="bootswatch.cfm?style=default">Default</a></li>
              <li class="divider"></li>
		<li><a href="bootswatch.cfm?style=esi">Esi</a></li>
              <li><a href="bootswatch.cfm?style=amelia">Amelia</a></li>
              <li><a href="bootswatch.cfm?style=cerulean">Cerulean</a></li>
              <li><a href="bootswatch.cfm?style=cosmo">Cosmo</a></li>
              <li><a href="bootswatch.cfm?style=cyborg">Cyborg</a></li>
              <li><a href="bootswatch.cfm?style=journal">Journal</a></li>
              <li><a href="bootswatch.cfm?style=readable">Readable</a></li>
              <li><a href="bootswatch.cfm?style=simplex">Simplex</a></li>
              <li><a href="bootswatch.cfm?style=slate">Slate</a></li>
              <li><a href="bootswatch.cfm?style=spacelab">Spacelab</a></li>
              <li><a href="bootswatch.cfm?style=spruce">Spruce</a></li>
              <li><a href="bootswatch.cfm?style=superhero">Superhero</a></li>
              <li><a href="bootswatch.cfm?style=united">United</a></li>
            </ul>
          </li>
          <li class="dropdown" id="preview-menu">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">Single Page Questionnaire <b class="caret"></b></a>
            <ul class="dropdown-menu" id="questionnaire-menu">
              <li><a href="/cf/bootswatch/styleswitch.cfm?style=default">Default</a></li>
              <li class="divider"></li>
		<li><a href="/cf/bootswatch/styleswitch.cfm?style=esi">ESI</a></li>
              <li><a href="/cf/bootswatch/styleswitch.cfm?style=amelia">Amelia</a></li>
              <li><a href="/cf/bootswatch/styleswitch.cfm?style=cerulean">Cerulean</a></li>
              <li><a href="/cf/bootswatch/styleswitch.cfm?style=cosmo">Cosmo</a></li>
              <li><a href="/cf/bootswatch/styleswitch.cfm?style=cyborg">Cyborg</a></li>
              <li><a href="/cf/bootswatch/styleswitch.cfm?style=journal">Journal</a></li>
              <li><a href="/cf/bootswatch/styleswitch.cfm?style=readable">Readable</a></li>
              <li><a href="/cf/bootswatch/styleswitch.cfm?style=simplex">Simplex</a></li>
              <li><a href="/cf/bootswatch/styleswitch.cfm?style=slate">Slate</a></li>
              <li><a href="/cf/bootswatch/styleswitch.cfm?style=spacelab">Spacelab</a></li>
              <li><a href="/cf/bootswatch/styleswitch.cfm?style=spruce">Spruce</a></li>
              <li><a href="/cf/bootswatch/styleswitch.cfm?style=superhero">Superhero</a></li>
              <li><a href="/cf/bootswatch/styleswitch.cfm?style=united">United</a></li>

            </ul>
          </li>
        </ul>
        <ul class="nav pull-right" id="main-menu-right">
          <li><a rel="tooltip"  href="#icons" title="Some Example Icons from Font Awesome." >View Sample Icons <i class="icon-share-alt"></i></a></li>
          <li><a rel="tooltip" target="_blank" href="https://wrapbootstrap.com/?ref=bsw" title="Marketplace for premium Bootstrap templates" >WrapBootstrap <i class="icon-share-alt"></i></a></li>
	</ul>
       </div>
     </div>
   </div>
 </div>

    <div class="container">


<!-- Masthead
================================================== -->
<header class="jumbotron subhead" id="overview">
  <div class="row">
    <div class="span6">
      <h1>Heading</h1>
      <p class="lead">Large paragraph text. Some more words.</p>
    </div>
    <div class="span6">
      <div class="bsa well">
          <div ><ol>
		<li> <i class="icon-book" ></i> Put something here </li>
		<li> <i class="icon-beer" ></i> A picture or menu perhaps </li>
		<li> <i class="icon-star" ></i> More text </li>
		</ol></div>
      </div>
    </div>
  </div>
  <div class="subnav">
    <ul class="nav nav-pills">
      <li><a href="#typography">Typography</a></li>
      <li><a href="#navbar">Navbar</a></li>
      <li><a href="#buttons">Buttons</a></li>
      <li><a href="#forms">Forms</a></li>
      <li><a href="#tables">Tables</a></li>
      <li><a href="#miscellaneous">Miscellaneous</a></li>
      <li><a href="#icons">Icons</a></li>
    </ul>
  </div>
  
</header>




<!-- Typography
================================================== -->
<section id="typography">
  <div class="page-header">
    <h1>Typography</h1>
  </div>

  <!-- Headings & Paragraph Copy -->
  <div class="row">

    <div class="span4">
      <div class="well">
        <h1>h1. Heading 1</h1>
        <h2>h2. Heading 2</h2>
        <h3>h3. Heading 3</h3>
        <h4>h4. Heading 4</h4>
        <h5>h5. Heading 5</h5>
        <h6>h6. Heading 6</h6>
      </div>
    </div>

    <div class="span4">
      <h3>Example body text</h3>
      <p>Nullam quis risus eget urna mollis ornare vel eu leo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
      <p>Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Donec sed odio dui.</p>
    </div>

    <div class="span4">
      <h3>Example addresses</h3>
      <address>
        <strong>Twitter, Inc.</strong><br>
        795 Folsom Ave, Suite 600<br>
        San Francisco, CA 94107<br>
        <abbr title="Phone">P:</abbr> (123) 456-7890
      </address>
      <address>
        <strong>Full Name</strong><br>
        <a href="mailto:#">first.last@gmail.com</a>
      </address>
    </div>

  </div>
  
  <div class="row">
    <div class="span6">
      <blockquote>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.</p>
        <small>Someone famous in <cite title="Source Title">Source Title</cite></small>
      </blockquote>
    </div>
    <div class="span6">
      <blockquote class="pull-right">
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.</p>
        <small>Someone famous in <cite title="Source Title">Source Title</cite></small>
      </blockquote>
    </div>
  </div>

</section>


<!-- Navbar
================================================== -->
<section id="navbar">
  <div class="page-header">
    <h1>Navbars</h1>
  </div>
  <div class="navbar">
    <div class="navbar-inner">
      <div class="container" style="width: auto;">
        <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </a>
        <a class="brand" href="#">Project name</a>
        <div class="nav-collapse">
          <ul class="nav">
            <li class="active"><a href="#">Home</a></li>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#">Action</a></li>
                <li><a href="#">Another action</a></li>
                <li><a href="#">Something else here</a></li>
                <li class="divider"></li>
                <li><a href="#">Separated link</a></li>
              </ul>
            </li>
          </ul>
          <form class="navbar-search pull-left" action="">
            <input type="text" class="search-query span2" placeholder="Search">
          </form>
          <ul class="nav pull-right">
            <li><a href="#">Link</a></li>
            <li class="divider-vertical"></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#">Action</a></li>
                <li><a href="#">Another action</a></li>
                <li><a href="#">Something else here</a></li>
                <li class="divider"></li>
                <li><a href="#">Separated link</a></li>
              </ul>
            </li>
          </ul>
        </div><!-- /.nav-collapse -->
      </div>
    </div><!-- /navbar-inner -->
  </div><!-- /navbar -->

  <div class="navbar navbar-inverse">
    <div class="navbar-inner">
      <div class="container" style="width: auto;">
        <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </a>
        <a class="brand" href="#">Project name</a>
        <div class="nav-collapse">
          <ul class="nav">
            <li class="active"><a href="#">Home</a></li>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#">Action</a></li>
                <li><a href="#">Another action</a></li>
                <li><a href="#">Something else here</a></li>
                <li class="divider"></li>
                <li><a href="#">Separated link</a></li>
              </ul>
            </li>
          </ul>
          <form class="navbar-search pull-left" action="">
            <input type="text" class="search-query span2" placeholder="Search">
          </form>
          <ul class="nav pull-right">
            <li><a href="#">Link</a></li>
            <li class="divider-vertical"></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#">Action</a></li>
                <li><a href="#">Another action</a></li>
                <li><a href="#">Something else here</a></li>
                <li class="divider"></li>
                <li><a href="#">Separated link</a></li>
              </ul>
            </li>
          </ul>
        </div><!-- /.nav-collapse -->
      </div>
    </div><!-- /navbar-inner -->
  </div><!-- /navbar -->

</section>



<!-- Buttons
================================================== -->
<section id="buttons">
  <div class="page-header">
    <h1>Buttons</h1>
  </div>
  <table class="table table-bordered table-striped">
    <thead>
      <tr>
        <th>Button</th>
        <th>Large Button</th>
        <th>Small Button</th>
        <th>Disabled Button</th>
    <th>Button with Icon</th>
    <th>Split Button</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><a class="btn" href="#">Default</a></td>
        <td><a class="btn btn-large" href="#">Default</a></td>
        <td><a class="btn btn-small" href="#">Default</a></td>
        <td><a class="btn disabled" href="#">Default</a></td>
        <td><a class="btn" href="#"><i class="icon-cog"></i> Default</a></td>
    <td>
          <div class="btn-group">
            <a class="btn" href="#">Default</a>
            <a class="btn dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">Action</a></li>
              <li><a href="#">Another action</a></li>
              <li><a href="#">Something else here</a></li>
              <li class="divider"></li>
              <li><a href="#">Separated link</a></li>
            </ul>
          </div><!-- /btn-group -->
    </td>
      </tr>
      <tr>
        <td><a class="btn btn-primary" href="#">Primary</a></td>
        <td><a class="btn btn-primary btn-large" href="#">Primary</a></td>
        <td><a class="btn btn-primary btn-small" href="#">Primary</a></td>
        <td><a class="btn btn-primary disabled" href="#">Primary</a></td>
        <td><a class="btn btn-primary" href="#"><i class="icon-shopping-cart icon-white"></i> Primary</a></td>
    <td>
          <div class="btn-group">
            <a class="btn btn-primary" href="#">Primary</a>
            <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">Action</a></li>
              <li><a href="#">Another action</a></li>
              <li><a href="#">Something else here</a></li>
              <li class="divider"></li>
              <li><a href="#">Separated link</a></li>
            </ul>
          </div><!-- /btn-group -->
    </td>
      </tr>
      <tr>
        <td><a class="btn btn-info" href="#">Info</a></td>
        <td><a class="btn btn-info btn-large" href="#">Info</a></td>
        <td><a class="btn btn-info btn-small" href="#">Info</a></td>
        <td><a class="btn btn-info disabled" href="#">Info</a></td>
        <td><a class="btn btn-info" href="#"><i class="icon-exclamation-sign icon-white"></i> Info</a></td>
    <td>
          <div class="btn-group">
            <a class="btn btn-info" href="#">Info</a>
            <a class="btn btn-info dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">Action</a></li>
              <li><a href="#">Another action</a></li>
              <li><a href="#">Something else here</a></li>
              <li class="divider"></li>
              <li><a href="#">Separated link</a></li>
            </ul>
          </div><!-- /btn-group -->
    </td>
      </tr>
      <tr>
        <td><a class="btn btn-success" href="#">Success</a></td>
        <td><a class="btn btn-success btn-large" href="#">Success</a></td>
        <td><a class="btn btn-success btn-small" href="#">Success</a></td>
        <td><a class="btn btn-success disabled" href="#">Success</a></td>
        <td><a class="btn btn-success" href="#"><i class="icon-ok icon-white"></i> Success</a></td>
    <td>
          <div class="btn-group">
            <a class="btn btn-success" href="#">Success</a>
            <a class="btn btn-success dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">Action</a></li>
              <li><a href="#">Another action</a></li>
              <li><a href="#">Something else here</a></li>
              <li class="divider"></li>
              <li><a href="#">Separated link</a></li>
            </ul>
          </div><!-- /btn-group -->
    </td>
      </tr>
      <tr>
        <td><a class="btn btn-warning" href="#">Warning</a></td>
        <td><a class="btn btn-warning btn-large" href="#">Warning</a></td>
        <td><a class="btn btn-warning btn-small" href="#">Warning</a></td>
        <td><a class="btn btn-warning disabled" href="#">Warning</a></td>
        <td><a class="btn btn-warning" href="#"><i class="icon-warning-sign icon-white"></i> Warning</a></td>
    <td>
          <div class="btn-group">
            <a class="btn btn-warning" href="#">Warning</a>
            <a class="btn btn-warning dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">Action</a></li>
              <li><a href="#">Another action</a></li>
              <li><a href="#">Something else here</a></li>
              <li class="divider"></li>
              <li><a href="#">Separated link</a></li>
            </ul>
          </div><!-- /btn-group -->
    </td>
      </tr>
      <tr>
        <td><a class="btn btn-danger" href="#">Danger</a></td>
        <td><a class="btn btn-danger btn-large" href="#">Danger</a></td>
        <td><a class="btn btn-danger btn-small" href="#">Danger</a></td>
        <td><a class="btn btn-danger disabled" href="#">Danger</a></td>
        <td><a class="btn btn-danger" href="#"><i class="icon-remove icon-white"></i> Danger</a></td>
    <td>
          <div class="btn-group">
            <a class="btn btn-danger" href="#">Danger</a>
            <a class="btn btn-danger dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">Action</a></li>
              <li><a href="#">Another action</a></li>
              <li><a href="#">Something else here</a></li>
              <li class="divider"></li>
              <li><a href="#">Separated link</a></li>
            </ul>
          </div><!-- /btn-group -->
    </td>
      </tr>
      <tr>
        <td><a class="btn btn-inverse" href="#">Inverse</a></td>
        <td><a class="btn btn-inverse btn-large" href="#">Inverse</a></td>
        <td><a class="btn btn-inverse btn-small" href="#">Inverse</a></td>
        <td><a class="btn btn-inverse disabled" href="#">Inverse</a></td>
        <td><a class="btn btn-inverse" href="#"><i class="icon-random icon-white"></i> Inverse</a></td>
    <td>
          <div class="btn-group">
            <a class="btn btn-inverse" href="#">Inverse</a>
            <a class="btn btn-inverse dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">Action</a></li>
              <li><a href="#">Another action</a></li>
              <li><a href="#">Something else here</a></li>
              <li class="divider"></li>
              <li><a href="#">Separated link</a></li>
            </ul>
          </div><!-- /btn-group -->
    </td>
      </tr>
    </tbody>
  </table>

</section>


<!-- Forms
================================================== -->
<section id="forms">
  <div class="page-header">
    <h1>Forms</h1>
  </div>

  <div class="row">
    <div class="span10 offset1">

      <form class="well form-search">
        <input type="text" class="input-medium search-query">
        <button type="submit" class="btn">Search</button>
      </form>

        <form class="well form-search">
          <input type="text" class="input-small" placeholder="Email">
          <input type="password" class="input-small" placeholder="Password">
          <button type="submit" class="btn">Go</button>
        </form>


      <form class="form-horizontal well">
        <fieldset>
          <legend>Controls Bootstrap supports</legend>
          <div class="control-group">
            <label class="control-label" for="input01">Text input</label>
            <div class="controls">
              <input type="text" class="input-xlarge" id="input01">
              <p class="help-block">In addition to freeform text, any HTML5 text-based input appears like so.</p>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="optionsCheckbox">Checkbox</label>
            <div class="controls">
              <label class="checkbox">
                <input type="checkbox" id="optionsCheckbox" value="option1">
                Option one is this and that&mdash;be sure to include why it's great
              </label>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="select01">Select list</label>
            <div class="controls">
              <select id="select01">
                <option>something</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
                <option>5</option>
              </select>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="multiSelect">Multicon-select</label>
            <div class="controls">
              <select multiple="multiple" id="multiSelect">
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
                <option>5</option>
              </select>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="fileInput">File input</label>
            <div class="controls">
              <input class="input-file" id="fileInput" type="file">
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="textarea">Textarea</label>
            <div class="controls">
              <textarea class="input-xlarge" id="textarea" rows="3"></textarea>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="focusedInput">Focused input</label>
            <div class="controls">
              <input class="input-xlarge focused" id="focusedInput" type="text" value="This is focused�">
            </div>
          </div>
          <div class="control-group">
            <label class="control-label">Uneditable input</label>
            <div class="controls">
              <span class="input-xlarge uneditable-input">Some value here</span>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="disabledInput">Disabled input</label>
            <div class="controls">
              <input class="input-xlarge disabled" id="disabledInput" type="text" placeholder="Disabled input here�" disabled>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="optionsCheckbox2">Disabled checkbox</label>
            <div class="controls">
              <label class="checkbox">
                <input type="checkbox" id="optionsCheckbox2" value="option1" disabled>
                This is a disabled checkbox
              </label>
            </div>
          </div>
          <div class="control-group warning">
            <label class="control-label" for="inputWarning">Input with warning</label>
            <div class="controls">
              <input type="text" id="inputWarning">
              <span class="help-inline">Something may have gone wrong</span>
            </div>
          </div>
          <div class="control-group error">
            <label class="control-label" for="inputError">Input with error</label>
            <div class="controls">
              <input type="text" id="inputError">
              <span class="help-inline">Please correct the error</span>
            </div>
          </div>
          <div class="control-group success">
            <label class="control-label" for="inputSuccess">Input with success</label>
            <div class="controls">
              <input type="text" id="inputSuccess">
              <span class="help-inline">Woohoo!</span>
            </div>
          </div>
          <div class="control-group info">
            <label class="control-label" for="selectError">Select with info</label>
            <div class="controls">
              <select id="selectError">
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
                <option>5</option>
              </select>
              <span class="help-inline">Woohoo!</span>
            </div>
          </div>
          <div class="form-actions">
            <button type="submit" class="btn btn-primary">Save changes</button>
            <button type="reset" class="btn">Cancel</button>
          </div>
        </fieldset>
      </form>
    </div>
  </div>

</section>

<!-- Tables
================================================== -->
<section id="tables">
  <div class="page-header">
    <h1>Tables</h1>
  </div>
  
  <table class="table table-bordered table-striped table-hover">
    <thead>
      <tr>
        <th>#</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Username</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>Mark</td>
        <td>Otto</td>
        <td>@mdo</td>
      </tr>
      <tr>
        <td>2</td>
        <td>Jacob</td>
        <td>Thornton</td>
        <td>@fat</td>
      </tr>
      <tr>
        <td>3</td>
        <td>Larry</td>
        <td>the Bird</td>
        <td>@twitter</td>
      </tr>
    </tbody>
  </table>
</section>


<!-- Miscellaneous
================================================== -->
<section id="miscellaneous">
  <div class="page-header">
    <h1>Miscellaneous</h1>
  </div>

  <div class="row">
    <div class="span4">

      <h3 id="breadcrumbs">Breadcrumbs</h3>
      <ul class="breadcrumb">
        <li class="active">Home</li>
      </ul>
      <ul class="breadcrumb">
        <li><a href="#">Home</a> <span class="divider">/</span></li>
        <li><a href="#">Library</a> <span class="divider">/</span></li>
        <li class="active">Data</li>
      </ul>
    </div>
    <div class="span4">
      <h3 id="pagination">Pagination</h3>
      <div class="pagination">
        <ul>
          <li><a href="#">&larr;</a></li>
          <li class="active"><a href="#">10</a></li>
          <li class="disabled"><a href="#">...</a></li>
          <li><a href="#">20</a></li>
          <li><a href="#">&rarr;</a></li>
        </ul>
      </div>
      <div class="pagination pagination-centered">
        <ul>
          <li class="active"><a href="#">1</a></li>
          <li><a href="#">2</a></li>
          <li><a href="#">3</a></li>
          <li><a href="#">4</a></li>
          <li><a href="#">5</a></li>
        </ul>
      </div>
    </div>
    
    <div class="span4">
      <h3 id="pager">Pagers</h3>
        
        <ul class="pager">
          <li><a href="#">Previous</a></li>
          <li><a href="#">Next</a></li>
        </ul>
        
        <ul class="pager">
          <li class="previous disabled"><a href="#">&larr; Older</a></li>
          <li class="next"><a href="#">Newer &rarr;</a></li>
        </ul>
    </div>
  </div>


  <!-- Navs
  ================================================== -->

  <div class="row">
    <div class="span4">

      <h3 id="tabs">Tabs</h3>
      <ul class="nav nav-tabs">
        <li class="active"><a href="#A" data-toggle="tab">Section 1</a></li>
        <li><a href="#B" data-toggle="tab">Section 2</a></li>
        <li class="disabled"><a href="#" data-toggle="tab">Section 3</a></li>
      </ul>
      <div class="tabbable">
        <div class="tab-content">
          <div class="tab-pane active" id="A">
            <p>I'm in Section A.</p>
          </div>
          <div class="tab-pane" id="B">
            <p>Howdy, I'm in Section B.</p>
          </div>
          <div class="tab-pane" id="C">
            <p>What up girl, this is Section C.</p>
          </div>
        </div>
      </div> <!-- /tabbable -->
      
    </div>
    <div class="span4">
      <h3 id="pills">Pills</h3>
      <ul class="nav nav-pills">
        <li class="active"><a href="#">Home</a></li>
        <li><a href="#">Profile</a></li>
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">Dropdown <b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="#">Action</a></li>
            <li><a href="#">Another action</a></li>
            <li><a href="#">Something else here</a></li>
            <li class="divider"></li>
            <li><a href="#">Separated link</a></li>
          </ul>
        </li>
        <li class="disabled"><a href="#">Disabled link</a></li>
      </ul>
    </div>
    
    <div class="span4">
      
      <h3 id="list">Lists</h3>
        
      <div class="well" style="padding: 8px 0;">
        <ul class="nav nav-list">
          <li class="nav-header">List header</li>
          <li class="active"><a href="#">Home</a></li>
          <li><a href="#">Library</a></li>
          <li><a href="#">Applications</a></li>
          <li class="nav-header">Another list header</li>
          <li><a href="#">Profile</a></li>
          <li><a href="#">Settings</a></li>
          <li class="divider"></li>
          <li><a href="#">Help</a></li>
        </ul>
      </div>
    </div>
  </div>


<!-- Labels
================================================== -->

  <div class="row">
    <div class="span6">
      <h3 id="labels">Labels</h3>
      <span class="label">Default</span>
      <span class="label label-success">Success</span>
      <span class="label label-warning">Warning</span>
      <span class="label label-important">Important</span>
      <span class="label label-info">Info</span>
      <span class="label label-inverse">Inverse</span>
    </div>
    <div class="span6">
      <h3 id="badges">Badges</h3>
      <span class="badge">Default</span>
      <span class="badge badge-success">Success</span>
      <span class="badge badge-warning">Warning</span>
      <span class="badge badge-important">Important</span>
      <span class="badge badge-info">Info</span>
      <span class="badge badge-inverse">Inverse</span>
    </div>
  </div>
  <br />

<!-- Progress bars
================================================== -->


  <h3 id="progressbars">Progress bars</h3>

  <div class="row">
    <div class="span4">
      <div class="progress">
        <div class="bar" style="width: 60%;"></div>
      </div>
    </div>
    <div class="span4">
      <div class="progress progress-info progress-striped">
        <div class="bar" style="width: 20%;"></div>
      </div>
    </div>
    <div class="span4">
      <div class="progress progress-danger progress-striped active">
        <div class="bar" style="width: 45%"></div>
      </div>
    </div>
  </div>
  <br />


<!-- Alerts & Messages
================================================== -->


  <h3 id="alerts">Alerts</h3>

  <div class="row">
    <div class="span12">
        <div class="alert alert-block">
          <a class="close">&times;</a>
          <h4 class="alert-heading">Alert block</h4>
          <p>Best check yo self, you're not looking too good. Nulla vitae elit libero, a pharetra augue. Praesent commodo cursus magna, vel scelerisque nisl consectetur et.</p>
        </div>
    </div>
  </div>
  <div class="row">
    <div class="span4">
      <div class="alert alert-error">
        <a class="close">&times;</a>
        <strong>Error</strong> Change a few things up and try submitting again.
      </div>
    </div>
    <div class="span4">
      <div class="alert alert-success">
        <a class="close">&times;</a>
        <strong>Success</strong> You successfully read this important alert message.
      </div>
    </div>
    <div class="span4">
      <div class="alert alert-info">
        <a class="close">&times;</a>
        <strong>Information</strong> This alert needs your attention, but it's not super important.
      </div>
    </div>
  </div>


</section>
<!-- Icons
================================================== -->
<section id="icons">
  <div class="page-header">
    <h1>Icons </h1>
  </div>
<h3 class="page-header">New Font Awesome Icons in Version 3.0</h3>
<div id="icons-new" class="row">
  <div class="span12">
    
    <p>
       New icons can be requested on the
      <a href="https://github.com/FortAwesome/Font-Awesome" target="_blank">Font Awesome GitHub project</a>. Or even
      better, you can <a href="#contribute">contribute your own icons</a>.
    </p>
  </div>

  <div class="span3">
    <ul class="the-icons">
      <li><i class="icon-cloud-download"></i> icon-cloud-download</li>
      <li><i class="icon-cloud-upload"></i> icon-cloud-upload</li>
      <li><i class="icon-lightbulb"></i> icon-lightbulb</li>
      <li><i class="icon-exchange"></i> icon-exchange</li>
      <li><i class="icon-bell-alt"></i> icon-bell-alt</li>
      <li><i class="icon-file-alt"></i> icon-file-alt</li>
      <li><i class="icon-beer"></i> icon-beer</li>
      <li><i class="icon-coffee"></i> icon-coffee</li>
      <li><i class="icon-food"></i> icon-food</li>
      <li><i class="icon-fighter-jet"></i> icon-fighter-jet</li>
    </ul>
  </div>
  <div class="span3">
    <ul class="the-icons">
      <li><i class="icon-user-md"></i> icon-user-md</li>
      <li><i class="icon-stethoscope"></i> icon-stethoscope</li>
      <li><i class="icon-suitcase"></i> icon-suitcase</li>
      <li><i class="icon-building"></i> icon-building</li>
      <li><i class="icon-hospital"></i> icon-hospital</li>
      <li><i class="icon-ambulance"></i> icon-ambulance</li>
      <li><i class="icon-medkit"></i> icon-medkit</li>
      <li><i class="icon-h-sign"></i> icon-h-sign</li>
      <li><i class="icon-plus-sign-alt"></i> icon-plus-sign-alt</li>
      <li><i class="icon-spinner"></i> icon-spinner</li>
    </ul>
  </div>
  <div class="span3">
    <ul class="the-icons">
      <li><i class="icon-angle-left"></i> icon-angle-left</li>
      <li><i class="icon-angle-right"></i> icon-angle-right</li>
      <li><i class="icon-angle-up"></i> icon-angle-up</li>
      <li><i class="icon-angle-down"></i> icon-angle-down</li>
      <li><i class="icon-double-angle-left"></i> icon-double-angle-left</li>
      <li><i class="icon-double-angle-right"></i> icon-double-angle-right</li>
      <li><i class="icon-double-angle-up"></i> icon-double-angle-up</li>
      <li><i class="icon-double-angle-down"></i> icon-double-angle-down</li>
      <li><i class="icon-circle-blank"></i> icon-circle-blank</li>
      <li><i class="icon-circle"></i> icon-circle</li>
    </ul>
  </div>
  <div class="span3">
    <ul class="the-icons">
      <li><i class="icon-desktop"></i> icon-desktop</li>
      <li><i class="icon-laptop"></i> icon-laptop</li>
      <li><i class="icon-tablet"></i> icon-tablet</li>
      <li><i class="icon-mobile-phone"></i> icon-mobile-phone</li>
      <li><i class="icon-quote-left"></i> icon-quote-left</li>
      <li><i class="icon-quote-right"></i> icon-quote-right</li>
      <li><i class="icon-reply"></i> icon-reply</li>
      <li><i class="icon-github-alt"></i> icon-github-alt</li>
      <li><i class="icon-folder-close-alt"></i> icon-folder-close-alt</li>
      <li><i class="icon-folder-open-alt"></i> icon-folder-open-alt</li>
    </ul>
  </div>
</div>
<h3 class="page-header">Large</h3>
<div id="icons-new" class="row">
  <div class="span3">
    <ul class="the-icons">
      <li><i class="icon-cloud-download icon-2x"></i> icon-cloud-download</li>
      <li><i class="icon-cloud-upload icon-2x"></i> icon-cloud-upload</li>
      <li><i class="icon-lightbulb icon-2x"></i> icon-lightbulb</li>
      <li><i class="icon-exchange icon-2x"></i> icon-exchange</li>
      <li><i class="icon-bell-alt icon-2x"></i> icon-bell-alt</li>
      <li><i class="icon-file-alt icon-2x"></i> icon-file-alt</li>
      <li><i class="icon-beer icon-2x"></i> icon-beer</li>
      <li><i class="icon-coffee icon-2x"></i> icon-coffee</li>
      <li><i class="icon-food icon-2x"></i> icon-food</li>
      <li><i class="icon-fighter-jet icon-2x"></i> icon-fighter-jet</li>
    </ul>
  </div>
  <div class="span3">
    <ul class="the-icons">
      <li><i class="icon-user-md icon-2x"></i> icon-user-md</li>
      <li><i class="icon-stethoscope icon-2x"></i> icon-stethoscope</li>
      <li><i class="icon-suitcase icon-2x"></i> icon-suitcase</li>
      <li><i class="icon-building icon-2x"></i> icon-building</li>
      <li><i class="icon-hospital icon-2x"></i> icon-hospital</li>
      <li><i class="icon-ambulance icon-2x"></i> icon-ambulance</li>
      <li><i class="icon-medkit icon-2x"></i> icon-medkit</li>
      <li><i class="icon-h-sign icon-2x"></i> icon-h-sign</li>
      <li><i class="icon-plus-sign-alt icon-2x"></i> icon-plus-sign-alt</li>
      <li><i class="icon-spinner icon-2x"></i> icon-spinner</li>
    </ul>
  </div>
  <div class="span3">
    <ul class="the-icons">
      <li><i class="icon-angle-left icon-2x"></i> icon-angle-left</li>
      <li><i class="icon-angle-right icon-2x"></i> icon-angle-right</li>
      <li><i class="icon-angle-up icon-2x"></i> icon-angle-up</li>
      <li><i class="icon-angle-down icon-2x"></i> icon-angle-down</li>
      <li><i class="icon-double-angle-left icon-2x"></i> icon-double-angle-left</li>
      <li><i class="icon-double-angle-right icon-2x"></i> icon-double-angle-right</li>
      <li><i class="icon-double-angle-up icon-2x"></i> icon-double-angle-up</li>
      <li><i class="icon-double-angle-down icon-2x"></i> icon-double-angle-down</li>
      <li><i class="icon-circle-blank icon-2x"></i> icon-circle-blank</li>
      <li><i class="icon-circle icon-2x"></i> icon-circle</li>
    </ul>
  </div>
  <div class="span3">
    <ul class="the-icons">
      <li><i class="icon-desktop icon-2x"></i> icon-desktop</li>
      <li><i class="icon-laptop icon-2x"></i> icon-laptop</li>
      <li><i class="icon-tablet icon-2x"></i> icon-tablet</li>
      <li><i class="icon-mobile-phone icon-2x"></i> icon-mobile-phone</li>
      <li><i class="icon-quote-left icon-2x"></i> icon-quote-left</li>
      <li><i class="icon-quote-right icon-2x"></i> icon-quote-right</li>
      <li><i class="icon-reply icon-2x"></i> icon-reply</li>
      <li><i class="icon-github-alt icon-2x"></i> icon-github-alt</li>
      <li><i class="icon-folder-close-alt icon-2x"></i> icon-folder-close-alt</li>
      <li><i class="icon-folder-open-alt icon-2x"></i> icon-folder-open-alt</li>
    </ul>
  </div>
</div>
	
</section>
<br><br><br><br>

     <!-- Footer
      ================================================== -->
      <hr>

      <footer id="footer">
        <p class="pull-right"><a href="#top">Back to top</a></p>
        <div class="links">
          <a href="https://github.com/thomaspark/bootswatch/">GitHub</a>
          <a rel="tooltip" href="javascript:(function(e,a,g,h,f,c,b,d)%7Bif(!(f%3De.jQuery)%7C%7Cg%3Ef.fn.jquery%7C%7Ch(f))%7Bc%3Da.createElement(%22script%22)%3Bc.type%3D%22text/javascript%22%3Bc.src%3D%22http://ajax.googleapis.com/ajax/libs/jquery/%22%2Bg%2B%22/jquery.min.js%22%3Bc.onload%3Dc.onreadystatechange%3Dfunction()%7Bif(!b%26%26(!(d%3Dthis.readyState)%7C%7Cd%3D%3D%22loaded%22%7C%7Cd%3D%3D%22complete%22))%7Bh((f%3De.jQuery).noConflict(1),b%3D1)%3Bf(c).remove()%7D%7D%3Ba.documentElement.childNodes%5B0%5D.appendChild(c)%7D%7D)(window,document,%221.3.2%22,function(%24,L)%7Bif(%24(%22.bootswatcher%22)%5B0%5D)%7B%24(%22.bootswatcher%22).remove()%7Delse%7Bvar%20%24e%3D%24(%27%3Cselect%20class%3D%22bootswatcher%22%3E%3Coption%3EAmelia%3C/option%3E%3Coption%3ECerulean%3C/option%3E%3Coption%3ECosmo%3C/option%3E%3Coption%3ECyborg%3C/option%3E%3Coption%3EJournal%3C/option%3E%3Coption%3EReadable%3C/option%3E%3Coption%3ESimplex%3C/option%3E%3Coption%3ESlate%3C/option%3E%3Coption%3ESpacelab%3C/option%3E%3Coption%3ESpruce%3C/option%3E%3Coption%3ESuperhero%3C/option%3E%3Coption%3EUnited%3C/option%3E%3C/select%3E%27)%3Bvar%20l%3D1%2BMath.floor(Math.random()*%24e.children().length)%3B%24e.css(%7B%22z-index%22:%2299999%22,position:%22fixed%22,top:%225px%22,right:%225px%22,opacity:%220.5%22%7D).hover(function()%7B%24(this).css(%22opacity%22,%221%22)%7D,function()%7B%24(this).css(%22opacity%22,%220.5%22)%7D).change(function()%7Bif(!%24(%22link.bootswatcher%22)%5B0%5D)%7B%24(%22head%22).append(%27%3Clink%20rel%3D%22stylesheet%22%20class%3D%22bootswatcher%22%3E%27)%7D%24(%22link.bootswatcher%22).attr(%22href%22,%22http://bootswatch.com/%22%2B%24(this).find(%22:selected%22).text().toLowerCase()%2B%22/bootstrap.min.css%22)%7D).find(%22option:nth-child(%22%2Bl%2B%22)%22).attr(%22selected%22,%22selected%22).end().trigger(%22change%22)%3B%24(%22body%22).append(%24e)%7D%3B%7D)%3B" title="Drag to your bookmarks bar">Bookmarklet</a>
          <a href="https://github.com/thomaspark/bootswatch/tree/gh-pages/swatchmaker">Swatchmaker</a>
          <a href="http://news.bootswatch.com/post/22193315172/bootswatch-api">API</a>
          
        </div>
      </footer>

    </div><!-- /container -->

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="js/jquery.smooth-scroll.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/bootswatch.js"></script>
  </body>
</html>