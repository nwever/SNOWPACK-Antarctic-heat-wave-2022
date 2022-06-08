function calcsd (fs1, fs2, fn) {
	if (fn<=1) {
		# We need 2 points to calculate standard deviation
		return nodata;
	}
	avg = fs1 / fn;
	return fs2 / fn - avg * avg;
}
function printOutput ()
{
	if (NR==1) return;
	split(cmd_out,a," ");
	if (!ho) {
		ho=1;
		# Coordinates
		printf "#lon lat easting northing altitude";
		# Event data
		printf " nsteps dSWE_(kg/m2) dFAC_(m) mssnow_(kg/m2) mswind_(kg/m2) mssnow_net_(kg/m2) msrain_(kg/m2) mssublimation_(kg/m2) msevaporation_(kg/m2) msrunoff_(kg/m2) msmelt_(kg/m2) qs_(W/m2) ql_(W/m2) qr_(W/m2) lwr_net_(W/m2) swr_net_(W/m2)";
		printf " nsteps_clim dSWE_clim_(kg/m2) dSWE_clim_sd_(kg/m2) dFAC_clim_(m) dFAC_clim_sd_(m) mssnow_clim_(kg/m2) mssnow_clim_sd_(kg/m2) mswind_clim_(kg/m2) mswind_clim_sd_(kg/m2) mssnow_net_clim(kg/m2) mssnow_net_clim_sd(kg/m2) msrain_clim_(kg/m2) msrain_clim_sd_(kg/m2) mssublimation_clim_(kg/m2) mssublimation_clim_sd_(kg/m2) msevaporation_clim_(kg/m2) msevaporation_clim_sd_(kg/m2) msrunoff_clim_(kg/m2) msrunff_clim_sd_(kg/m2) msmelt_clim_(kg/m2) msmelt_clim_sd_(kg/m2) qs_clim_(W/m2) qs_clim_sd_(W/m2) ql_clim_(W/m2) ql_clim_sd_(W/m2) qr_clim_(W/m2) qr_clim_sd_(W/m2) lwr_net_clim_(W/m2) lwr_net_clim_sd_(W/m2) swr_net_clim_(W/m2) swr_net_clim_sd_(W/m2)\n";
	}
	# Print coordinates
	printf "%.3f %.3f %.0f %.0f %.0f", lon, lat, a[1], a[2], alt
	# Print event data"
	if (n>0) {
		printf " %d %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f", n, SWE2-SWE1, FAC2-FAC1, sum_mssnow, sum_mswind, sum_mssnow_net, sum_msrain, sum_mssubl, sum_msevap, sum_msrunoff, sum_msmelt, sum_qs/n, sum_ql/n, sum_qr/n, sum_lwr_net/n, sum_swr_net/n;
	} else {
		printf " %d %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f", n, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata;
	}
	# Print climatology
	if (nc1>0) {
		printf " %d %.3f %.3f %.6f %.6f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f", nc1 \
		, sum_dSWEc1 / nc1, calcsd(sum_dSWEc1, sum_dSWEc2, nc1) \
		, sum_dFACc1 / nc1, calcsd(sum_dFACc1, sum_dFACc2, nc1) \
		, sumc1_mssnow / nc1, calcsd(sumc1_mssnow, sumc2_mssnow, nc1) \
		, sumc1_mswind / nc1, calcsd(sumc1_mswind, sumc2_mswind, nc1) \
		, sumc1_mssnow_net / nc1, calcsd(sumc1_mssnow_net, sumc2_mssnow_net, nc1) \
		, sumc1_msrain / nc1, calcsd(sumc1_msrain, sumc2_msrain, nc1) \
		, sumc1_mssubl / nc1, calcsd(sumc1_mssubl, sumc2_mssubl, nc1) \
		, sumc1_msevap / nc1, calcsd(sumc1_msevap, sumc2_msevap, nc1) \
		, sumc1_msrunoff / nc1, calcsd(sumc1_msrunoff, sumc2_msrunoff, nc1) \
		, sumc1_msmelt / nc1, calcsd(sumc1_msmelt, sumc2_msmelt, nc1) \
		, sumc1_qs / nc1, calcsd(sumc1_qs, sumc2_qs, nc1) \
		, sumc1_ql / nc1, calcsd(sumc1_ql, sumc2_ql, nc1) \
		, sumc1_qr / nc1, calcsd(sumc1_qr, sumc2_qr, nc1) \
		, sumc1_lwr_net / nc1, calcsd(sumc1_lwr_net, sumc2_lwr_net, nc1) \
		, sumc1_swr_net / nc1, calcsd(sumc1_swr_net, sumc2_swr_net, nc1)
	} else {
		printf " %d %.3f %.3f %.6f %.6f %.3f %.3f %.3f %.3f %.2f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f", 0, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata;
	}
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
		# Print output from previous file if needed
		printOutput();
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
				} else if ($i=="LWR_net") {
					lwrnet=(i-2);
				} else if ($i=="ISWR") {
					iswr=(i-2);
				} else if ($i=="OSWR") {
					oswr=(i-2);
				}
			}
		}
	}
	if (d) {
		if (substr($1,1,16)==pbegin) {
			SWE1=$swe;
			FAC1=($hs/100)-(($swe-$mswater)/917+$mswater/1000);
		}
		if (substr($1,1,16)==pend) {
			SWE2=$swe; FAC2=($hs/100)-(($swe-$mswater)/917+$mswater/1000)
		}
		if (substr($1,1,16)>=pbegin && substr($1,1,16)<=pend) {
			# Mass balance
			sum_mssnow+=$mssnow;
			sum_mswind+=$mswind;
			sum_mssnow_net+=($mssnow-$mswind);
			sum_msrain+=$msrain;
			sum_mssubl+=$mssubl;
			sum_msevap+=$msevap;
			sum_msrunoff+=$msrunoff;
			sum_msmelt+=$msmelt;
			# Energy balance
			sum_qs+=$qs;
			sum_ql+=$ql;
			sum_qr+=$qr;
			sum_lwr_net+=$lwrnet;
			sum_swr_net+=($iswr-$oswr);
			n++;
		}
		# Calculate climatological values
		if (int(substr($1,1,4)) != yr_of_interest && int(substr($1,6,2)) == month_of_interest) {
			# Calculate climatological values over the same period as the event
			if (substr($1,6,11) == substr(pbegin,6,11)) {
				SWE1c=$swe;
				FAC1c=($hs/100)-(($swe-$mswater)/917+$mswater/1000);
			}
			if (substr($1,6,11) >= substr(pbegin,6,11) && substr($1,6,11) <= substr(pend,6,11)) {
				# Mass balance
				sumc_mssnow+=$mssnow;
				sumc_mswind+=$mswind;
				sumc_mssnow_net+=($mssnow-$mswind);
				sumc_msrain+=$msrain;
				sumc_mssubl+=$mssubl;
				sumc_msevap+=$msevap;
				sumc_msrunoff+=$msrunoff;
				sumc_msmelt+=$msmelt;
				# Energy balance
				sumc_qs+=$qs;
				sumc_ql+=$ql;
				sumc_qr+=$qr;
				sumc_lwr_net+=$lwrnet;
				sumc_swr_net+=($iswr-$oswr);
				nc++;
			}
			if (substr($1,6,11) == substr(pend,6,11)) {
				SWE2c=$swe; FAC2c=($hs/100)-(($swe-$mswater)/917+$mswater/1000);
				# Normal sums:
				sum_dSWEc1+=(SWE2c-SWE1c)
				sum_dFACc1+=(FAC2c-FAC1c)
				# Mass balance
				sumc1_mssnow+=sumc_mssnow;
				sumc1_mswind+=sumc_mswind;
				sumc1_mssnow_net+=sumc_mssnow_net;
				sumc1_msrain+=sumc_msrain;
				sumc1_mssubl+=sumc_mssubl;
				sumc1_msevap+=sumc_msevap;
				sumc1_msrunoff+=sumc_msrunoff;
				sumc1_msmelt+=sumc_msmelt;
				# Energy balance
				sumc1_qs+=sumc_qs/nc;
				sumc1_ql+=sumc_ql/nc;
				sumc1_qr+=sumc_qr/nc;
				sumc1_lwr_net+=sumc_lwr_net/nc;
				sumc1_swr_net+=sumc_swr_net/nc;
				# Squared sums
				sum_dSWEc2+=(SWE2c-SWE1c)*(SWE2c-SWE1c);
				sum_dFACc2+=(FAC2c-FAC1c)*(FAC2c-FAC1c);
				# Mass balance
				sumc2_mssnow+=sumc_mssnow*sumc_mssnow;
				sumc2_mswind+=sumc_mswind*sumc_mswind;
				sumc2_mssnow_net+=sumc_mssnow_net*sumc_mssnow_net;
				sumc2_msrain+=sumc_msrain*sumc_msrain;
				sumc2_mssubl+=sumc_mssubl*sumc_mssubl;
				sumc2_msevap+=sumc_msevap*sumc_msevap;
				sumc2_msrunoff+=sumc_msrunoff*sumc_msrunoff;
				sumc2_msmelt+=sumc_msmelt*sumc_msmelt;
				# Energy balance
				sumc2_qs+=sumc_qs*sumc_qs/(nc*nc);
				sumc2_ql+=sumc_ql*sumc_ql/(nc*nc);
				sumc2_qr+=sumc_qr*sumc_qr/(nc*nc);
				sumc2_lwr_net+=sumc_lwr_net*sumc_lwr_net/(nc*nc);
				sumc2_swr_net+=sumc_swr_net*sumc_swr_net/(nc*nc);
				nc1++;

				# Reset climatological temp sums:
				sumc_mssnow=0;
				sumc_mswind=0;
				sumc_mssnow_net=0;
				sumc_msrain=0;
				sumc_mssubl=0;
				sumc_msevap=0;
				sumc_msrunoff=0;
				sumc_msmelt=0;
				sumc_qs=0;
				sumc_ql=0;
				sumc_qr=0;
				sumc_lwr_net=0;
				sumc_swr_net=0;
				nc=0;
			}
		}
	}
	if (/\[DATA\]/) {
		# Entering the data
		h=0;
		d=1;
		# Reset all variables
		sum_mssnow=0;
		sum_mswind=0;
		sum_mssnow_net=0;
		sum_msrain=0;
		sum_mssubl=0;
		sum_msevap=0;
		sum_msrunoff=0;
		sum_msmelt=0;
		sum_qs=0;
		sum_ql=0;
		sum_qr=0;
		sum_lwr_net=0;
		sum_swr_net=0;
		n=0;
		# Climatological normal sums:
		sum_dSWEc1=0;
		sum_dFACc1=0;
		sumc1_mssnow=0;
		sumc1_mswind=0;
		sumc1_mssnow_net=0;
		sumc1_msrain=0;
		sumc1_mssubl=0;
		sumc1_msevap=0;
		sumc1_msrunoff=0;
		sumc1_msmelt=0;
		sumc1_qs=0;
		sumc1_ql=0;
		sumc1_qr=0;
		sumc1_lwr_net=0;
		sumc1_swr_net=0;
		nc1=0;
		# Climatological squared sums:
		sum_dSWEc2=0;
		sum_dFACc2=0;
		sumc2_mssnow=0;
		sumc2_mswind=0;
		sumc2_mssnow_net=0;
		sumc2_msrain=0;
		sumc2_mssubl=0;
		sumc2_msevap=0;
		sumc2_msrunoff=0;
		sumc2_msmelt=0;
		sumc2_qs=0;
		sumc2_ql=0;
		sumc2_qr=0;
		sumc2_lwr_net=0;
		sumc2_swr_net=0;
		# Transform the coordinates we obtained from the header from EPSG:4326 to EPSG:3031
		cmd=sprintf("echo %f %f | gdaltransform -s_srs EPSG:4326 -t_srs EPSG:3031", lon, lat);
		cmd | getline cmd_out;
		close(cmd);
	}
}
END {
	printOutput();
}
