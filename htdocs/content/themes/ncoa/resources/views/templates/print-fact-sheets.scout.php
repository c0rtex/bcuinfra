@query(['post_type' => 'fact-sheets', 'posts_per_page' => 3, 'name' => $page_slug])
<h3>{{ Meta::get(Loop::id(), $key = 'fact-sheet-category', $single = true) }}</h3>
<h1>{{ Loop::title() }}</h1>
@if(!empty($opt_program_desc))
  {{ $post_content }}
@endif
<br>

<h3>Frequently Asked Questions</h3>

<div>

  @if(!empty($faqs_list))
  @foreach($faqs_list as $key => $value)
  @if(strpos($value["answer"], 'entrypoints'))
  @if(!empty($entry_points))
    <?php $entryPointValue= $value ?>
  @endif
  @else
  @if($value["answer"] === 'documents_needed')
    @if(!empty($opt_materials))
      <em>{{ $value["question"] }}</em>
      <p>
        <ul class="fact-sheets-list">
          @if (empty($required_materials))
          <li>There are no required materials needed for this program.</li>
          @else
          @foreach($required_materials as $ekey => $evalue)
          <li>{{$evalue->title}}</li>
          @endforeach
          @endif
        </ul>
      </p>
    @endif
  @else
    <em>{{ $value["question"] }}</em>
    @if ($is_feeding_america &&
    trim(strtolower($value["question"])) == 'who should i contact?')
      <p><strong>{{ $feeding_america_office["full_name"] }}</strong><br />
        {{ $feeding_america_office["address"] }}<br />
        {{ $feeding_america_office["site"] }}</p>
    @else
      <p>{{ $value["answer"] }}</p>
    @endif
  @endif
  @endif
  @endforeach
  @endif
  @if(!empty($entryPointValue))
    @if(!empty($opt_locations))
    <em>{{ $entryPointValue["question"] }}</em>
      @foreach($entry_points as $ekey => $evalue)
      <p>
        {{ $evalue->print_name }}
      </p>
      @endforeach
    @endif
  @endif
  @if(!empty($becs))
    <em>Who can help me to apply?</em>
      <p>
        A Benefits Enrollment Center (BEC) can offer personal, one-on-one assistance to apply for this program. With support from NCOA, the BEC can help you apply for and enroll in all of the benefits you may be missing out on. The following BEC or BECs are available to help you.
      </p>
      @foreach($becs as $ekey => $evalue)
      <p>
        {{ $evalue->print_name }}
      </p>
      @endforeach
  @endif
</div>
@endquery