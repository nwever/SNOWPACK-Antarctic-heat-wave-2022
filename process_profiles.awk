#cat <(unzip -p /pl/active/icesheetsclimate/IDS_Antarctica2/zip/-77.500_-156.250_DEFAULT.zip "output/*.pro") <(unzip -p /pl/active/icesheetsclimate/IDS_Antarctica2/zip_2022/-77.500_-156.250.zip "output/*.pro" | awk '{if(d) {print}; if(/\[DATA\]/) {d=1}}') | awk -F, -f aap | less

function calcsd (fs1, fs2, fn) {
	if (fn<=1) {
		# We need 2 points to calculate standard deviation
		return nodata;
	}
	avg = fs1 / fn;
	return sqrt(fs2 / fn - avg * avg);
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
		printf " nsteps rho1_10cm_(kg/m3) rho1_20cm_(kg/m3) rho1_30cm_(kg/m3) rho1_50cm_(kg/m3) rho1_100_cm_(kg/m3) rho2_10cm_(kg/m3) rho2_20cm_(kg/m3) rho2_30cm_(kg/m3) rho2_50cm_(kg/m3) rho2_100_cm_(kg/m3)";
		printf " nsteps_clim rho_10cm_clim_(kg/m3) rho_10cm_clim_sd_(kg/m3) rho_20cm_clim_(kg/m3) rho_20cm_clim_sd_(kg/m3) rho_30cm_clim_(kg/m3) rho_30cm_clim_sd_(kg/m3) rho_50cm_clim_(kg/m3) rho_50cm_clim_sd_(kg/m3) rho_100_cm_clim_(kg/m3) rho_100_cm_clim_sd_(kg/m3)\n";
	}
	# Print coordinates
	printf "%.3f %.3f %.0f %.0f %.0f", lon, lat, a[1], a[2], alt
	# Print event data"
	if (n>0) {
		printf " %d %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f", n, rho_10cm1, rho_20cm1, rho_30cm1, rho_50cm1, rho_100cm1, rho_10cm2, rho_20cm2, rho_30cm2, rho_50cm2, rho_100cm2;
	} else {
		printf " %d %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f", n, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata;
	}
	# Print climatology
	if (nc1>0) {
		printf " %d %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f", nc1 \
		, sumc1_rho_10cm / nc1, calcsd(sumc1_rho_10cm, sumc2_rho_10cm, nc1) \
		, sumc1_rho_20cm / nc1, calcsd(sumc1_rho_20cm, sumc2_rho_20cm, nc1) \
		, sumc1_rho_30cm / nc1, calcsd(sumc1_rho_30cm, sumc2_rho_30cm, nc1) \
		, sumc1_rho_50cm / nc1, calcsd(sumc1_rho_50cm, sumc2_rho_50cm, nc1) \
		, sumc1_rho_100cm / nc1, calcsd(sumc1_rho_100cm, sumc2_rho_100cm, nc1)
	} else {
		printf " %d %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f", 0, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata, nodata;
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
	if ($0=="[STATION_PARAMETERS]") {
		# Entering the header
		h=1;
		d=0;
		# Print output from previous file if needed
		printOutput();
	}
	if (h) {
		# Deal with coordinates
		if (/Latitude/) {
			split($0,a,"= ")
			lat=a[2];
		} else if (/Longitude/) {
			split($0,a,"= ")
			lon=a[2];
		} else if (/Altitude/) {
			split($0,a,"= ")
			alt=a[2];
		}
	}
	if (d) {
		if (/^0500/) {
			datum=sprintf("%04d-%02d-%02dT%02d:%02d:%02d", substr($2,7,4), substr($2,4,2), substr($2,1,2), substr($2,12,2), substr($2,15,2), substr($2,18,2));
		} else if($1==501) {
			if($2==1 && $3==0) {printf "%s -999 -999 -999 -999 -999 -999\n", datum;}
			if($3 > 0) {
				# This is necessary in case no soil is present
				bottomsnowelement=1; z[1]=0; offset=1; nE=$2; nEsnow=nE;
			} else {
				# Case with soil layers
				offset=0; nE=$2-1;
			}
			for(i=1;i<=$2;i++) {
				# Read domain coordinates
				z[i+offset]=$(i+2)/100.;
				if(z[i+offset]==0) {
					bottomsnowelement=i
				}
			}
			nEsnow=nE-bottomsnowelement+1;
		} else if($1==502) {
			# Read densities
			for(i=1; i<=$2; i++) {
				rho[i]=$(i+2);
			}
		} else if($1==503) {
			# Read temperatures
			for(i=1; i<=$2; i++) {
				Te[i]=$(i+2)+273.15
			}
		} else if($1==506) {
			# Read LWC
			for(i=1; i<=$2; i++) {
				th_water[i]=$(i+2)/100.
			}
		} else if($1==512) {
			# Read grain size
			for(i=1; i<=$2; i++) {
				gs[i]=$(i+2)
			}
		} else if($1==515) {
			# Read theta[ICE]
			for(i=1; i<=$2; i++) {
				th_ice[i]=$(i+2)/100.
			}
		} else if($1==516) {
			n++;
			# Read theta[AIR] (i.e., pore space)
			for(i=1; i<=$2; i++) {
				th_air[i]=$(i+2)/100.
			}
			H=0;
			rho_10cm=0
			rho_10cm_d=0
			rho_20cm=0
			rho_20cm_d=0
			rho_30cm=0
			rho_30cm_d=0
			rho_50cm=0
			rho_50cm_d=0
			rho_100cm=0
			rho_100cm_d=0
			for(i=nEsnow; i>=bottomsnowelement; i--) {
				dH=(z[i+1]-z[i]);
				if (H<=0.1) {
					rho_10cm+=rho[i]*dH;
					rho_10cm_d+=dH;
				}
				if (H<=0.2) {
					rho_20cm+=rho[i]*dH;
					rho_20cm_d+=dH;
				}
				if (H<=0.3) {
					rho_30cm+=rho[i]*dH;
					rho_30cm_d+=dH;
				}
				if (H<=0.5) {
					rho_50cm+=rho[i]*dH;
					rho_50cm_d+=dH;
				}
				if (H<=1.) {
					rho_100cm+=rho[i]*dH;
					rho_100cm_d+=dH;
				}
				H+=dH;
			}
			rho_10cm/=rho_10cm_d;
			rho_20cm/=rho_20cm_d;
			rho_30cm/=rho_30cm_d;
			rho_50cm/=rho_50cm_d;
			rho_100cm/=rho_100cm_d;
			if (substr(datum,1,16)==pbegin) {
				rho_10cm1=rho_10cm
				rho_20cm1=rho_20cm
				rho_30cm1=rho_30cm
				rho_50cm1=rho_50cm
				rho_100cm1=rho_100cm
			}
			if (substr(datum,1,16)==pend) {
				rho_10cm2=rho_10cm
				rho_20cm2=rho_20cm
				rho_30cm2=rho_30cm
				rho_50cm2=rho_50cm
				rho_100cm2=rho_100cm
			}
			# Calculate climatological values
			if (int(substr(datum,1,4)) != yr_of_interest && int(substr(datum,6,2)) == month_of_interest) {
				sumc_rho_10cm+=rho_10cm
				sumc_rho_20cm+=rho_20cm
				sumc_rho_30cm+=rho_30cm
				sumc_rho_50cm+=rho_50cm
				sumc_rho_100cm+=rho_100cm
				nc++;
			}
			if (int(substr(datum,1,4)) != yr_of_interest && int(substr(datum,6,2)) != month_of_interest) {
				if (nc>0) {
					sumc1_rho_10cm+=sumc_rho_10cm/nc
					sumc1_rho_20cm+=sumc_rho_20cm/nc
					sumc1_rho_30cm+=sumc_rho_30cm/nc
					sumc1_rho_50cm+=sumc_rho_50cm/nc
					sumc1_rho_100cm+=sumc_rho_100cm/nc
					# Squared sums
					sumc2_rho_10cm+=(sumc_rho_10cm*sumc_rho_10cm)/(nc*nc)
					sumc2_rho_20cm+=(sumc_rho_20cm*sumc_rho_20cm)/(nc*nc)
					sumc2_rho_30cm+=(sumc_rho_30cm*sumc_rho_30cm)/(nc*nc)
					sumc2_rho_50cm+=(sumc_rho_50cm*sumc_rho_50cm)/(nc*nc)
					sumc2_rho_100cm+=(sumc_rho_100cm*sumc_rho_100cm)/(nc*nc)												
					nc1++;

					# Reset climatological temp sums:
					sumc_rho_10cm=0
					sumc_rho_20cm=0
					sumc_rho_30cm=0
					sumc_rho_50cm=0
					sumc_rho_100cm=0
					nc=0;
				}
			}
		}
	}
	if (/\[DATA\]/) {
		# Entering the data
		h=0;
		d=1;
		# Reset all variables
		n=0;
		# Climatological normal sums:
		sumc1_rho_10cm=0;
		sumc1_rho_20cm=0;
		sumc1_rho_30cm=0;
		sumc1_rho_50cm=0;
		sumc1_rho_100cm=0;
		sumc2_rho_10cm=0;
		sumc2_rho_20cm=0;
		sumc2_rho_30cm=0;
		sumc2_rho_50cm=0;
		sumc2_rho_100cm=0;
		nc1=0;
		# Transform the coordinates we obtained from the header from EPSG:4326 to EPSG:3031
		cmd=sprintf("echo %f %f | gdaltransform -s_srs EPSG:4326 -t_srs EPSG:3031", lon, lat);
		cmd | getline cmd_out;
		close(cmd);
	}
}
END {
	printOutput();
}
