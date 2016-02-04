use DBI;
$dbh = DBI->connect('DBI:mysql:bcumigration;host=172.31.33.35', 'bcuuser', 'ChasaDusputUf2Ec',
	            { RaiseError => 1 }
	           ) || die "Could not connect to database: $DBI::errstr";

# (insert query examples here...)
#$dbh->disconnect();





# update table county
COUNTY: print "UPDATING data in COUNTY\n";
# $data->Sql("SELECT COUNT(*) AS c FROM county WHERE valid=0");
# $data->FetchRow;
# print "Rows invalid: ".$data->Data('c')."\n\n";
$dbh->do('UPDATE county SET valid=0');
$countyCount = 0;
$changeCount = 0;
$sth = $dbh->prepare("SELECT 5DigitFIPSCounty AS county_id, State as state_id, County FROM ExCounties ORDER BY State, County");
$sth->execute();
my %row;
  $sth->bind_columns( \( @row{ @{$sth->{NAME_lc} } } ));
  while ($sth->fetch) {

	$sth2 = $dbh->prepare("SELECT * from county WHERE county_id".sql_where_escape($row{county_id})." AND state_id".sql_where_escape($row{state_id})." AND county_name".sql_where_escape($row{county}));
	$sth2->execute();
	my %nextrow;
  	$sth2->bind_columns( \( @nextrow{ @{$sth2->{NAME_lc} } } ));
	if ($sth2->rows > 0) {
		$dbh->do("UPDATE county SET valid=1 WHERE county_id".sql_where_escape($row{county_id}));
	} else {
		$dbh->do("DELETE FROM county WHERE county_id".sql_where_escape($row{county_id}));
		$dbh->do("INSERT INTO county (county_id, state_id, county_name, valid) VALUES (".sql_escape($row{county_id}).", ".sql_escape($row{state_id}).", ".sql_escape($row{county}).", 1)");
		print sql_escape($row{county_id}).", ".sql_escape($row{state_id}).", ".sql_escape($row{county})."\n";
		$changeCount++;
	}
	$countyCount++;
}
#$data->Sql("SELECT COUNT(*) AS c FROM county WHERE valid=0");
#$data->FetchRow;
print "\nRows checked: $countyCount\n";
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
