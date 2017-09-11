@extends('layouts.white-label-main')

@section('main')

<script>
  window.becs = JSON.parse('{{$grantees}}');
</script>

<div ng-controller="becsController" class="white-wrapper">
    <div class="container resources container--small">

      <section class="white-label-landing">
        <header class="white-label-landing__header">
          <h1>Welcome to BenefitsCheckUp</h1>
          <p class="subtitle">Select your state and Benefits Enrollment Center below to proceed.</p>
        </header>
  
        <form class="white-label-landing__form" action="/" method="get">
          <div class="form-item">
            <label>Select Your State</label>
            <select id="white-label-landing-select-state" class="form-control" ng-model="state">
              <option selected="selected" value="choose">-- choose an option --</option>
              <option value="alabama" >Alabama</option>
            </select>
          </div>

          <div class="white-label-landing__form-then">then</div>

          <div class="form-item form-item-white-label-organization disabled">
            <label>Select Your Organization</label>
            <select id="white-label-landing-select-organization" class="form-control" disabled>
              <option selected="selected" value="choose">-- choose an option --</option>
              <option>Feeding the Gulf Coast</option>
            </select>
          </div>

          <div class="form-item form-item-white-label-submit disabled">
            <input type="submit" value="Enter" class="btn btn-primary" ng-click="goToBeck()" />
          </div>
        </form>

        <footer class="white-label-landing__footer">
          <p>Not using a Benefits Enrollment Center?</p>
          <p><a href="">Visit benefitscheckup.org</a></p>
        </footer>

      </section>

    </div><!--/.container-->
  </div><!--/.white-wrapper-->
@stop
