@extends('layouts.white-label-main')

@section('main')
<div class="container resources">
  <h1>Medicare Rx Extra Help</h1>
  <div class="card">
    <div class="card-nested">
      <div style="margin-bottom: 35px;"><a class="btn btn-primary" href="/cf/lisapp/questions.cfm?subset_id=41&partner_id={{ $_SESSION['partner_id'] }}">Start Your Application</a></div>
      {{ $post->post_content }}
      <div style="margin-top: 35px;"><a class="btn btn-primary" href="/cf/lisapp/questions.cfm?subset_id=41&partner_id={{ $_SESSION['partner_id'] }}">Start Your Application</a></div>
    </div>
  </div>
</div><!--/.container-->
@stop
