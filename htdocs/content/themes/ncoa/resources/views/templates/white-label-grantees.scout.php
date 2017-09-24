@extends('layouts.white-label-main')

@section('main')
<div class="container resources" ng-controller="granteesController">
  <h1>Grantees</h1>
  <div class="card">
    <div class="card-nested">

      <h2 class="page-header">View a List of our Grantee Organizations</h2>

      <p>The following Grantees have been selected to implement Benefits Enrollment Centers that use person-centered strategies in a coordinated, community-wide approach.</p>

      <form class="form-center form-inline state-selection" method="POST" accept-charset="UTF-8">   
        <div class="form-group">
          <label for="state-selection">Find Your State</label>
          <select class="form-control" name="state-selection" id="state-selection" ng-model="state" ng-change="stateChange()">
            <option value="">-- choose an option --</option>
            @foreach ($states as $state_code => $state)
            <option value="{{ $state_code }}">{{ $state }}</option>
            @endforeach
          </select>
        </div>
      </form>

      <ul class="grant-list">
        @foreach ($states as $state_code => $state)
        <li id="grantee-{{ $state_code }}">
          <div><strong>{{ $state }}</strong></div>
          <ul>
            @foreach ($grantees[$state_code] as $grantee)
            <li><a href="{{ $grantee['url'] }}">{{ $grantee['title']}}</a></li>
            @endforeach
          </ul>
        </li>
        @endforeach
      </ul>
    </div>
  </div>
</div><!--/.container-->
@stop
