# Download datafile
wget -c -O MARcst-AN35km-176x148.cdf "https://zenodo.org/records/5195636/files/MARcst-AN35km-176x148.cdf?download=1"

# Do some manipulations to bring all the dimensions back to x and y (i.e., renaming the X,Y dimensions to x,y)
ncks -v X,Y,RIGNOT,AIS MARcst-AN35km-176x148.cdf MARcst-AN35km-176x148_2.cdf
ncks -v x,y,AREA,GROUND,ICE,LAT,LON,ROCK,SH,SOL MARcst-AN35km-176x148.cdf MARcst-AN35km-176x148_1.cdf
ncrename -d X,x -v X,x MARcst-AN35km-176x148_2.cdf
ncrename -d Y,y -v Y,y MARcst-AN35km-176x148_2.cdf
cdo merge MARcst-AN35km-176x148_1.cdf MARcst-AN35km-176x148_2.cdf MARcst-AN35km-176x148.nc
rm MARcst-AN35km-176x148.cdf MARcst-AN35km-176x148_1.cdf MARcst-AN35km-176x148_2.cdf
