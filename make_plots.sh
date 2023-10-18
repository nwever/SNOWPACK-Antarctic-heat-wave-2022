ftp="stats.txt"		# File to plot


# Search for the columns to use for plotting:
easting=$(head -1 ${ftp} | mawk -v s="easting" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
northing=$(head -1 ${ftp} | mawk -v s="northing" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
eb=$(head -1 ${ftp} | mawk -v s="energy_balance_(W/m2)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
eb_clim=$(head -1 ${ftp} | mawk -v s="energy_balance_clim_(W/m2)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
eb_clim_sd=$(head -1 ${ftp} | mawk -v s="energy_balance_clim_sd_(W/m2)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')

qs=$(head -1 ${ftp} | mawk -v s="qs_(W/m2)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
qs_clim=$(head -1 ${ftp} | mawk -v s="qs_clim_(W/m2)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
qs_clim_sd=$(head -1 ${ftp} | mawk -v s="qs_clim_sd_(W/m2)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
ql=$(head -1 ${ftp} | mawk -v s="ql_(W/m2)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
ql_clim=$(head -1 ${ftp} | mawk -v s="ql_clim_(W/m2)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
ql_clim_sd=$(head -1 ${ftp} | mawk -v s="ql_clim_sd_(W/m2)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
swnet=$(head -1 ${ftp} | mawk -v s="swr_net_(W/m2)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
swnet_clim=$(head -1 ${ftp} | mawk -v s="swr_net_clim_(W/m2)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
swnet_clim_sd=$(head -1 ${ftp} | mawk -v s="swr_net_clim_sd_(W/m2)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
lwnet=$(head -1 ${ftp} | mawk -v s="lwr_net_(W/m2)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
lwnet_clim=$(head -1 ${ftp} | mawk -v s="lwr_net_clim_(W/m2)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
lwnet_clim_sd=$(head -1 ${ftp} | mawk -v s="lwr_net_clim_sd_(W/m2)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')

dfac=$(head -1 ${ftp} | mawk -v s="dFAC_(m)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
dfac_clim=$(head -1 ${ftp} | mawk -v s="dFAC_clim_(m)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
dfac_clim_sd=$(head -1 ${ftp} | mawk -v s="dFAC_clim_sd_(m)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')

dhs_snow=$(head -1 ${ftp} | mawk -v s="dhs_snow_(mm)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
dhs_snow_clim=$(head -1 ${ftp} | mawk -v s="dhs_snow_clim_(mm)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
dhs_snow_clim_sd=$(head -1 ${ftp} | mawk -v s="dhs_snow_clim_sd_(mm)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
dhs_subl=$(head -1 ${ftp} | mawk -v s="dhs_subl_(mm)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
dhs_subl_clim=$(head -1 ${ftp} | mawk -v s="dhs_subl_clim_(mm)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
dhs_subl_clim_sd=$(head -1 ${ftp} | mawk -v s="dhs_subl_clim_sd_(mm)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
dhs_sett=$(head -1 ${ftp} | mawk -v s="dhs_sett_(mm)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
dhs_sett_clim=$(head -1 ${ftp} | mawk -v s="dhs_sett_clim_(mm)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
dhs_sett_clim_sd=$(head -1 ${ftp} | mawk -v s="dhs_sett_clim_sd_(mm)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
dhs_erod=$(head -1 ${ftp} | mawk -v s="dhs_erod_(mm)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
dhs_erod_clim=$(head -1 ${ftp} | mawk -v s="dhs_erod_clim_(mm)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
dhs_erod_clim_sd=$(head -1 ${ftp} | mawk -v s="dhs_erod_clim_sd_(mm)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
dhs_redepo=$(head -1 ${ftp} | mawk -v s="dhs_redepo_(mm)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
dhs_redepo_clim=$(head -1 ${ftp} | mawk -v s="dhs_redepo_clim_(mm)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
dhs_redepo_clim_sd=$(head -1 ${ftp} | mawk -v s="dhs_redepo_clim_sd_(mm)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')



plotfilename=plots/eb_event
echo "set term pdf size 24,6.6 font 'Helvetica,34'" > ${plotfilename}
echo "set encoding iso_8859_1" >> ${plotfilename}
echo "set datafile missing \"-999\"" >> ${plotfilename}
echo "set output '${plotfilename}.pdf'" >> ${plotfilename}
echo "set multiplot layout 1,3" >> ${plotfilename}
echo "set size ratio -1" >> ${plotfilename}
echo "set xlabel 'Easting (x1000 km)'" >> ${plotfilename}
echo "set ylabel 'Northing (x1000 km)'" >> ${plotfilename}
echo "set ytics 1; set xtics 1" >> ${plotfilename}
echo "set cblabel offset 0.5" >> ${plotfilename}

#echo "set title 'Energy balance (W/m^{-2}) between March 14 and March 19, 2022'" >> ${plotfilename}
echo "set cblabel 'Energy balance (W m^{-2})'" >> ${plotfilename}
echo "set label 1 '(a)' at graph -0.2, 1.03 font ',40'" >> ${plotfilename}
echo "set cbrange[-25:25]" >> ${plotfilename}
echo "set key at graph 0.365, graph 0.95 reverse" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):(\$${eb}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' title 'Dome C'" >> ${plotfilename}

#echo "set title 'Energy balance, deviation from 1980-2021 climatology (W m^{-2})'" >> ${plotfilename}
echo "set cblabel 'Energy balance anomaly (W m^{-2})'" >> ${plotfilename}
echo "set label 1 '(b)'" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-30:30]" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${eb}-\$${eb_clim})) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title 'Energy balance {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set cblabel 'Energy balance {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set label 1 '(c)'" >> ${plotfilename}
echo "set cbrange[-8:8]" >> ${plotfilename}
echo "set palette negative defined ( -8 '#B2182B', -6 '#D6604D', -4 '#F4A582', -2 '#FDDBC7', -1.999999 '#CCCCCC', 1.99999 '#CCCCCC', 2 '#D1E5F0', 4 '#92C5DE', 6 '#4393C3', 8 '#2166AC' )" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${eb}-\$${eb_clim})/\$${eb_clim_sd}) w p palette pt 7 ps .7 notitle, '<(echo 1.372448 -0.895541)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}
gnuplot ${plotfilename}



plotfilename=plots/eb_components_event
echo "set term pdf size 24,26.4 font 'Helvetica,34'" > ${plotfilename}
echo "set encoding iso_8859_1" >> ${plotfilename}
echo "set datafile missing \"-999\"" >> ${plotfilename}
echo "set output '${plotfilename}.pdf'" >> ${plotfilename}
echo "set multiplot layout 4,3" >> ${plotfilename}
echo "set size ratio -1" >> ${plotfilename}
echo "set xlabel 'Easting (x1000 km)'" >> ${plotfilename}
echo "set ylabel 'Northing (x1000 km)'" >> ${plotfilename}
echo "set ytics 1; set xtics 1" >> ${plotfilename}
echo "set cblabel offset 0.5" >> ${plotfilename}

#echo "set title 'Net SW (W m^{-2}) between March 14 and March 19, 2022'" >> ${plotfilename}
echo "set cblabel 'Net SW (W m^{-2})'" >> ${plotfilename}
echo "set label 1 '(a)' at graph -0.2, 1.03 font ',40'" >> ${plotfilename}
echo "set key at graph 0.365, graph 0.95 reverse" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#EBDDD0' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${swnet})) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' title 'Dome C'" >> ${plotfilename}

#echo "set title 'Net SW, deviation from 1980-2021 climatology (W m^{-2})'" >> ${plotfilename}
echo "set cblabel 'Net SW anomaly (W m^{-2})'" >> ${plotfilename}
echo "set label 1 '(b)'" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${swnet}-\$${swnet_clim})) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title 'Net SW {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set cblabel 'Net SW {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set label 1 '(c)'" >> ${plotfilename}
echo "set palette positive defined ( -5 '#B2182B', -4 '#D6604D', -3 '#F4A582', -2 '#FDDBC7', -1.999999 '#CCCCCC', 1.99999 '#CCCCCC', 2 '#D1E5F0', 3 '#92C5DE', 4 '#4393C3', 5 '#2166AC' )" >> ${plotfilename}
echo "set cbrange[-5:5]" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${swnet}-\$${swnet_clim})/\$${swnet_clim_sd}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}


#echo "set title 'Net LW (W m^{-2}) between March 14 and March 19, 2022'" >> ${plotfilename}
echo "set cblabel 'Net LW (W m^{-2})'" >> ${plotfilename}
echo "set label 1 '(d)'" >> ${plotfilename}
echo "set palette negative defined ( 3 '#EBDDD0', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):(\$${lwnet}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title 'Net LW, deviation from climatolgy (W m^{-2})'" >> ${plotfilename}
echo "set cblabel 'Net LW anomaly (W m^{-2})'" >> ${plotfilename}
echo "set label 1 '(e)'" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-50:50]" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):(\$${lwnet}-\$${lwnet_clim}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title 'Net LW {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set cblabel 'Net LW {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set label 1 '(f)'" >> ${plotfilename}
echo "set palette positive defined ( -6 '#B2182B', -4.6666667 '#D6604D', -3.333333 '#F4A582', -2 '#FDDBC7', -1.999999 '#CCCCCC', 1.99999 '#CCCCCC', 2 '#D1E5F0', 3.3333333 '#92C5DE', 4.666667 '#4393C3', 6 '#2166AC' )" >> ${plotfilename}
echo "set cbrange[-6:6]" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${lwnet}-\$${lwnet_clim})/\$${lwnet_clim_sd}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}


#echo "set title 'Sensible heat (W m^{-2}) between March 14 and March 19, 2022'" >> ${plotfilename}
echo "set cblabel 'Sensible heat (W m^{-2})'" >> ${plotfilename}
#echo "set palette positive defined ( 0 '#FFFFE5', 1 '#FFF7BC', 2 '#FEE391', 3 '#FEC44F', 4 '#FE9929', 5 '#EC7014', 6 '#CC4C02', 7 '#8C2D04' )" >> ${plotfilename}
echo "set label 1 '(g)'" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#EBDDD0' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${qs})) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title 'Sensible heat, deviation from 1980-2021 climatology (W m^{-2})'" >> ${plotfilename}
echo "set cblabel 'Sensible heat anomaly (W m^{-2})'" >> ${plotfilename}
echo "set label 1 '(h)'" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbtics add (\"{/Symbol \\263}20\" 20)" >> ${plotfilename}
echo "set cbtics add (\"{/Symbol \\243}-20\" -20)" >> ${plotfilename}
echo "set cbrange[-20:20]" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${qs} - \$${qs_clim})) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}
echo "set cbtics auto" >> ${plotfilename}

#echo "set title 'Sensible heat {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set cblabel 'Sensible heat {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set label 1 '(i)'" >> ${plotfilename}
echo "set palette positive defined ( -10 '#B2182B', -7.333333 '#D6604D', -4.6666667 '#F4A582', -2 '#FDDBC7', -1.999999 '#CCCCCC', 1.99999 '#CCCCCC', 2 '#D1E5F0', 4.666667 '#92C5DE', 7.333333 '#4393C3', 10 '#2166AC' )" >> ${plotfilename}
echo "set cbrange[-10:10]" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${qs}-\$${qs_clim})/\$${qs_clim_sd}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}


#echo "set title 'Latent heat (W m^{-2}) between March 14 and March 19, 2022'" >> ${plotfilename}
echo "set cblabel 'Latent heat (W m^{-2})'" >> ${plotfilename}
echo "set label 1 '(j)'" >> ${plotfilename}
echo "set palette negative defined ( -10 '#FDB863', 0 '#EBDDD0', 22.5 '#D8DAEB', 45 '#B2ABD2', 67.5 '#8073AC', 90 '#542788' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):(\$${ql}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title 'Latent heat, deviation from 1980-2021 climatology (W m^{-2})'" >> ${plotfilename}
echo "set cblabel 'Latent heat anomaly (W m^{-2})'" >> ${plotfilename}
echo "set label 1 '(k)'" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-20:20]" >> ${plotfilename}
echo "set cbtics add (\"{/Symbol \\263}20\" 20)" >> ${plotfilename}
echo "set cbtics add (\"{/Symbol \\243}-20\" -20)" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):(\$${ql}-\$${ql_clim}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}
echo "set cbtics auto" >> ${plotfilename}

#echo "set title 'Latent heat {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set cblabel 'Latent heat {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set label 1 '(l)'" >> ${plotfilename}
echo "set palette positive defined ( -35 '#B2182B', -24 '#D6604D', -13 '#F4A582', -2 '#FDDBC7', -1.999999 '#CCCCCC', 1.99999 '#CCCCCC', 2 '#D1E5F0', 13 '#92C5DE', 24 '#4393C3', 35 '#2166AC' )" >> ${plotfilename}
echo "set cbrange[-35:35]" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${ql}-\$${ql_clim})/\$${ql_clim_sd}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

gnuplot ${plotfilename}




plotfilename=plots/dfac_event
echo "set term pdf size 16,6.6 font 'Helvetica,34'" > ${plotfilename}
echo "set encoding iso_8859_1" >> ${plotfilename}
echo "set datafile missing \"-999\"" >> ${plotfilename}
echo "set output '${plotfilename}.pdf'" >> ${plotfilename}
echo "set multiplot layout 1,2" >> ${plotfilename}
echo "set size ratio -1" >> ${plotfilename}
echo "set xlabel 'Easting (x1000 km)'" >> ${plotfilename}
echo "set ylabel 'Northing (x1000 km)'" >> ${plotfilename}
echo "set ytics 1; set xtics 1" >> ${plotfilename}
echo "set cblabel offset 0.5" >> ${plotfilename}
echo "set key at graph 0.365, graph 0.95 reverse" >> ${plotfilename}

#echo "set title 'Change in Firn Air Content (m) between March 14 and March 19, 2022'" >> ${plotfilename}
echo "set cblabel 'Change in Firn Air Content (m)'" >> ${plotfilename}
echo "set cbrange[-0.4:0.4]" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "set label 1 '(a)' at graph -0.2, 1.03 font ',40'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):(\$${dfac}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' title 'Dome C'" >> ${plotfilename}

#echo "set title 'Change in Firn Air Content {/Helvetica-Italic Z}-score between March 14 and March 19, 2022'" >> ${plotfilename}
echo "set cblabel 'Change in Firn Air Content {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-20:20]" >> ${plotfilename}
echo "set palette positive defined ( -20 '#B2182B', -14 '#D6604D', -8 '#F4A582', -2 '#FDDBC7', -1.999999 '#CCCCCC', 1.99999 '#CCCCCC', 2 '#D1E5F0', 8 '#92C5DE', 14 '#4393C3', 20 '#2166AC' )" >> ${plotfilename}
echo "set label 1 '(b)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${dfac}-\$${dfac_clim})/\$${dfac_clim_sd}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}
gnuplot ${plotfilename}



plotfilename=plots/dfac_event_zoom
echo "set term pdf size 16,6.6 font 'Helvetica,34'" > ${plotfilename}
echo "set encoding iso_8859_1" >> ${plotfilename}
echo "set datafile missing \"-999\"" >> ${plotfilename}
echo "set output '${plotfilename}.pdf'" >> ${plotfilename}
echo "set multiplot layout 1,2" >> ${plotfilename}
echo "set size ratio -1" >> ${plotfilename}
echo "set xlabel 'Easting (x1000 km)'" >> ${plotfilename}
echo "set ylabel 'Northing (x1000 km)'" >> ${plotfilename}
echo "set ytics 1; set xtics 1" >> ${plotfilename}
echo "set cblabel offset 0.5" >> ${plotfilename}
echo "set key at graph 0.365, graph 0.95 reverse" >> ${plotfilename}

#echo "set title 'Change in Firn Air Content (m) between March 14 and March 19, 2022'" >> ${plotfilename}
echo "set cblabel 'Change in Firn Air Content (m)'" >> ${plotfilename}
echo "set cbrange[-0.4:0.4]" >> ${plotfilename}
echo "set xrange[0.600:2.800]" >> ${plotfilename}
echo "set yrange[-2.200:0]" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "set label 1 '(a)' at graph -0.2, 1.03 font ',40'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):(\$${dfac}) w p palette pt 7 ps 1.2 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' title 'Dome C'" >> ${plotfilename}

#echo "set title 'Change in Firn Air Content {/Helvetica-Italic Z}-score between March 14 and March 19, 2022'" >> ${plotfilename}
echo "set cblabel 'Change in Firn Air Content {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-20:20]" >> ${plotfilename}
echo "set palette positive defined ( -20 '#B2182B', -14 '#D6604D', -8 '#F4A582', -2 '#FDDBC7', -1.999999 '#CCCCCC', 1.99999 '#CCCCCC', 2 '#D1E5F0', 8 '#92C5DE', 14 '#4393C3', 20 '#2166AC' )" >> ${plotfilename}
echo "set label 1 '(b)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${dfac}-\$${dfac_clim})/\$${dfac_clim_sd}) w p palette pt 7 ps 1.2 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}
gnuplot ${plotfilename}




plotfilename=plots/dhs_components_event
echo "set term pdf size 24,26.4 font 'Helvetica,34'" > ${plotfilename}
echo "set encoding iso_8859_1" >> ${plotfilename}
echo "set datafile missing \"-999\"" >> ${plotfilename}
echo "set output '${plotfilename}.pdf'" >> ${plotfilename}
echo "set multiplot layout 4,3" >> ${plotfilename}
echo "set size ratio -1" >> ${plotfilename}
echo "set xlabel 'Easting (x1000 km)'" >> ${plotfilename}
echo "set ylabel 'Northing (x1000 km)'" >> ${plotfilename}
echo "set ytics 1; set xtics 1" >> ${plotfilename}
echo "set cblabel offset 0.5" >> ${plotfilename}
echo "set key at graph 0.365, graph 0.95 reverse" >> ${plotfilename}

#echo "set title '{/Symbol D}{/Helvetica-Italic H} from snowfall (cm) between March 14 and March 19, 2022'" >> ${plotfilename}
echo "set cblabel '{/Symbol D}{/Helvetica-Italic H} from snowfall (cm)'" >> ${plotfilename}
echo "set palette positive defined ( 0 '#FFFFE5', 1 '#FFF7BC', 2 '#FEE391', 3 '#FEC44F', 4 '#FE9929', 5 '#EC7014', 6 '#CC4C02', 7 '#8C2D04' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[0:*]" >> ${plotfilename}
echo "set label 1 '(a)' at graph -0.2, 1.03 font ',40'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):(\$${dhs_snow}/10.) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' title 'Dome C'" >> ${plotfilename}

#echo "set title '{/Symbol D}{/Helvetica-Italic H} from snowfall, deviation from climatology (cm) between March 14 and March 19, 1980-2021'" >> ${plotfilename}
echo "set cblabel '{/Symbol D}{/Helvetica-Italic H} from snowfall anomaly (cm)'" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set label 1 '(b)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${dhs_snow} - \$${dhs_snow_clim})/10.) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title '{/Symbol D}{/Helvetica-Italic H} from snowfall {/Helvetica-Italic Z}-score between March 14 and March 19, 2022'" >> ${plotfilename}
echo "set cblabel '{/Symbol D}{/Helvetica-Italic H} from snowfall {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set palette positive defined ( -10 '#B2182B', -7.333333 '#D6604D', -4.6666667 '#F4A582', -2 '#FDDBC7', -1.999999 '#CCCCCC', 1.99999 '#CCCCCC', 2 '#D1E5F0', 4.666667 '#92C5DE', 7.333333 '#4393C3', 10 '#2166AC' )" >> ${plotfilename}
echo "set cbrange[-10:10]" >> ${plotfilename}
echo "set label 1 '(c)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${dhs_snow} - \$${dhs_snow_clim})/\$${dhs_snow_clim_sd}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}


#echo "set title '{/Symbol D}{/Helvetica-Italic H} from sublimation (mm) between March 14 and March 19, 2022'" >> ${plotfilename}
echo "set cblabel '{/Symbol D}{/Helvetica-Italic H} from deposition (mm)'" >> ${plotfilename}
echo "set palette positive defined ( 0 '#FFFFE5', 1 '#FFF7BC', 2 '#FEE391', 3 '#FEC44F', 4 '#FE9929', 5 '#EC7014', 6 '#CC4C02', 7 '#8C2D04' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
#echo "set cbrange[-10:10]" >> ${plotfilename}
echo "set label 1 '(d)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):(\$${dhs_subl}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title '{/Symbol D}{/Helvetica-Italic H} from sublimation, deviation from climatology (mm) between March 14 and March 19, 1980-2021'" >> ${plotfilename}
echo "set cblabel '{/Symbol D}{/Helvetica-Italic H} from deposition anomaly (mm)'" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-6:6]" >> ${plotfilename}
echo "set label 1 '(e)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):(\$${dhs_subl}-\$${dhs_subl_clim}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title '{/Symbol D}{/Helvetica-Italic H} from sublimation {/Helvetica-Italic Z}-score between March 14 and March 19, 2022'" >> ${plotfilename}
echo "set cblabel '{/Symbol D}{/Helvetica-Italic H} from deposition {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set palette positive defined ( -30 '#B2182B', -20.6666667 '#D6604D', -11.3333333 '#F4A582', -2 '#FDDBC7', -1.999999 '#CCCCCC', 1.99999 '#CCCCCC', 2 '#D1E5F0', 11.3333333 '#92C5DE', 20.666667 '#4393C3', 30 '#2166AC' )" >> ${plotfilename}
echo "set cbrange[-30:30]" >> ${plotfilename}
echo "set label 1 '(f)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${dhs_subl}-\$${dhs_subl_clim})/\$${dhs_subl_clim_sd}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}


#echo "set title '{/Symbol D}{/Helvetica-Italic H} from settling (cm) between March 14 and March 19, 2022'" >> ${plotfilename}
echo "set cblabel '{/Symbol D}{/Helvetica-Italic H} from settling (cm)'" >> ${plotfilename}
echo "set palette positive defined ( 0 '#FFFFE5', 1 '#FFF7BC', 2 '#FEE391', 3 '#FEC44F', 4 '#FE9929', 5 '#EC7014', 6 '#CC4C02', 7 '#8C2D04' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set label 1 '(g)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${dhs_sett})/10.) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title '{/Symbol D}{/Helvetica-Italic H} from settling, deviation from climatology (cm) between March 14 and March 19, 1980-2021'" >> ${plotfilename}
echo "set cblabel '{/Symbol D}{/Helvetica-Italic H} from settling anomaly (cm)'" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-8:8]" >> ${plotfilename}
echo "set label 1 '(h)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${dhs_sett}-\$${dhs_sett_clim})/10.) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title '{/Symbol D}{/Helvetica-Italic H} from settling {/Helvetica-Italic Z}-score between March 14 and March 19, 2022'" >> ${plotfilename}
echo "set cblabel '{/Symbol D}{/Helvetica-Italic H} from settling {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set palette positive defined ( -10 '#B2182B', -7.333333 '#D6604D', -4.6666667 '#F4A582', -2 '#FDDBC7', -1.999999 '#CCCCCC', 1.99999 '#CCCCCC', 2 '#D1E5F0', 4.666667 '#92C5DE', 7.333333 '#4393C3', 10 '#2166AC' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-10:10]" >> ${plotfilename}
echo "set label 1 '(i)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${dhs_sett}-\$${dhs_sett_clim})/\$${dhs_sett_clim_sd}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}


#echo "set title '{/Symbol D}{/Helvetica-Italic H} from wind compaction (cm) between March 14 and March 19, 2022'" >> ${plotfilename}
echo "set cblabel '{/Symbol D}{/Helvetica-Italic H} from wind compaction (cm)'" >> ${plotfilename}
echo "set palette negative defined ( 0 '#FFFFE5', 1 '#FFF7BC', 2 '#FEE391', 3 '#FEC44F', 4 '#FE9929', 5 '#EC7014', 6 '#CC4C02', 7 '#8C2D04' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set label 1 '(j)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):(\$${dhs_redepo}/10.) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title '{/Symbol D}{/Helvetica-Italic H} from wind compaction, deviation from climatolgy (cm) between March 14 and March 19, 1980-2021'" >> ${plotfilename}
echo "set cblabel '{/Symbol D}{/Helvetica-Italic H} from wind compaction anomaly (cm)'" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-80:80]" >> ${plotfilename}
echo "set label 1 '(k)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${dhs_redepo}-\$${dhs_redepo_clim})/10.) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title '{/Symbol D}{/Helvetica-Italic H} from wind compaction {/Helvetica-Italic Z}-score between March 14 and March 19, 2022'" >> ${plotfilename}
echo "set cblabel '{/Symbol D}{/Helvetica-Italic H} from wind compaction {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set palette positive defined ( -15 '#B2182B', -10.666666667 '#D6604D', -6.3333333 '#F4A582', -2 '#FDDBC7', -1.999999 '#CCCCCC', 1.99999 '#CCCCCC', 2 '#D1E5F0', 6.3333333 '#92C5DE', 10.666666667 '#4393C3', 15 '#2166AC' )" >> ${plotfilename}
echo "set cbrange[-15:15]" >> ${plotfilename}
echo "set label 1 '(l)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${dhs_redepo}-\$${dhs_redepo_clim})/\$${dhs_redepo_clim_sd}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

gnuplot ${plotfilename}









ftp="rho.txt"		# File to plot


# Search for the columns to use for plotting:
easting=$(head -1 ${ftp} | mawk -v s="easting" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
northing=$(head -1 ${ftp} | mawk -v s="northing" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
eb=$(head -1 ${ftp} | mawk -v s="energy_balance_(W/m2)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
rho_10cm1=$(head -1 ${ftp} | mawk -v s="rho1_10cm_(kg/m3)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
rho_10cm2=$(head -1 ${ftp} | mawk -v s="rho2_10cm_(kg/m3)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
rho_10cm_clim=$(head -1 ${ftp} | mawk -v s="rho_10cm_clim_(kg/m3)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
rho_10cm_clim_sd=$(head -1 ${ftp} | mawk -v s="rho_10cm_clim_sd_(kg/m3)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')

rho_100cm1=$(head -1 ${ftp} | mawk -v s="rho1_100_cm_(kg/m3)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
rho_100cm2=$(head -1 ${ftp} | mawk -v s="rho2_100_cm_(kg/m3)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
rho_100cm_clim=$(head -1 ${ftp} | mawk -v s="rho_100_cm_clim_(kg/m3)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')
rho_100cm_clim_sd=$(head -1 ${ftp} | mawk -v s="rho_100_cm_clim_sd_(kg/m3)" '{for(i=1; i<=NF; i++) {if($i==s) {print i; exit}}}')




plotfilename=plots/drho_event
echo "set term pdf size 16,26.4 font 'Helvetica,34'" > ${plotfilename}
echo "set encoding iso_8859_1" >> ${plotfilename}
echo "set datafile missing \"-999\"" >> ${plotfilename}
echo "set output '${plotfilename}.pdf'" >> ${plotfilename}
echo "set multiplot layout 4,2" >> ${plotfilename}
echo "set size ratio -1" >> ${plotfilename}
echo "set xlabel 'Easting (x1000 km)'" >> ${plotfilename}
echo "set ylabel 'Northing (x1000 km)'" >> ${plotfilename}
echo "set ytics 1; set xtics 1" >> ${plotfilename}
echo "set cblabel offset 0.5" >> ${plotfilename}
echo "set key at graph 0.365, graph 0.95 reverse" >> ${plotfilename}

#echo "set title 'Uppermost 10 cm density anomaly on March 14'" >> ${plotfilename}
echo "set cblabel 'March 14 0.1 m density anomaly (kg m^{-3})'" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-200:200]" >> ${plotfilename}
echo "set label 1 '(a)' at graph -0.2, 1.03 font ',40'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${rho_10cm1}-\$${rho_10cm_clim})) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' title 'Dome C'" >> ${plotfilename}

#echo "set title 'Uppermost 10 cm density anomaly on March 19'" >> ${plotfilename}
echo "set cblabel 'March 19 0.1 m density anomaly (kg m^{-3})'" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-200:200]" >> ${plotfilename}
echo "set label 1 '(b)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${rho_10cm2}-\$${rho_10cm_clim})) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title '{/Helvetica-Italic Z}-score of the uppermost 10 cm density anomaly on March 14'" >> ${plotfilename}
echo "set cblabel 'March 14 0.1 m density {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set palette positive defined ( -6 '#B2182B', -4.66666667 '#D6604D', -3.33333333 '#F4A582', -2 '#FDDBC7', -1.999999 '#CCCCCC', 1.99999 '#CCCCCC', 2 '#D1E5F0', 3.3333333 '#92C5DE', 4.66666667 '#4393C3', 6 '#2166AC' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-6:6]" >> ${plotfilename}
echo "set label 1 '(c)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${rho_10cm1}-\$${rho_10cm_clim})/\$${rho_10cm_clim_sd}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title '{/Helvetica-Italic Z}-score of the uppermost 10 cm density anomaly on March 19'" >> ${plotfilename}
echo "set cblabel 'March 19 0.1 m density {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set palette positive defined ( -20 '#B2182B', -12.666666667 '#D6604D', -5.33333333 '#F4A582', -2 '#FDDBC7', -1.999999 '#CCCCCC', 1.99999 '#CCCCCC', 2 '#D1E5F0', 5.33333333 '#92C5DE', 12.666666667 '#4393C3', 20 '#2166AC' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-20:20]" >> ${plotfilename}
echo "set label 1 '(d)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${rho_10cm2}-\$${rho_10cm_clim})/\$${rho_10cm_clim_sd}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}


#echo "set title 'Uppermost 100 cm density anomaly on March 14'" >> ${plotfilename}
echo "set cblabel 'March 14 1 m density anomaly (kg m^{-3})'" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-200:200]" >> ${plotfilename}
echo "set label 1 '(e)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${rho_100cm1}-\$${rho_100cm_clim})) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title 'Uppermost 100 cm density anomaly on March 19'" >> ${plotfilename}
echo "set cblabel 'March 19 1 m density anomaly (kg m^{-3})'" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-200:200]" >> ${plotfilename}
echo "set label 1 '(f)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${rho_100cm2}-\$${rho_100cm_clim})) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title '{/Helvetica-Italic Z}-score of the uppermost 100 cm density anomaly on March 14'" >> ${plotfilename}
echo "set cblabel 'March 14 1 m density {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set palette positive defined ( -6 '#B2182B', -4.66666667 '#D6604D', -3.33333333 '#F4A582', -2 '#FDDBC7', -1.999999 '#CCCCCC', 1.99999 '#CCCCCC', 2 '#D1E5F0', 3.3333333 '#92C5DE', 4.66666667 '#4393C3', 6 '#2166AC' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-6:6]" >> ${plotfilename}
echo "set label 1 '(g)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${rho_100cm1}-\$${rho_100cm_clim})/\$${rho_100cm_clim_sd}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title '{/Helvetica-Italic Z}-score of the uppermost 100 cm density anomaly on March 19'" >> ${plotfilename}
echo "set cblabel 'March 19 1 m density {/Helvetica-Italic Z}-score'" >> ${plotfilename}
echo "set palette positive defined ( -20 '#B2182B', -12.666666667 '#D6604D', -5.33333333 '#F4A582', -2 '#FDDBC7', -1.999999 '#CCCCCC', 1.99999 '#CCCCCC', 2 '#D1E5F0', 5.33333333 '#92C5DE', 12.666666667 '#4393C3', 20 '#2166AC' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-20:20]" >> ${plotfilename}
echo "set label 1 '(h)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${rho_100cm2}-\$${rho_100cm_clim})/\$${rho_100cm_clim_sd}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

gnuplot ${plotfilename}



#
# Surface defined as uppermost 10 cm.
#
plotfilename=plots/drho_surface_event
echo "set term pdf size 16,13.2 font 'Helvetica,34'" > ${plotfilename}
echo "set encoding iso_8859_1" >> ${plotfilename}
echo "set datafile missing \"-999\"" >> ${plotfilename}
echo "set output '${plotfilename}.pdf'" >> ${plotfilename}
echo "set multiplot layout 2,2" >> ${plotfilename}
echo "set size ratio -1" >> ${plotfilename}
echo "set xlabel 'Easting (x1000 km)'" >> ${plotfilename}
echo "set ylabel 'Northing (x1000 km)'" >> ${plotfilename}
echo "set ytics 1; set xtics 1" >> ${plotfilename}
echo "set cblabel offset 0.5" >> ${plotfilename}
echo "set key at graph 0.365, graph 0.95 reverse" >> ${plotfilename}

#echo "set title 'Uppermost 10 cm density anomaly on March 14'" >> ${plotfilename}
echo "set cblabel 'March 14 surface density anomaly (kg m^{-3})' offset 0,-0.1" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-200:200]" >> ${plotfilename}
echo "set label 1 '(a)' at graph -0.2, 1.03 font ',40'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${rho_10cm1}-\$${rho_10cm_clim})) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' title 'Dome C'" >> ${plotfilename}

#echo "set title 'Uppermost 10 cm density anomaly on March 19'" >> ${plotfilename}
echo "set cblabel 'March 19 surface density anomaly (kg m^{-3})' offset 0,-0.1" >> ${plotfilename}
echo "set palette negative defined ( 0 '#B35806', 1 '#E08214', 2 '#FDB863', 3 '#FEE0B6', 4 '#D8DAEB', 5 '#B2ABD2', 6 '#8073AC', 7 '#542788' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-200:200]" >> ${plotfilename}
echo "set label 1 '(b)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${rho_10cm2}-\$${rho_10cm_clim})) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title '{/Helvetica-Italic Z}-score of the uppermost 10 cm density anomaly on March 14'" >> ${plotfilename}
echo "set cblabel 'March 14 surface density {/Helvetica-Italic Z}-score' offset 0,0" >> ${plotfilename}
echo "set palette positive defined ( -6 '#B2182B', -4.66666667 '#D6604D', -3.33333333 '#F4A582', -2 '#FDDBC7', -1.999999 '#CCCCCC', 1.99999 '#CCCCCC', 2 '#D1E5F0', 3.3333333 '#92C5DE', 4.66666667 '#4393C3', 6 '#2166AC' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-6:6]" >> ${plotfilename}
echo "set label 1 '(c)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${rho_10cm1}-\$${rho_10cm_clim})/\$${rho_10cm_clim_sd}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

#echo "set title '{/Helvetica-Italic Z}-score of the uppermost 10 cm density anomaly on March 19'" >> ${plotfilename}
echo "set cblabel 'March 19 surface density {/Helvetica-Italic Z}-score' offset 0,0" >> ${plotfilename}
echo "set palette positive defined ( -20 '#B2182B', -12.666666667 '#D6604D', -5.33333333 '#F4A582', -2 '#FDDBC7', -1.999999 '#CCCCCC', 1.99999 '#CCCCCC', 2 '#D1E5F0', 5.33333333 '#92C5DE', 12.666666667 '#4393C3', 20 '#2166AC' )" >> ${plotfilename}
echo "set autoscale cb" >> ${plotfilename}
echo "set cbrange[-20:20]" >> ${plotfilename}
echo "set label 1 '(d)'" >> ${plotfilename}
echo "pl '${ftp}' u (\$${easting}/1000000.):(\$${northing}/1000000.):((\$${rho_10cm2}-\$${rho_10cm_clim})/\$${rho_10cm_clim_sd}) w p palette pt 7 ps .7 notitle, '<(echo 1.359993 -0.894443)' w p pt 7 ps 2 lc rgb 'red' notitle" >> ${plotfilename}

gnuplot ${plotfilename}
