<?php 
require_once('_custom/displaycontent.php');
$cleaned_program_desc = str_ireplace('<b>How can this program help me?</b>', '<h4><i class="icon-question-sign "></i> How can this program help me?</h4>', $program_desc);
$cleaned_program_desc = str_ireplace('<b>How can this program help me? </b>', '<h4><i class="icon-question-sign "></i> How can this program help me?</h4>', $cleaned_program_desc);
$cleaned_program_desc = str_ireplace('<b>Can I apply? </b>', '<h4><i class="icon-user "></i> Can I apply? </h4>', $cleaned_program_desc);
$cleaned_program_desc = str_ireplace('<b>Can I apply?</b>', '<h4><i class="icon-user "></i> Can I apply? </h4>', $cleaned_program_desc);
$cleaned_program_desc = str_ireplace('<b>How do I apply?</b>', '<h4><i class="icon-user "></i> How do I apply? </h4>', $cleaned_program_desc);
$cleaned_program_desc = str_ireplace('<b>How do I apply? </b>', '<h4><i class="icon-user "></i> How do I apply? </h4>', $cleaned_program_desc);
$cleaned_program_desc = str_ireplace('[[track|planfind|Medicare Plan Finder]]', '<a href="/cf/redirect.cfm?id=6&amp;tgt=1&amp;partner_id=0" onclick="" target="_blank">Medicare Plan Finder</a>', $cleaned_program_desc);
echo "
<section id='howhelp'>
                        <div class='clearfix'>
                                <p>".$cleaned_program_desc."</p>
                        </div>
";
?>
</section>
