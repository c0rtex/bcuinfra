@extends('layouts.white-label-main')

@section('main')
<div class="container resources">
  <h1>Welcome to the Partner Login Page</h1>
  <div class="card">
    <div class="card-nested">

      <p>This feature is available to BenefitsCheckUp® private label users and grantees of the Center for Benefits Access. Log into this page to access statistical reports about your screening and application activities, and to access additional outreach materials.</p>


      <form class="login-form">
        <div class="form-group">
          <label>Username</label>
          <input class="form-control" type="text" />
        </div>

        <div class="form-group">
          <label>Password</label>
          <input class="form-control" type="text" />
        </div>

        <button type="submit" class="btn btn-primary">Login</button>
      </form>

      <p><strong>BenefitsCheckUp® Private Label</strong></p>
      <p>BenefitsCheckUp® offers a Private Label version of their website, including a customized version of BenefitsCheckUp® with your organization’s logo, picture, and web address, along with key statistical reports.</p>
      <p>If you are interested in purchasing a Private Label for your organization, please contact Customer Support at: <a href="mailto:support@benefitscheckup.org">support@benefitscheckup.org</a>.</p>
      <p><strong>Questions or problems logging in?</strong></p>
      <p>Please contact Customer Support at: <a href="mailto:support@benefitscheckup.org">support@benefitscheckup.org</a> if you have encounter any difficulties logging into the page or have questions about how to use the tool.</p>
    </div>
  </div>
</div><!--/.container-->
@stop
