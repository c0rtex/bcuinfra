<div style="page-break-before: always;">
<?php $programUrl = trim(Meta::get(Loop::id(), $key = 'program-url', $single = true)); ?>
@extends('layouts.print')

@section('main')
@query(['post_type' => 'fact-sheets', 'posts_per_page' => 3, 'name' => $page_slug])

<div class="container">


    <!-- Desktop -->
    <div class="row">
        <div class="col-xs-12">
            <!-- Views -->
            <div>
                <div class="fact-sheets-header fact-sheets-top-header">{{ Meta::get(Loop::id(), $key = 'fact-sheet-category', $single = true) }}</div>
                <div class="fact-sheets-header fact-sheets-bottom-header">{{ Loop::title() }}</div>
            </div>
            <div class="clearfix"></div>
            <hr class="fact-sheets-hr" />

            <div id="factsheetContent">
                {{ Loop::content() }}
            </div>

            @if($is_alt)
            {{ Meta::get(Loop::id(), $key = 'requirement-info-alt', $single = true) }}
            @endif

            <p>&nbsp;</p>
            <p class="text-center">&copy; {{ date('Y') }} National Council on Aging. All Rights Reserved.</p>
        </div>
    </div>
</div>
@endquery
@stop
</div>