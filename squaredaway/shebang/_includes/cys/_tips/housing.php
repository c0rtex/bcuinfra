							<table class="spending-table table-lined">
							
								<thead class="table-head">
									<tr>
										<th class="spending-action" colspan="2">Action</th>
										<th class="spending-savings">Savings</th>
									</tr>
								</thead>
	
								<tbody class="table-body y-scroll">
									<tr class="add-todo row-1">
										<td class="checkbox-container">
											<input type="checkbox" name="downsize" value="Downsize your house" class="checkbox-input"></td>
										<td>
											<label for="downsize" class="checkbox-label">
											Downsize your house.</label></td>
										<td class="spending-savings"><span class="dollar">$</span>500</td>							
									</tr>
			
									<tr class="add-todo row-2">
										<td class="checkbox-container">
											<input type="checkbox" name="fsbo" value="Sell your house yourself." class="checkbox-input">
										<td>
											<label for="fsbo" class="checkbox-label">Sell your house yourself.</label></td>
										<td class="spending-savings"><span class="dollar">$</span>425</td>
									</tr>
			
									<tr class="add-todo row-3">
										<td class="checkbox-container">
											<input type="checkbox" name="refinance" value="Refinance your mortgage." class="checkbox-input"></td>
										<td>
										<label for="refinance" class="checkbox-label">Refinance your mortgage.</label></td>
										<td class="spending-savings"><span class="dollar">$</span>200</td>							
									</tr>

									<tr class="add-todo row-4">
										<td class="checkbox-container">
											<input type="checkbox" name="roommate" value="Get a roommate and share expenses. " class="checkbox-input"></td>
										<td>
										<label for="roommate" class="checkbox-label">Get a roommate and share expenses.</label></td>
										<td class="spending-savings"><span class="dollar">$</span>80</td>							
									</tr>
									
									<tr class="add-todo row-5">
										<td class="checkbox-container">
											<input type="checkbox" name="deductible" value="Raise the deductible on your homeowner's and car insurance policies. " class="checkbox-input"></td>
										<td>
										<label for="deductible" class="checkbox-label">Raise the deductible on your homeowner's and car insurance policies.</label></td>
										<td class="spending-savings"><span class="dollar">$</span>200</td>							
									</tr>
									
			
									<?php
										include('blank-tr.php');
									?>
			
			
<!--
									<tr class="add-todo spending-row blank hidden" contenteditable="true">
										<td class="checkbox-container">
											<input type="checkbox" name="custom" value="Skip one flight per year" class="checkbox-input"></td>
										<td>
										<label for="custom" class="checkbox-label">Skip one flight per year.</label></td>
										<td class="spending-savings"><span class="dollar">$</span>33</td>														</tr>
-->

								</tbody> <!-- y-scroll -->
							</table>