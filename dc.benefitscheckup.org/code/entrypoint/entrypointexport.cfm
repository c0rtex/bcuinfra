<cfparam name="format" type="string" default="csv"><cf_exportQuery preloadkey="entrypoint_id" preload="groups|select eg.entrypoint_id, g.name from entrypoint_entrypointgroup eg, entrypointgroup g where eg.entrypointgroup_id=g.entrypointgroup_id order by eg.entrypoint_id, g.name|name^counties_served|select ec.entrypoint_id, c.county_name from entrypoint_county ec, county c where ec.county_id=c.county_id order by ec.entrypoint_id, c.county_name|county_name^cities_served|select ec.entrypoint_id, c.city_name from entrypoint_city ec, city c where ec.city_id=c.city_id order by ec.entrypoint_id, c.city_name|city_name^zips_served|select ez.entrypoint_id, z.zipcode from entrypoint_zip ez, zip z where ez.zipcode=z.zipcode order by ez.entrypoint_id, z.zipcode|zipcode^voice|SELECT phone.entrypoint_id, phone.number AS v_number FROM phone INNER JOIN phonetype ON phone.phonetype_id = phonetype.phonetype_id WHERE (phone.phonetype_id = 1) ORDER BY phone.entrypoint_id, phone.sort|v_number^fax|SELECT phone.entrypoint_id, phone.number AS f_number FROM phone INNER JOIN phonetype ON phone.phonetype_id = phonetype.phonetype_id WHERE (phone.phonetype_id = 2) ORDER BY phone.entrypoint_id, phone.sort|f_number^tty|SELECT phone.entrypoint_id, phone.number AS t_number FROM phone INNER JOIN phonetype ON phone.phonetype_id = phonetype.phonetype_id WHERE (phone.phonetype_id = 3) ORDER BY phone.entrypoint_id, phone.sort|t_number^toll_free|SELECT phone.entrypoint_id, phone.number AS tf_number FROM phone INNER JOIN phonetype ON phone.phonetype_id = phonetype.phonetype_id WHERE (phone.phonetype_id = 4) ORDER BY phone.entrypoint_id, phone.sort|tf_number^translation|SELECT phone.entrypoint_id, phone.number AS trans_number FROM phone INNER JOIN phonetype ON phone.phonetype_id = phonetype.phonetype_id WHERE (phone.phonetype_id = 5) ORDER BY phone.entrypoint_id, phone.sort|trans_number^spanish|SELECT phone.entrypoint_id, phone.number AS s_number FROM phone INNER JOIN phonetype ON phone.phonetype_id = phonetype.phonetype_id WHERE (phone.phonetype_id = 6) ORDER BY phone.entrypoint_id, phone.sort|s_number" query="
	select e.entrypoint_id, e.name, e.subname, e.address1, e.address2, e.address3, e.city,
		e.state_id, e.zipcode, e.zipcode_plus4, e.email, e.url, dl1.display_id as hours_display_id, dl1.display_text as hours,
		dl2.display_id as info_display_id, dl2.display_text as info, e.contact_title, e.contact_first, e.contact_middle, e.contact_last,
		e.contact_suffix, e.privatephone, e.last_update, e.active_flag, e.notes
	from entrypoint e left outer join display_language dl1
			on e.hours_display_id=dl1.display_id
				and dl1.language_id='EN'
		left outer join display_language dl2
			on e.info_display_id=dl2.display_id
				and dl2.language_id='EN'
	order by e.entrypoint_id
" columnList="groups,entrypoint_id,name,subname,address1,address2,address3,city,state_id,zipcode,zipcode_plus4,email,url,hours_display_id,hours,info_display_id,info,contact_title,contact_first,contact_middle,contact_last,contact_suffix,privatephone,last_update,active_flag,notes,voice,fax,tty,toll_free,translation,spanish,cities_served,counties_served,zips_served" format="#format#">