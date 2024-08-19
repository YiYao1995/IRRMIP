#!/bin/bash

# CDO module load
module load CDO/2.1.1-gompi-2021a

# Here we use the first ensemble member from NorESM as the example. For other models or ensemble members, adjustments are needed
mkdir TSA 
mkdir RH2M
mkdir U10

# Select the TSA, RH2M and U10 variables from h7 (3-hourly) files
# TSA: 2-meter air temperature (name could be different for other models, same for following variables)
# RH2M: 2-meter relative humidity
# U10: 10-meter wind speed
for file in *h7*
do
	cdo selname,TSA $file 	TSA/$file"_TSA"
	cdo selname,RH2M $file 	RH2M/$file"_RH2M"
	cdo selname,U10 $file 	U10/$file"_U10"
done
# These variables will be used for moist-heat metrics calculation