@extends('layouts.white-label-main-splash')

@section('main')

<script>
  window.becs = JSON.parse('{{$grantees}}');
</script>

<div ng-controller="becsController" class="white-wrapper">
    <div class="container resources text-center">

      <section class="white-label-landing">
        <header class="white-label-landing__header">
          <h1>Welcome to BenefitsCheckUp&reg;</h1>
          <p class="subtitle">Select your state and Benefits Enrollment Center below to proceed.</p>
        </header>
  
        <form>
          <div class="form-item form-item-white-label-landing-state">
            <label>Select Your State</label>
            <select class="form-control" ng-model="state" ng-options="becsState.value for becsState in becsStates track by becsState.id">
              <option selected="selected" value="">-- choose a state --</option>
            </select>
          </div>

          <div class="white-label-landing__form-then">then</div>

          <div class="form-item form-item-white-label-landing-org">
            <label>Select Your Organization</label>
            <select ng-disabled="!state" class="form-control" ng-model="bec" ng-options="bec.name for bec in becs">
              <option selected="selected" value="">-- choose an option --</option>
            </select>
          </div>

          <div class="form-item form-item-white-label-submit">
            <input type="submit" ng-disabled="!bec" value="Enter" class="btn btn-primary" ng-click="goToBeck()" />
          </div>
        </form>

        <footer class="white-label-landing__footer">
          <p>Not using a Benefits Enrollment Center?</p>
          <p><a href="/">Visit BenefitsCheckUp.org</a></p>
        </footer>

      </section>

    </div><!--/.container-->
  </div><!--/.white-wrapper-->
@stop
