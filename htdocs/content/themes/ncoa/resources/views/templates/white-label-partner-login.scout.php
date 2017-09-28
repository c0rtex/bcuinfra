@extends('layouts.white-label-main')

@section('main')
<div class="container resources">
  <h1>Welcome to the Partner Login Page</h1>
  <div class="card">
    <div class="card-nested">

      <p>This feature is available to BenefitsCheckUp&reg; private label users and grantees of the Center for Benefits Access. Log into this page to access statistical reports about your screening and application activities. You can also access additional outreach materials.</p>


      <form class="login-form" action="https://oe.benefitscheckup.org/oe/signin.do" method="post" name="loginForm">
        <div class="form-group">
          <label>Username</label>
          <input class="form-control" name="userLogin" type="text" />
        </div>

        <div class="form-group">
          <label>Password</label>
          <input class="form-control" name="password" type="text" />
        </div>

        <button type="submit"  class="btn btn-primary">Login</button>
      </form>

      <p><strong>Questions or problems logging in?</strong></p>
      <p>Please contact Customer Support at: <a href="mailto:support@benefitscheckup.org">support@benefitscheckup.org</a>, if you have encountered any difficulties logging into the page or have questions about how to use the tool.</p>
    </div>
  </div>
</div><!--/.container-->
@stop
