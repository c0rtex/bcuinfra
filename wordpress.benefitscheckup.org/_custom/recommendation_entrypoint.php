<?PHP
	$bcudb = new wpdb('esidtc','W6ApuXec','esidtc','172.31.33.35');
	$bcudb->show_errors();

	$epg_phone = $defaultPhone;
	$epgEpId = 0;
	
	// Get local EPG Office
	if ($entrypointgroup_id == 83){
		$query_epgEP = "select e.entrypoint_id, e.name, e.url, p.number
                                from entrypoint_entrypointgroup eg, entrypoint e, phone p
                                where eg.entrypointgroup_id=$entrypointgroup_id
                                    and eg.entrypoint_id=e.entrypoint_id
                                    and e.state_id in (select state_id from zip where zipcode=$esi_zip)
				    				and e.active_flag=1
                                    and p.entrypoint_id=e.entrypoint_id
                                    and p.phonetype_id = 4 limit 1";
		foreach($epgEp_query as $epgEpObj):
			$epgEpId = $epgEpObj->entrypoint_id;
			$epgEpName = $epgEpObj->name;
			$epgEpUrl = $epgEpObj->url;
			$epgEpNumber = $epgEpObj->number;
		endforeach;
	}
	
	if (($entrypointgroup_id == 286) || ($entrypointgroup_id == 456)) {
		if ($entrypointgroup_id == 286){$epg_phone = "(888)480-1527";}
		if ($entrypointgroup_id == 456){$epg_phone = "(651)641-8612";}
		$query_epgEp = "select e.entrypoint_id, zd.distance,p.number
                                from entrypoint_entrypointgroup eg, entrypoint e, view_zip_distance zd, phone p
                                where eg.entrypointgroup_id=$entrypointgroup_id
                                    and eg.entrypoint_id=e.entrypoint_id
                                    and e.active_flag=1
                                    and e.zipcode=zd.start_zipcode
                                    and zd.end_zipcode=$esi_zip
                                    and zd.distance < 100
                                    and p.entrypoint_id=e.entrypoint_id
                                    and p.phonetype_id = 1
                                union
                                select e.entrypoint_id, 999999 distance,p.number
                                from entrypoint_entrypointgroup eg, entrypoint e,phone p
                                where eg.entrypointgroup_id=$entrypointgroup_id
                                    and eg.entrypoint_id=e.entrypoint_id
                                    and e.active_flag=1
                                    and e.zipcode is null
                                    and e.zipcode=$esi_zip
                                    and p.entrypoint_id=e.entrypoint_id
                                    and p.phonetype_id = 1
                                order by distance limit 1";
		$epgEp_query = $bcudb->get_results($query_epgEp);
		foreach($epgEp_query as $epgEpObj):
			$epgEpId = $epgEpObj->entrypoint_id;
		endforeach;
		$query_getEPGphone = "Select number from phone where entrypoint_id = $epgEpId and phonetype_id = 1 Limit 1";
		$getEPGphone_query = $bcudb->get_results($query_getEPGphone);
		if (count($getEPGphone_query) == 1){
			$epg_phone = $getEPGphone_query->number;
		}
	}
	
	if ($entrypointgroup_id == 1){
		// Proximity Zip search
        $query_epgEp_proximityZip = "select e.entrypoint_id, zd.distance, p.number
                                from entrypoint_entrypointgroup eg, entrypoint_zip ez, entrypoint e, view_zip_distance zd, phone p
                                where eg.entrypointgroup_id=$entrypointgroup_id
                                    and eg.entrypoint_id=ez.entrypoint_id
                                    and ez.zipcode=$esi_zip
                                    and ez.entrypoint_id=e.entrypoint_id
                                    and e.active_flag=1
                                    and e.zipcode=zd.start_zipcode
                                    and zd.end_zipcode=$esi_zip
                                union
                                select e.entrypoint_id, 999999 distance, p.number
                                from entrypoint_entrypointgroup eg, entrypoint e, entrypoint_zip ez, phone p
                                where eg.entrypointgroup_id=$entrypointgroup_id
                                    and eg.entrypoint_id=e.entrypoint_id
                                    and e.active_flag=1
                                    and e.zipcode is null
                                    and e.entrypoint_id=ez.entrypoint_id
                                    and ez.zipcode=$esi_zip
                                order by distance LIMIT 1";
		$epgEp_proximityZip_query = $bcudb->get_results($query_epgEp_proximityZip);
		foreach($epgEp_proximityZip_query as $epgEpObj):
			$epgEpId = $epgEpObj->entrypoint_id;
		endforeach;						
		
     	// Proximity County search
        if (count($epgEp_proximityZip_query) == 0) {
			$query_epgEp_proximityCounty = "select e.entrypoint_id, zd.distance, p.number
                                    from entrypoint_entrypointgroup eg, entrypoint_county ec, entrypoint e, view_zip_distance zd, phone p
                                    where eg.entrypointgroup_id=$entrypointgroup_id
                                        and eg.entrypoint_id=ec.entrypoint_id
                                        and ec.county_id in (select county_id from zip where zipcode=$esi_zip)
                                        and ec.entrypoint_id=e.entrypoint_id
                                        and e.active_flag=1
                                        and e.zipcode=zd.start_zipcode
                                        and zd.end_zipcode=$esi_zip
                                    UNION
                                    select e.entrypoint_id, 999999 distance, p.number
                                    from entrypoint_entrypointgroup eg, entrypoint e, entrypoint_county ec, phone p
                                    where eg.entrypointgroup_id=$entrypointgroup_id
                                        and eg.entrypoint_id=e.entrypoint_id
                                        and e.active_flag=1
                                        and e.zipcode is null
                                        and e.entrypoint_id=ec.entrypoint_id
                                        and ec.county_id in (select county_id from zip where zipcode=$esi_zip)
                                    order by distance LIMIT 1";
 			$epgEp_proximityCounty_query = $bcudb->get_results($query_epgEp_proximityCounty);						
			foreach($epgEp_proximityCounty_query as $epgEpObj):
				$epgEpId = $epgEpObj->entrypoint_id;
			endforeach;
		}
		// Proximity Radius search. Custom solution for issues with IL Counties Cook and Lake where zips exist cross county
		if(count($epgEp_proximityCounty_query == 0)){
        	$query_epgEp_proximityRadius = "select e.entrypoint_id, p.number
                                    from entrypoint_entrypointgroup eg, entrypoint e, view_zip_distance zd, phone p
                                    where eg.entrypointgroup_id=$entrypointgroup_id
                                        and eg.entrypoint_id=e.entrypoint_id
                                        and e.active_flag=1
                                        and e.zipcode=zd.start_zipcode
                                        and zd.start_state_id='IL'
                                        and zd.end_zipcode=$esi_zip
                                        and zd.distance <= 100";
		$epgEp_proximityRadius_query = $bcudb->get_results($query_epgEp_proximityRadius);						
			foreach($epgEp_proximityRadius_query as $epgEpObj):
				$epgEpId = $epgEpObj->entrypoint_id;
			endforeach;	
		}
        if ($epgEpId > 0) {
			$query_getEPGphone = "Select number from phone where entrypoint_id = $epgEpId and phonetype_id = 1 Limit 1";
			$getEPGphone_query = $bcudb->get_results($query_getEPGphone);
		}
		if (count($getEPGphone_query) == 1){
			$epg_phone = $getEPGphone_query->number;
		}
	}
?>