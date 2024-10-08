# IRRMIP

Data post-processing include two parts: bash shell codes with CDO (Climate Data Operation) for the primary processing, and python codes for (moist-)heat metrics calculation and plotting

CDO bash shell codes include three files:

**CDO_scripts_Irrigation_Water_Withdrawal.sh**

Get irrigation water withdrawal variable from monthly files

**CDO_scripts_Energy_Fluxes.sh**

Get energy variables from daily files

**CDO_scripts_Temperature_Humidity_Wind_3_hourly_.sh**

Get meteology variables used for moist-heat calculation from 3-hourly files


Note that the code in these files normally use one ensemble member and one model as the example, so some adjustments are needed (solely changing the file name).


Moist-heat metrics are calculated by:

**Metric_calcu_CESM2_CESM2_gw_NorESM.ipynb**

**Metric_calcu_CNRM.ipynb**

**Metric_calcu_E3SM.ipynb**

**Metric_calcu_IPSL.ipynb**

Similarily, the code in these files normally use one ensemble member and one model as the example, so some adjustments are needed (solely changing the file name).

The value of the percentile quantiles calculations are done by:

**ProbabilityValue_calcu_CESM2.ipynb**

**ProbabilityValue_calcu_CESM2_gw.ipynb**

**ProbabilityValue_calcu_CNRM.ipynb**

**ProbabilityValue_calcu_E3SM.ipynb**

**ProbabilityValue_calcu_IPSL.ipynb**

**ProbabilityValue_calcu_NorESM_par1.ipynb**

**ProbabilityValue_calcu_NorESM_par2.ipynb**

**ProbabilityValue_calcu_NorESM_par3.ipynb**


Probability ratio calculations are done by:

**ProbabilityRatio_calcu_CESM2.ipynb**

**ProbabilityRatio_calcu_CESM2_gw.ipynb**

**ProbabilityRatio_calcu_CNRM.ipynb**

**ProbabilityRatio_calcu_E3SM.ipynb**

**ProbabilityRatio_calcu_IPSL.ipynb**

**ProbabilityRatio_calcu_NorESM_par1.ipynb**

**ProbabilityRatio_calcu_NorESM_par2.ipynb**

**ProbabilityRatio_calcu_NorESM_par3.ipynb**

Hours of moist-heat events of different groups of grid cells are calculated by:

**Event_hours_calcu_CESM2_CESM2_gw_NorESM.ipynb**

**Event_hours_calcu_CNRM.ipynb**

**Event_hours_calcu_E3SM.ipynb**

**Event_hours_calcu_IPSL.ipynb**

For plottings, see:

**Plot_irrigated_fraction_and_irrigation_water_withdrawal_maps.ipynb**

**Plot_irrigated_fraction_and_irrigation_water_withdrawal_timeseries.ipynb**

**Plot_Energy_flux_maps.ipynb**

**Plot_Probability_Ratio.ipynb**

**Plot_Probability_Value.ipynb**

**Plot_Event_hours_timeseries.ipynb**
