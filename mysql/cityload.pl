use DBI;
$dbh = DBI->connect('DBI:mysql:bcumigration;host=172.31.33.35', 'bcuuser', 'ChasaDusputUf2Ec',
	            { RaiseError => 1 }
	           ) || die "Could not connect to database: $DBI::errstr";

# (insert query examples here...)
#$dbh->disconnect();

# update table city

CITY: print "UPDATING data in CITY\n";
#$data->Sql("SELECT COUNT(*) AS c FROM city WHERE valid=0");
#$data->FetchRow;
#print "Rows invalid: ".$data->Data('c')."\n\n";
$dbh->do("UPDATE city SET valid=0 WHERE state_id NOT IN ('AA', 'AE', 'AP')");
$cityCount = 0;
$changeCount = 0;
$sth = $dbh->prepare("SELECT DISTINCT CityStateKey as cid, State as sid, City as name FROM EXCityDetail WHERE USPSOriginal = 1 ORDER BY State, City, CityStateKey");
$sth->execute();
my %row;
  $sth->bind_columns( \( @row{ @{$sth->{NAME_lc} } } ));
  while ($sth->fetch) {
	$sth2 = $dbh->prepare("SELECT * FROM city WHERE city_id".sql_where_escape($row{cid})." AND state_id".sql_where_escape($row{sid})." AND city_name".sql_where_escape($row{name}));
	$sth2->execute();
	my %nextrow;
  	$sth2->bind_columns( \( @nextrow{ @{$sth2->{NAME_lc} } } ));
	if ($sth2->rows > 0) {
		$dbh->do("UPDATE city SET valid=1 WHERE city_id".sql_where_escape($row{cid}));
	} else {
		$dbh->do("DELETE FROM city WHERE city_id".sql_where_escape($row{cid}));
		$dbh->do("INSERT INTO city (city_id, state_id, city_name, valid, exclude_flag) VALUES (".sql_escape($row{cid}).", ".sql_escape($row{sid}).", ".sql_escape($row{name}).", 1, 0)");
		print sql_escape($row{cid}).", ".sql_escape($row{sid}).", ".sql_escape($row{name})."\n";
		$changeCount++;
	}
	$cityCount++;
}
#$data->Sql("SELECT COUNT(*) AS c FROM [BudJay_MH].[dbo].[city] WHERE valid=0");
#$data->FetchRow;
print "\nRows checked: $cityCount\n";
print "Rows added or updated: $changeCount\n";
#print "Rows invalid: ".$data->Data('c')."\n\n";



# update table city_zip
CITYZIP: print "UPDATING data in CITY_ZIP\n";
#$data->Sql("SELECT COUNT(*) AS c FROM [BudJay_MH].[dbo].[city_zip]");
#$data->FetchRow;
#print "Rows: ".$data->Data('c')."\n\n";
$dbh->do("UPDATE city_zip SET valid=0");
$cityzipCount = 0;
$postalCount = 0;
$sth = $dbh->prepare("select distinct CityStateKey as cid, Zip, PrefLastLineCityStateKey as pid from EXCityDetail where USPSOriginal = 1 
union select CONCAT_WS('M',State,CityStateName) as cid, Zip, CONCAT_WS('M',State,CityStateName) as pid from ExMilitary 
order by cid, Zip");
$sth->execute();
my %row;
  $sth->bind_columns( \( @row{ @{$sth->{NAME_lc} } } ));
  while ($sth->fetch) {
	if ($row{cid} eq $row{pid}) {
		$zpid = 'NULL';
	} else {
		$zpid = sql_escape($row{pid});
		$postalCount++;
	}
	$sth2 = $dbh->prepare("SELECT * from city_zip WHERE city_id".sql_where_escape($row{cid})." AND zipcode".sql_where_escape($row{zip}));
	$sth2->execute();
	my %nextrow;
  	$sth2->bind_columns( \( @nextrow{ @{$sth2->{NAME_lc} } } ));
	if ($sth2->rows > 0) {
		$dbh->do("UPDATE city_zip SET postal_city_id=$zpid, valid=1 WHERE city_id".sql_where_escape($row{cid})." AND zipcode".sql_where_escape($row{zip}));
		#print sql_escape($cid).", ".sql_escape($zip).", $zpid, 1\n";
	} else {
		$dbh->do("INSERT INTO city_zip (city_id, zipcode, postal_city_id, valid) VALUES (".sql_escape($row{cid}).", ".sql_escape($row{zip}).", $zpid, 1)");
		#print sql_escape($row{cid}).", ".sql_escape($row{zip}).", $zpid, 1\n";
	}
	$cityzipCount++;
}
$dbh->do("DELETE FROM city_zip WHERE valid=0");
#$data->Sql("SELECT COUNT(*) AS c FROM city_zip");
#$data->FetchRow;
print "\nRows added: $cityzipCount\n";
print "Rows with diff post: $postalCount\n";
#print "Rows: ".$data->Data('c')."\n\n";



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
