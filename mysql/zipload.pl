use DBI;
$dbh = DBI->connect('DBI:mysql:bcumigration;host=172.31.33.35', 'bcuuser', 'ChasaDusputUf2Ec',
	            { RaiseError => 1 }
	           ) || die "Could not connect to database: $DBI::errstr";

# (insert query examples here...)
#$dbh->disconnect();


# load tbl_zip
print "TRANSFERRING data to TBL_ZIP\n";
$zipCount = 0;
$dbh->do("DELETE FROM tbl_zip");
$sth = $dbh->prepare("SELECT ID, Detail, Zip, CountofCity, CityStName, LastLineCity, State, County, LatDeg, LonDeg, LatRad, LonRad, AreaCode, TimeZone, H, V, FromCensus FROM EXJcsZip ORDER BY Zip");
$sth->execute();
my %row;
  $sth->bind_columns( \( @row{ @{$sth->{NAME_lc} } } ));
  while ($sth->fetch) {
	$zipCount++;
	$dbh->do("INSERT INTO tbl_zip (ID, Detail, Zip, CountofCity, CityStName, LastLineCity, State, County, Lat_degree, Lon_degree, Lat, Lon, AreaCode, TimeZone, H, V, FromCensus) VALUES ($row{id},'D',".sql_escape($row{zip}).",$row{countofcity},".sql_escape($row{citystname}).",".sql_escape($row{lastlinecity}).",".sql_escape($row{state}).",".sql_escape($row{county}).", $row{latdeg}, $row{londeg}, $row{latrad}, $row{lonrad},$row{areacode}, $row{timezone}, $row{h}, $row{v}, $row{fromcensus})");
	if ($dbh->rows() == 0) {
		print "$id, ".sql_escape($row{detail}).", ".sql_escape($row{zip}).", $count, ".sql_escape($row{city}).", ".sql_escape($row{last}).", ".sql_escape($row{state}).", ".sql_escape($row{county}).",$row{latdeg}, $row{londeg}, $row{latrad}, $row{lonrad}, ".sql_escape($row{area}).", ".sql_escape($row{time}).", $row{h}, $row{v}, $row{from}\n";
	}
	
}
print "\n";
print "Rows: $zipCount\n\n";


# update table zip
ZIP: print "UPDATING data in ZIP\n";
#$data->Sql("SELECT COUNT(*) AS c FROM zip WHERE valid=0");
#$data->FetchRow;
#print "Rows invalid: ".$data->Data('c')."\n\n";
$dbh->do('UPDATE zip SET valid=0');
$zipCount = 0;
$changeCount = 0;
$sth = $dbh->prepare("SELECT Zip, State, 5DigitFIPSCounty as county_id, LatRad, LonRad FROM EXJcsZip UNION SELECT Zip, State, '' AS county_id, '' AS LatRad, '' AS LonRad FROM ExMilitary ORDER BY Zip");
$sth->execute();
my %row;
  $sth->bind_columns( \( @row{ @{$sth->{NAME_lc} } } ));
  while ($sth->fetch) {
	$sth2 = $dbh->prepare("SELECT * from zip WHERE zipcode".sql_where_escape($row{zip})." AND state_id".sql_where_escape($row{state})." AND county_id".sql_where_escape($row{county_id})." AND latitude".null_where_escape($row{latrad})." AND longitude".null_where_escape($row{lonrad}));
	$sth2->execute();
	my %nextrow;
  	$sth2->bind_columns( \( @nextrow{ @{$sth2->{NAME_lc} } } ));
	if ($sth2->rows > 0) {
		$dbh->do("UPDATE zip SET valid=1 WHERE zipcode".sql_where_escape($row{zip}));
		#print sql_escape($row{zip}).", ".sql_escape($row{state}).", ".sql_escape($row{county}).", ".null_escape($row{latrad}).", ".null_escape($row{lonrad})."\n";
		print "Valid Zip - rowcheck equals ".$sth2->rows."\n\n";
	} else {
		print "Not Valid Zip - SELECT * from zip WHERE zipcode".sql_where_escape($row{zip})." AND state_id".sql_where_escape($row{state})." AND county_id".sql_where_escape($row{county_id})." AND latitude".null_where_escape($row{latrad})." AND longitude".null_where_escape($row{lonrad})."\n\n";
		#print "Not Valid Zip - rowcheck equals ".$sth2->rows."\n\n";
		$dbh->do("DELETE FROM zip WHERE zipcode".sql_where_escape($row{zip}));
		$dbh->do("INSERT INTO zip (zipcode, state_id, county_id, latitude, longitude, valid) VALUES (".sql_escape($row{zip}).", ".sql_escape($row{state}).", ".sql_escape($row{county_id}).", ".null_escape($row{latrad}).", ".null_escape($row{lonrad}).", 1)");
		#print sql_escape($row{zip}).", ".sql_escape($row{state}).", ".sql_escape($row{county}).", ".null_escape($row{latrad}).", ".null_escape($row{lonrad})."\n";
		$changeCount++;
	}
	$zipCount++;
}
#$data->Sql("SELECT COUNT(*) AS c FROM zip WHERE valid=0");
#$data->FetchRow;
print "\nRows checked: $zipCount\n";
print "Rows added or updated: $changeCount\n";
#print "Rows invalid: ".$data->Data('c')."\n\n";


sub sql_escape {
	($esc_text) = @_;
	if ($esc_text eq '') {
		$esc_text = 'NULL';
	} else {
		$esc_text = "'".apos_escape($esc_text)."'";
	}
	return $esc_text;
}

sub null_escape {
	($ne_text) = @_;
	if ($ne_text eq '') {
		$ne_text = 'NULL';
	}
	return $ne_text;
}

sub apos_escape {
	($ap_text) = @_;
	$ap_text =~ s/\'/\'\'/g;
	return $ap_text;
}

sub sql_where_escape {
	($esc_text) = @_;
	if ($esc_text eq '') {
		$esc_text = ' IS NULL';
	} else {
		$esc_text = "='".apos_escape($esc_text)."'";
	}
	return $esc_text;
}

sub null_where_escape {
	($nee_text) = @_;
	if ($nee_text eq '') {
		$nee_text = ' IS NULL';
	} else {
		$nee_text = "=$nee_text";
	}
	return $nee_text;
}
