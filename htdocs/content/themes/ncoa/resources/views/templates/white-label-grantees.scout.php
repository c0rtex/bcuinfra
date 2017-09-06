@extends('layouts.white-label-main')

@section('main')
<div class="container resources">
  <h1>Grantees</h1>
  <div class="card">
    <div class="card-nested">

      <h2 class="page-header">View a List of our Grantee Organizations</h2>

      <p>The following Grantees have been selected to implement Benefits Enrollment Centers that use person-centered strategies in a coordinated,  community-wide approach.</p>

      <form class="form-center form-inline state-selection" method="POST" accept-charset="UTF-8">   
        <div class="form-group">
          <label for="state-selection">Find Your State</label>
          <select class="form-control ng-pristine ng-untouched ng-valid ng-empty" name="state-selection" id="state-selection" ng-model="mapState" ng-change="stateChange()" state-selection="">
            <option value="">-- choose an option --</option>
            <option value="/fact-sheets/factsheet_nutrition_al_snap_program/">Alabama</option>
            <option value="/fact-sheets/factsheet_nutrition_ak_snap_program/">Alaska</option>
            <option value="/fact-sheets/factsheet_nutrition_az_snap_program/">Arizona</option>
          </select>
        </div>
      </form>

      <ul class="grant-list">
        <li>
          <div><strong>Alabama</strong></div>
          <ul>
            <li><a href=".">Alabama Aging and Disability Resource Center</a></li>
            <li><a href=".">Feeding the Gulf Coast</a></li>
          </ul>
        </li>
        <li>
          <div><strong>Arizona</strong></div>
          <ul>
            <li><a href=".">Asian Pacific Community in Action</a></li>
            <li><a href=".">Banner Olive Branch Senior Center</a></li>
            <li><a href=".">Pima Council on Aging</a></li>
            <li><a href=".">Western Arizona Council of Governments</a></li>
          </ul>
        </li>
        <li>
          <div><strong>California</strong></div>
          <ul>
            <li><a href=".">Council on Aging (HICAP) of Orange County</a></li>
            <li><a href=".">CSU Chico Research Foundation</a></li>
            <li><a href=".">Family Health Centers of San Diego</a></li>
            <li><a href=".">Felton Institute</a></li>
            <li><a href=".">HICAP for the County of Ventura Area Agency on Aging</a></li>
            <li><a href=".">Mexican American Opportunity Foundation</a></li>
            <li><a href=".">United Cambodian Community</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</div><!--/.container-->
@stop
