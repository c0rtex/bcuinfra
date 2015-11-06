				<div id="sidebar1" class="sidebar hidden-print affix" role="complementary">

					<?php if ( is_active_sidebar( 'sidebar1' ) ) : ?>

						<?php dynamic_sidebar( 'sidebar1' ); ?>

					<?php else : ?>

						<!-- This content shows up if there are no widgets defined in the backend. -->
						
						<div class="alert help">
							<p>Activate some widgets</p>
						</div>

					<?php endif; ?>

				</div>