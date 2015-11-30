<cfsilent>
<cfparam name="attributes.sproc" type="string">
<cfparam name="attributes.source" type="string">
<cfparam name="attributes.drop" type="boolean" default="false">

<cfif attributes.drop>
	<cfquery name="dropsproc" datasource="#attributes.source#">
		DROP PROCEDURE `#attributes.sproc#`
	</cfquery>
</cfif>

<cfswitch expression="#attributes.sproc#">
	<cfcase value="screening_insert">
		<cfquery name="createsproc" datasource="#attributes.source#">
DELIMITER $$

CREATE PROCEDURE screening_insert(
	in prev_screening_id int,
	in cfid bigint,
	in cftoken bigint,
	in source_id int,
	in org_id int,
	in partner_id int,
	in subset_id int,
	in language_id char(2),
	in access_id int,
	in client_id varchar(64),
	in user_id varchar(64),
	in preset_state_id char(2),
	in test_flag tinyint,
	in start_datetime datetime,
	in end_datetime datetime,
	out screening_id int) 
BEGIN
	INSERT INTO screening 
		(prev_screening_id, cfid, cftoken, source_id, org_id, partner_id, subset_id, language_id, access_id,
			client_id, user_id, preset_state_id, test_flag, start_datetime, end_datetime)
	VALUES
		(prev_screening_id, cfid, cftoken, source_id, org_id, partner_id, subset_id, language_id, access_id,
			client_id, user_id, preset_state_id, test_flag, start_datetime, end_datetime);
	SET screening_id=LAST_INSERT_ID();
END$$
DELIMITER ;
		</cfquery>
	</cfcase>

	<cfcase value="sequence">
		<cfquery name="createsproc" datasource="#attributes.source#">
DELIMITER $$
CREATE PROCEDURE sequence(
	 in seqname varchar(255),
	 out newkey numeric(18, 0) 
   )  
begin 
	DECLARE lastkey decimal(18, 0);
  START TRANSACTION;
    
	SET lastkey = (select nextkey from tbl_nextkey where tablename=seqname);
    
	if lastkey is null then
	
		set lastkey=0;
		insert into tbl_nextkey (tablename, nextkey) values (seqname, 0);
	end if;
	set newkey=lastkey + 1;
	update tbl_nextkey set nextkey= newkey where tablename= seqname;
commit;
end$$
DELIMITER ;
		</cfquery>
	</cfcase>

	<cfcase value="sp_NextKey">
		<cfquery name="createsproc" datasource="#attributes.source#">
DELIMITER $$
CREATE PROCEDURE sp_NextKey(
	out newkey numeric(18, 0)
)
begin 
  declare lastkey decimal(18, 0);
  start transaction;
	set lastkey = (select nextkey from tbl_nextkey where tablename='tbl_user_info');
	if lastkey=0 then
		set lastkey = (select max(clientNum) from tbl_user_info);
		if lastkey is null then
			insert into tbl_user_info (user_name) values ('keygen');
			set lastkey=(select max(clientNum) from tbl_user_info);
		end if;
	end if;
	set newkey = lastkey + 1;
	update tbl_nextkey set nextkey= newkey where tablename='tbl_user_info';
commit;
end$$
DELIMITER ;
		</cfquery>
	</cfcase>

	<cfcase value="sp_ZipRad">
		<cfquery name="createsproc" datasource="#attributes.source#">
DELIMITER $$
CREATE  PROCEDURE sp_ZipRad
(
  prm_zip int, 
  prm_radius int,
  prm_ClientNum int
)
begin

/* Local Vars*/
DECLARE lv_Lat float;
DECLARE lv_Lon float;

SET  prm_zip = 100; 
SET  prm_radius = 100;
SET  prm_ClientNum = 0;

start transaction;

/* First, we remove any existing recs for this client */
DELETE FROM tbl_user_zips WHERE ClientNum = prm_ClientNum;


/*Next, we get all of the zip code recs for this user, by proximity */
/* 
KEEP THESE--WE MAY USE THEM LATER
declare prm_zip_list varchar(8000)
declare @City_list varchar(8000)
declare @state_list varchar(8000)
declare @miles_list varchar(8000)
declare @county_list varchar(8000)
declare @areacode_list varchar(8000) 
declare @city_dtl varchar(8000)
*/

IF (prm_zip) < 1 THEN
  SET prm_zip = 210;
END IF;

/*
<!--- DO WE NEED THESE?
These appear to be used to select a zip within a range, if the passed zip doesn't exist--
we'll add them in later. 
declare prm_zip1a int
declare prm_zip1b int
SELECT prm_zip1a = prm_zip1
SELECT prm_zip1b = prm_zip1 + 700
*/

/*SELECT 
	lv_Lat = z.Lat, 
	lv_Lon = z.Lon
FROM tbl_zip z WHERE CAST(z.Zip as int) = prm_zip ORDER BY z.Zip;*/

set lv_Lat = (SELECT z.Lat	FROM tbl_zip z WHERE z.Zip = prm_zip ORDER BY z.Zip);


CREATE TEMPORARY TABLE IF NOT EXISTS TempZip_tmp 
(zip int primary key, lat float, lon float);

INSERT INTO TempZip_tmp
SELECT 
	z.Zip, z.Lat, z.Lon
FROM tbl_zip z
WHERE (z.Lat >= lv_Lat - (prm_radius * 0.0005)) 
AND (z.Lat <= lv_Lat + (prm_radius * 0.0005))  
AND (z.Lon >= lv_Lon - (prm_radius * 0.0005))
AND (z.Lon <= lv_Lon + (prm_radius * 0.0005))
ORDER BY z.Zip;

/* 
DECLARE @formula float
This was @formula: (SIN(lv_Lat)*SIN(@zlat)+COS(lv_Lat)* COS(@zlat)*COS(@zlon-lv_Lon)) 
*/

INSERT INTO tbl_user_zips
SELECT 	prm_ClientNum AS ClientNum,
	z.Zip AS Zip,
	CASE 
	  WHEN z.Zip = prm_zip THEN 0.001
  	WHEN z.Lat = lv_Lat THEN 0.001
  	WHEN z.Lon = lv_Lon THEN 0.001
  	WHEN (SIN(lv_Lat)*SIN(z.lat)+COS(lv_Lat)* COS(z.lat)*COS(z.lon-lv_Lon)) = 1 THEN 0.001
  	ELSE (3963 * (ATAN(-(SIN(lv_Lat)*SIN(z.lat)+COS(lv_Lat)* COS(z.lat)*COS(z.lon-lv_Lon)) / SQRT(-(SIN(lv_Lat)*SIN(z.lat)+COS(lv_Lat)* COS(z.lat)*COS(z.lon-lv_Lon)) * (SIN(lv_Lat)*SIN(z.lat)+COS(lv_Lat)* COS(z.lat)*COS(z.lon-lv_Lon)) + 1)) + 2 * ATAN(1)))
	END 
	AS Miles,
	now() AS DateCreated
FROM TempZip_tmp z;

/* DEBUG OUTPUT
select * 
from tbl_user_zips 
where ClientNum = prm_ClientNum
order by miles
*/
COMMIT;
END$$
DELIMITER ;

		</cfquery>
	</cfcase>
</cfswitch>
</cfsilent>