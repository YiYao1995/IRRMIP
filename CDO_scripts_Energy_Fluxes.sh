#!/bin/bash

# CDO module load
module load CDO/2.1.1-gompi-2021a

# Here we use the first ensemble member from NorESM as the example. For other models or ensemble members, adjustments are needed

# Select the QIRRIG variable from h1 (daily mean) files
# EFLX_LH_TOT: Latent Heat Flux (name could be different for other models, same for following variables)
# FSH: Sensible Heat Flux
# LWdown: Downwelling longwave radiation
# LWup: Upwelling longwave radiation
# SWdown: Downwelling shortwave radiation
# SWup: Upwelling shortwave radiation

mkdir EFLX_LH_TOT
mkdir FSH
mkdir LWdown
mkdir LWup
mkdir SWdown
mkdir SWup

for file in *.h1.*
do
	cdo selname,EFLX_LH_TOT $file 	EFLX_LH_TOT/$file"_EFLX_LH_TOT"
	cdo selname,FSH $file 			FSH/$file"_FSH"
	cdo selname,LWdown $file 		LWdown/$file"_LWdown"
	cdo selname,LWup $file 			LWup/$file"_LWup"
	cdo selname,SWdown $file 		SWdown/$file"_SWdown"
	cdo selname,SWup $file 			SWup/$file"_SWup"
done

# Now we use EFLX_LH_TOT, and still IRR01 (first ensemble member of tranirr) as an example, for other variables just change the name of variable
cd EFLX_LH_TOT/

# calculate the yearly mean value
for file in *
do
	cdo yearmean $file $file"_yearmean"
done

cdo mergetime *190[1-9]*yearmean *1910*yearmean 	NorESM.IRR.001.clm.h0.1901_1910.nc_EFLX_LH_TOT_yearmean
cdo mergetime *191[1-9]*yearmean *1920*yearmean 	NorESM.IRR.001.clm.h0.1911_1920.nc_EFLX_LH_TOT_yearmean
cdo mergetime *192[1-9]*yearmean *1930*yearmean 	NorESM.IRR.001.clm.h0.1921_1930.nc_EFLX_LH_TOT_yearmean
cdo mergetime *193[1-9]*yearmean *1940*yearmean 	NorESM.IRR.001.clm.h0.1931_1940.nc_EFLX_LH_TOT_yearmean
cdo mergetime *194[1-9]*yearmean *1950*yearmean 	NorESM.IRR.001.clm.h0.1941_1950.nc_EFLX_LH_TOT_yearmean
cdo mergetime *195[1-9]*yearmean *1960*yearmean 	NorESM.IRR.001.clm.h0.1951_1960.nc_EFLX_LH_TOT_yearmean
cdo mergetime *196[1-9]*yearmean *1970*yearmean 	NorESM.IRR.001.clm.h0.1961_1970.nc_EFLX_LH_TOT_yearmean
cdo mergetime *197[1-9]*yearmean *1980*yearmean 	NorESM.IRR.001.clm.h0.1971_1980.nc_EFLX_LH_TOT_yearmean
cdo mergetime *198[1-4]*yearmean 					NorESM.IRR.001.clm.h0.1981_1984.nc_EFLX_LH_TOT_yearmean
cdo mergetime *198[5-9]*yearmean *199[0-4]*yearmean NorESM.IRR.001.clm.h0.1985_1994.nc_EFLX_LH_TOT_yearmean
cdo mergetime *199[5-9]*yearmean *200[0-4]*yearmean NorESM.IRR.001.clm.h0.1995_2004.nc_EFLX_LH_TOT_yearmean
cdo mergetime *200[5-9]*yearmean *201[0-4]*yearmean NorESM.IRR.001.clm.h0.2005_2014.nc_EFLX_LH_TOT_yearmean

# Merge the 10-year files to 30-year files (for map plotting) and 114-year file (for timeseries plotting)
cdo mergetime NorESM.IRR.001*1901_1910*_EFLX_LH_TOT_yearmean NorESM.IRR.001*1911_1920*_EFLX_LH_TOT_yearmean NorESM.IRR.001*1921_1930*_EFLX_LH_TOT_yearmean NorESM_IRR01_EFLX_LH_TOT_1901_1930.nc
cdo mergetime NorESM.IRR.001*1985_1994*_EFLX_LH_TOT_yearmean NorESM.IRR.001*1995_2004*_EFLX_LH_TOT_yearmean NorESM.IRR.001*2005_2014*_EFLX_LH_TOT_yearmean NorESM_IRR01_EFLX_LH_TOT_1985_2014.nc
cdo mergetime NorESM.IRR.001.clm.h0.*_EFLX_LH_TOT_yearmean 																								   NorESM_IRR01_EFLX_LH_TOT_1901_2014.nc

# For 30-year files, do all-time mean calculation, and for the 114-year file, do year mean calculation
cdo timmean NorESM_IRR01_EFLX_LH_TOT_1901_1930.nc 		NorESM_IRR01_EFLX_LH_TOT_timmean_1901_1930.nc
cdo timmean NorESM_IRR01_EFLX_LH_TOT_1985_2014.nc 		NorESM_IRR01_EFLX_LH_TOT_timmean_1985_2014.nc
cdo yearmean NorESM_IRR01_EFLX_LH_TOT_1901_2014.nc 		NorESM_IRR01_EFLX_LH_TOT_yearmean_1901_2014.nc

# calculate the mean value among three ensemble members
# for tranirr
cdo ensmean NorESM_IRR01_EFLX_LH_TOT_timmean_1901_1930.nc NorESM_IRR02_EFLX_LH_TOT_timmean_1901_1930.nc NorESM_IRR03_EFLX_LH_TOT_timmean_1901_1930.nc 		NorESM_IRR_EFLX_LH_TOT_timmean_1901_1930.nc
cdo ensmean NorESM_IRR01_EFLX_LH_TOT_timmean_1985_2014.nc NorESM_IRR02_EFLX_LH_TOT_timmean_1985_2014.nc NorESM_IRR03_EFLX_LH_TOT_timmean_1985_2014.nc 		NorESM_IRR_EFLX_LH_TOT_timmean_1985_2014.nc
cdo ensmean NorESM_IRR01_EFLX_LH_TOT_yearmean_1901_2014.nc NorESM_IRR02_EFLX_LH_TOT_yearmean_1901_2014.nc NorESM_IRR03_EFLX_LH_TOT_yearmean_1901_2014.nc 	NorESM_IRR_EFLX_LH_TOT_yearmean_1901_2014.nc
# for 1901irr
cdo ensmean NorESM_NOI01_EFLX_LH_TOT_timmean_1901_1930.nc NorESM_NOI02_EFLX_LH_TOT_timmean_1901_1930.nc NorESM_NOI03_EFLX_LH_TOT_timmean_1901_1930.nc 		NorESM_NOI_EFLX_LH_TOT_timmean_1901_1930.nc
cdo ensmean NorESM_NOI01_EFLX_LH_TOT_timmean_1985_2014.nc NorESM_NOI02_EFLX_LH_TOT_timmean_1985_2014.nc NorESM_NOI03_EFLX_LH_TOT_timmean_1985_2014.nc 		NorESM_NOI_EFLX_LH_TOT_timmean_1985_2014.nc
cdo ensmean NorESM_NOI01_EFLX_LH_TOT_yearmean_1901_2014.nc NorESM_NOI02_EFLX_LH_TOT_yearmean_1901_2014.nc NorESM_NOI03_EFLX_LH_TOT_yearmean_1901_2014.nc 	NorESM_NOI_EFLX_LH_TOT_yearmean_1901_2014.nc

# remap the file to 0.9 x 1.25
for file in *_timmean
do
	cdo remapcon2,0.9x1.25_SCRIP_desc.181018.nc $file $file"_0.9x1.25"
done