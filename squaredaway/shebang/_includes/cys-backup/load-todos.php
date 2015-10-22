<div class="hidden" id="selected-todos">
			<?php
				global $uid;
				$query = "SELECT REPLACE(name, ' ', '') AS 'name', todo_id, amount FROM demo_todos WHERE uid = '$uid' GROUP BY name";
				$res = mysql_query($query);
				while ($row = mysql_fetch_object($res)){
					echo '<div class="user-selected-todo" data-tdid="'.$row->todo_id.'" data-amount="'.$row->amount.'">'.preg_replace("/[^a-zA-Z0-9\s]/", "", strtolower($row->name)).'</div>';
				}
			?>
		</div>	