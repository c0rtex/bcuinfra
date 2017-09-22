@extends('layouts.white-label-main')

@section('main')
<div class="container resources">
  <h1>Medicare Rx Extra Help</h1>
  <div class="card">
    <div class="card-nested">
      <h2 class="page-header">Who Should Enroll</h2>

      <p class="align-center"><strong>If you have Medicare and have limited income and resources, you may be able to get Extra Help paying for your prescription drug costs if:</strong></p>

      <div class="medicare-rx-extra-help-landing">
        <ul>
          <li>Your income is less than $18,090 if single and $24,360 if  married. If you live in Alaska or Hawaii, you may still get help even if your income is higher than these limits.</li>
          <li>You have resources less than $13,820 if single and $27,600 if married.</li>
        </ul>

        <div class="align-center">
          <a class="btn btn-link fact-sheet-button-fwd" href="/medicare-rx-info/">Learn more about the application process</a>
          <br/><br/>
          <a class="btn btn-primary" href="/medicare-rx-extra-help-application-prepare/">Start Your Application</a>
        </div>
      </div>

    </div>
  </div>
</div><!--/.container-->
@stop
