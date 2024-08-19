#!/bin/bash

# CDO module load
module load CDO/2.1.1-gompi-2021a

# Here we use the IRR01 (first ensemble member of tranirr) from NorESM as the example. For other models or ensemble members, adjustments are needed

# Select the QIRRIG variable from h0 (monthly mean) files
mkdir QIRRIG
for file in *h0*
do
	cdo selname,QIRRIG $file QIRRIG/$file"_QIRRIG"
done

cd QIRRIG

# Merge the yearly files to 10-year period
cdo mergetime *clm2.h0.190[1-9]* *clm2.h0.1910* 		NorESM.IRR.001.clm.h0.1901_1910.nc_QIRRIG
cdo mergetime *clm2.h0.191[1-9]* *clm2.h0.1920* 		NorESM.IRR.001.clm.h0.1911_1920.nc_QIRRIG
cdo mergetime *clm2.h0.192[1-9]* *clm2.h0.1930* 		NorESM.IRR.001.clm.h0.1921_1930.nc_QIRRIG
cdo mergetime *clm2.h0.193[1-9]* *clm2.h0.1940* 		NorESM.IRR.001.clm.h0.1931_1940.nc_QIRRIG
cdo mergetime *clm2.h0.194[1-9]* *clm2.h0.1950* 		NorESM.IRR.001.clm.h0.1941_1950.nc_QIRRIG
cdo mergetime *clm2.h0.195[1-9]* *clm2.h0.1960* 		NorESM.IRR.001.clm.h0.1951_1960.nc_QIRRIG
cdo mergetime *clm2.h0.196[1-9]* *clm2.h0.1970* 		NorESM.IRR.001.clm.h0.1961_1970.nc_QIRRIG
cdo mergetime *clm2.h0.197[1-9]* *clm2.h0.1980* 		NorESM.IRR.001.clm.h0.1971_1980.nc_QIRRIG
cdo mergetime *clm2.h0.198[1-4]* 						NorESM.IRR.001.clm.h0.1981_1984.nc_QIRRIG
cdo mergetime *clm2.h0.198[5-9]* *clm2.h0.199[0-4]* 	NorESM.IRR.001.clm.h0.1985_1994.nc_QIRRIG
cdo mergetime *clm2.h0.199[5-9]* *clm2.h0.200[0-4]* 	NorESM.IRR.001.clm.h0.1995_2004.nc_QIRRIG
cdo mergetime *clm2.h0.200[5-9]* *clm2.h0.201[0-4]* 	NorESM.IRR.001.clm.h0.2005_2014.nc_QIRRIG

# Merge the 10-year files to 30-year files (for map plotting) and 114-year file (for timeseries plotting)
cdo mergetime NorESM.IRR.001*1901_1910* NorESM.IRR.001*1911_1920* NorESM.IRR.001*1921_1930* 	NorESM_IRR01_QIRRIG_1901_1930.nc
cdo mergetime NorESM.IRR.001*1985_1994* NorESM.IRR.001*1995_2004* NorESM.IRR.001*2005_2014* 	NorESM_IRR01_QIRRIG_1985_2014.nc
cdo mergetime NorESM.IRR.001.clm.h0.* 															NorESM_IRR01_QIRRIG_1901_2014.nc

# For 30-year files, do all-time mean calculation, and for the 114-year file, do year mean calculation
cdo timmean NorESM_IRR01_QIRRIG_1901_1930.nc 	NorESM_IRR01_QIRRIG_timmean_1901_1930.nc
cdo timmean NorESM_IRR01_QIRRIG_1985_2014.nc 	NorESM_IRR01_QIRRIG_timmean_1985_2014.nc
cdo yearmean NorESM_IRR01_QIRRIG_1901_2014.nc 	NorESM_IRR01_QIRRIG_yearmean_1901_2014.nc

# unit mm/s -> mm/year
cdo mulc,31536000 NorESM_IRR01_QIRRIG_timmean_1901_1930.nc 		NorESM_IRR01_YEARLYQIRRIG_timmean_1901_1930.nc
cdo mulc,31536000 NorESM_IRR01_QIRRIG_timmean_1985_2014.nc 		NorESM_IRR01_YEARLYQIRRIG_timmean_1985_2014.nc
cdo mulc,31536000 NorESM_IRR01_QIRRIG_yearmean_1901_2014.nc 	NorESM_IRR01_YEARLYQIRRIG_yearmean_1901_2014.nc

# calculate the mean value among three ensemble members
# for tranirr
cdo ensmean NorESM_IRR01_YEARLYQIRRIG_timmean_1901_1930.nc NorESM_IRR02_YEARLYQIRRIG_timmean_1901_1930.nc NorESM_IRR03_YEARLYQIRRIG_timmean_1901_1930.nc 		NorESM_IRR_YEARLYQIRRIG_timmean_1901_1930.nc
cdo ensmean NorESM_IRR01_YEARLYQIRRIG_timmean_1985_2014.nc NorESM_IRR02_YEARLYQIRRIG_timmean_1985_2014.nc NorESM_IRR03_YEARLYQIRRIG_timmean_1985_2014.nc 		NorESM_IRR_YEARLYQIRRIG_timmean_1985_2014.nc
cdo ensmean NorESM_IRR01_YEARLYQIRRIG_yearmean_1901_2014.nc NorESM_IRR02_YEARLYQIRRIG_yearmean_1901_2014.nc NorESM_IRR03_YEARLYQIRRIG_yearmean_1901_2014.nc 	NorESM_IRR_YEARLYQIRRIG_yearmean_1901_2014.nc
# for 1901irr
cdo ensmean NorESM_NOI01_YEARLYQIRRIG_timmean_1901_1930.nc NorESM_NOI02_YEARLYQIRRIG_timmean_1901_1930.nc NorESM_NOI03_YEARLYQIRRIG_timmean_1901_1930.nc 		NorESM_NOI_YEARLYQIRRIG_timmean_1901_1930.nc
cdo ensmean NorESM_NOI01_YEARLYQIRRIG_timmean_1985_2014.nc NorESM_NOI02_YEARLYQIRRIG_timmean_1985_2014.nc NorESM_NOI03_YEARLYQIRRIG_timmean_1985_2014.nc 		NorESM_NOI_YEARLYQIRRIG_timmean_1985_2014.nc
cdo ensmean NorESM_NOI01_YEARLYQIRRIG_yearmean_1901_2014.nc NorESM_NOI02_YEARLYQIRRIG_yearmean_1901_2014.nc NorESM_NOI03_YEARLYQIRRIG_yearmean_1901_2014.nc 	NorESM_NOI_YEARLYQIRRIG_yearmean_1901_2014.nc

# remap the file to 0.9 x 1.25
for file in *_timmean
do
	cdo remapcon2,0.9x1.25_SCRIP_desc.181018.nc $file $file"_0.9x1.25"
done