<cfinclude template="mockupplheader_3.cfm">
<!--end header -->


<div class="span6"><ul class="breadcrumb">
        <li><a href="https://esidtc.benefitscheckup.org/cf/mockup_esi_afc_intropage.cfm">Home</a> <class="divider">/</li>
        <li><a href="https://esidtc.benefitscheckup.org/cf/mockup_esi_afc_intropage.cfm">Application Forms Center</a> <class="divider">/</li>
        <li class="active">Search</li>
      </ul></div>
      
<!--start table -->
      
<div class="span11" > 
  <div class="row well"> 
  <section id="tables" >
  
  <div class="page-header"  >
  <legend><i class="icon-file-alt "></i>  Application Forms Center</legend>
  
  <!--start search bar-->
  
  <div class="navbar" >
    <div class="navbar-inner" >
      <div class="container" style="width: auto;" >
        <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"></a>
        <a class="brand" href="#"></a>
        <div class="nav-collapse">
          <ul class="nav">
            <li class="active"><a href="#">Home</a></li>
            <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Search By <b class="caret"></b></a>
              <ul class="dropdown-menu">
              	<li><a href="#">Drug</a></li>
                <li><a href="#">Category</a></li>
                <li><a href="#">State</a></li>
                <li><a href="#">Date</a></li>
              </ul>
            </li>
          </ul>
          <form class="navbar-search pull-left" action="">
          <input type="text" class="search-query" placeholder="Search">
          </form>
          <ul class="nav pull-right">
            <li><a href="#"></a></li>
            <li class="divider-vertical"></li>
            <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Need Help? <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#">How To Use</a></li>
                <li><a href="#">About</a></li>
                <li><a href="#">FAQs</a></li>
                <li class="divider"></li>
                <li><a href="#">Contact Us</a></li>
              </ul>
            </li>
          </ul>
        </div><!-- /.nav-collapse -->
    </div><!-- /navbar-inner -->
  </div><!--end search bar-->
  
  <!--start search by date results-->
  
       

<section >  
  <div >
  <table class="table table-bordered table-striped table-hover">
    <h5><i class="icon-fixed-width"></i><span class="muted"></span>  Search Results By Date</h5>
    <thead>      
      <tr>
        <th>#</th>
        <th>Program Name</th>
        <th>Application Name</th>
        <th>State</th>
        <th>Revision Date</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td><a data-toggle="modal" role="button" href="#printablequestions">Printable PDF  </a><i class="icon-file-alt"></i>  Abbott Laboratories Patient Assistance Program</td>
        <td>Fillable! Application Form in English</td>
        <td>All</td>
        <td>07/01/11</td>
      </tr>
      <tr>
        <td>2</td>
        <td><a data-toggle="modal" role="button" href="#printablequestions">Printable PDF  </a><i class="icon-file-alt"></i>  Abbott Laboratories Patient Assistance Program</td>
        <td>Instructions in English</td>
        <td>All</td>
        <td>n/a</td>
      </tr>
      <tr>
        <td>3</td>
        <td><a data-toggle="modal" role="button" href="#printablequestions">Printable PDF  </a><i class="icon-file-alt"></i>  The Abbott Medical Nutrition Products Patient Assistance Program</td>
        <td>Fillable! Application Form in English</td>
        <td>All</td>
        <td>11/01/11</td>
      </tr>
       <tr>
        <td>4</td>
        <td><a data-toggle="modal" role="button" href="#printablequestions">Printable PDF  </a><i class="icon-file-alt"></i>  Abbott Patient Assistance Foundation for Marinol</td>
        <td>Fillable! Application Form in English</td>
        <td>All</td>
        <td>10/01/10</td>
      </tr>
       <tr>
        <td>5</td>
        <td><a data-toggle="modal" role="button" href="#printablequestions">Printable PDF  </a><i class="icon-file-alt"></i>  Abbott Patient Assistance Foundation for Zemplar</td>
        <td>Application Form in English</td>
        <td>All</td>
        <td>10/01/10</td>
      </tr>
    </tbody>
  </table>
  </div>
  <!--end search by date results-->
    
<div class="pagination">
        <ul>
          <li><a href="#">←</a></li>
          <li class="active"><a href="#">10</a></li>
          <li class="disabled"><a href="#">...</a></li>
          <li><a href="#">20</a></li>
          <li><a href="#">→</a></li>
        </ul>
  </div> <!--end pagination-->
  <!-- start modal window info-->
  <div id="printablequestions" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Printable Questionnaire</h3>
  </div>
  <div class="modal-body">
    <p>Include Printable PDF here.</p>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
    <button class="btn btn-primary">Save changes</button>
  </div>
</div><!--end modal window infor-->
  </div>
  </div>
  </section>
  </div>
  </div>

<cfinclude template="mockupesifooter.cfm">
  <!--end table -->