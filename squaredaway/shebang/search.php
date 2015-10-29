<?php
/**
 * The template for displaying Search Results pages.
 *
 * @package WordPress
 * @subpackage Boilerplate
 * @since Boilerplate 1.0
 */

get_header(); 

global $query_string;
/*
$query_args = explode("&", $query_string);
$search_query = array();
foreach($query_args as $key => $string) {
	$query_split = explode("=", $string);
	$search_query[$query_split[0]] = urldecode($query_split[1]);
} // foreach

$search_query['post_type'] = array('how-to', 'learn-more', 'planner', 'calculator');

$wp_query = new WP_Query($search_query);
//print_r($wp_query);
*/

require ( $_SERVER['DOCUMENT_ROOT']."/sphinx/api/sphinxapi.php" );

$cl = new SphinxClient();

$q = substr($query_string, 2);

$index = 'test1';

$cl->SetMatchMode ( SPH_MATCH_ANY );

$res = $cl->Query ( $q, $index );

$arr = array();

if ( $res===false ) {
	echo "Query failed: " . $cl->GetLastError() . ".\n";

} else {
   if ( is_array($res["matches"]) ) {
		foreach ( $res["matches"] as $key => $value ) {
			$postobj = get_post_info($key);
			if ($postobj->status == 'publish') {
            if ($postobj->parent === 0) {
               if (array_search($key, $arr) === false) {
                  $arr[] = $key;
               }
            } else {
               if (array_search($postobj->parent, $arr) === false) {
                  $arr[] = $postobj->parent;
               }
            }
         }
		}
	}
}

$query_search = array();
$query_search['post__in'] = $arr;
//$query_search['s'] = $query_string;
//print_r($query_search);

$query_args = explode("&", $query_string);
$search_query = array();
foreach($query_args as $key => $string) {
	$query_split = explode("=", $string);
	$search_query[$query_split[0]] = urldecode($query_split[1]);
} // foreach
$search_query['post_type'] = array('how-to', 'learn-more', 'planner', 'calculator');
//print_r($search_query);
//$wp_query = new WP_Query($query_search);
?>

<section class="search-page-body">
<ul class="article-breadcrumb"><li class="article-bc-item first last"><a href="/">Home</a> > Search</a></li></ul>

				<h1 class="search-h">You Searched For:</h1>  
				<form id="searchform" method="get" action="/index.php">
				   <input id="search" name="s" type="text" class="search-large" placeholder="<?php echo str_replace('%20',' ',$q); ?>" />
            </form>
     <div class="clearfix"></div>
           
          
                <div class="double-line-bottom extra-space"></div>
                
     <section class="search-page col-1">

     <?php 
     //if ( have_posts() ) : 
     if (count($arr) > 0) {
     ?>
         <h2 class="search-h2">
            <span class="search-result-count"><?php echo count($arr); ?></span> results for "<?php echo str_replace('%20',' ',$q); ?>"
         </h2>
				<?php
				/* Run the loop for the search to output the results.
				 * If you want to overload this in a child theme then include a file
				 * called loop-search.php and that will be used instead.
				 */  
				 
				 //get_template_part( 'loop', 'search' );
				?>
				<?php
				   foreach ($arr as $a) {
				      $pi = get_post_info($a);
				      if ($pi->status == 'publish') {
				         include('template-search.php');
				      }
				   }
				?>
   <?php } else { ?>
					<h2>Nothing Found</h2>
					<p>Sorry, but nothing matched your search criteria.</p>
					<?php //get_search_form(); ?>
   <?php } ?>
</section>
<aside class="search-page-aside col-2">

			<!-- For now, don't show filters on Planner page. Do show for Learn More / How-To / Calcs. -->
			<!--
			<section class="aside-filter aside-section">
				<h3 class="aside-h">Sort by Content Type</h3>
				<ul class="square-filters tag-page-square-filters">
					<li class=""><a class="" data-target="topic-sort-all">All</a></li>
					<li class=""><a class="" data-target="topic-sort-everyday-spending">Everyday Spending</a></li>
					<li class=""><a class="" data-target="topic-sort-retirement">Retirement</a></li>
					<li class=""><a class="" data-target="topic-sort-housing">Housing</a></li>
					<li class=""><a class="" data-target="topic-sort-reserves-insurance">Reserves &amp; Insurance</a></li>
					<li class=""><a class="" data-target="topic-sort-wills-records">Wills &amp; Records</a></li>
					
					<li class=""><a class="" data-target="topic-sort-loans">Loans</a></li>
				</ul>
                
                <h3 class="aside-h">Sort by Life Event</h3>
				<ul class="square-filters tag-page-square-filters">
					<li class=""><a class="" data-target="topic-sort-all">All</a></li>
					<li class=""><a class="" data-target="topic-sort-everyday-spending">Everyday Spending</a></li>
					<li class=""><a class="" data-target="topic-sort-retirement">Retirement</a></li>
					<li class=""><a class="" data-target="topic-sort-housing">Housing</a></li>
					<li class=""><a class="" data-target="topic-sort-reserves-insurance">Reserves &amp; Insurance</a></li>
					<li class=""><a class="" data-target="topic-sort-wills-records">Wills &amp; Records</a></li>
					
					<li class=""><a class="" data-target="topic-sort-loans">Loans</a></li>
				</ul>
			</section> 
			-->
		</aside> <!-- /.tool-page-aside -->

</section>
<?php //get_sidebar(); ?>
<?php get_footer(); ?>
