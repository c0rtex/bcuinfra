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
            @foreach ($grantees as $state => $grantees_list)
            <option value="{{ $state }}">{{ $state }}</option>
            @endforeach
          </select>
        </div>
      </form>

      <ul class="grant-list">
        @foreach ($grantees as $state => $grantees_list)
        <li id="grantee-{{ $state }}">
          <div><strong>{{ $state }}</strong></div>
          <ul>
            @foreach ($grantees_list as $grantee)
              @if (!empty($grantee['site-url']))
              <li><a href="{{ $grantee['site-url'] }}" target="_blank">{{ $grantee['name']}}</a></li>
              @else
              <li>{{ $grantee['name']}}</li>
              @endif
            @endforeach
          </ul>
        </li>
        @endforeach
      </ul>
    </div>
  </div>
</div><!--/.container-->
@stop
