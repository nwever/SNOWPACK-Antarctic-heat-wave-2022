function printOutput ()
{
	if (NR==1) return;
	split(cmd_out,a," ");
	if (!ho) {
		ho=1;
		# Coordinates
		printf "#lon lat easting northing altitude date ";
		# Event data
		printf " SWE_(kg/m2) FAC_(m) mssnow_(kg/m2) mswind_(kg/m2) mssnow_net_(kg/m2) msrain_(kg/m2) mssublimation_(kg/m2) msevaporation_(kg/m2) msrunoff_(kg/m2) msmelt_(kg/m2) mass_balance_(kg/m2) qs_(W/m2) ql_(W/m2) qr_(W/m2) ilwr_(W/m2) iswr_(W/m2) lwr_net_(W/m2) swr_net_(W/m2) energy_balance_(W/m2)\n";
	}
	# Print coordinates
	printf "%.3f %.3f %.0f %.0f %.0f", lon, lat, a[1], a[2], alt
	# Print event data"
	printf " %s %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f", $1, $swe, fac, $mssnow, $mswind, mssnow_net, $msrain, $mssubl, $msevap, $msrunoff, $msmelt, mb, $qs, $ql, $qr, $ilwr, $iswr, $lwr_net, swr_net, eb;
	printf "\n";
}
BEGIN {
	h=1;   # Flag for header
	d=0;   # Flag for data
	ho=0;  # Flag if output header has been written
	pbegin="2022-03-14T00:00";	# Start of period of interest
	pend="2022-03-19T00:00";	# End of period of interest
	yr_of_interest=2022;		# This year will not be included in climatological means
	month_of_interest=3;		# The climatology will be calculated over this period
	nodata=-999;
}
{
	if ($0=="SMET 1.1 ASCII") {
		# Entering the header
		h=1;
		d=0;
	}
	if (h) {
		# Deal with coordinates
		if (/latitude/) {
			lat=$NF;
		} else if (/longitude/) {
			lon=$NF;
		} else if (/altitude/) {
			alt=$NF;
		} else 
		# Process the fields entry in the header
		if (/fields/) {
			for (i=3; i<=NF; i++) {
				if ($i=="SWE") {
					swe=i-2;
				# Mass balance
				} else if ($i=="MS_Snow") {
					mssnow=i-2;
				} else if ($i=="MS_Wind") {
					mswind=i-2;
				} else if ($i=="MS_Rain") {
					msrain=i-2;
				} else if ($i=="MS_Water") {
					mswater=i-2;
				} else if ($i=="MS_Sublimation") {
					mssubl=i-2;
				} else if ($i=="MS_Evap") {
					msevap=i-2;
				} else if ($i=="MS_SN_Runoff") {
					msrunoff=i-2;
				} else if ($i=="HS_mod") {
					hs=i-2;
				} else if ($i=="MS_melt") {
					msmelt=(i-2);
				# Energy balance
				} else if ($i=="Qs") {
					qs=(i-2);
				} else if ($i=="Ql") {
					ql=(i-2);
				} else if ($i=="Qr") {
					qr=(i-2);
				} else if ($i=="ILWR") {
					ilwr=(i-2);
				} else if ($i=="LWR_net") {
					lwr_net=(i-2);
				} else if ($i=="ISWR") {
					iswr=(i-2);
				} else if ($i=="OSWR") {
					oswr=(i-2);
				}
			}
		}
	}
	if (d) {
		fac=($hs/100)-(($swe-$mswater)/917+$mswater/1000);
		mssnow_net=($mssnow-$mswind);
		mb=($mssnow-$mswind)+$msrain+$mssubl+$msevap-$msrunoff;
		swr_net=($iswr-$oswr);
		eb=$qs+$ql+$qr+$lwrnet+($iswr-$oswr);
		if (substr($1,1,16)>=pbegin && substr($1,1,16)<=pend) {
			printOutput();
		}
	}
	if (/\[DATA\]/) {
		# Entering the data
		h=0;
		d=1;
		# Transform the coordinates we obtained from the header from EPSG:4326 to EPSG:3031
		cmd=sprintf("echo %f %f | gdaltransform -s_srs EPSG:4326 -t_srs EPSG:3031", lon, lat);
		cmd | getline cmd_out;
		close(cmd);
	}
}
