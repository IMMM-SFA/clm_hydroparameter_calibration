[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7039118.svg)](https://doi.org/10.5281/zenodo.7039118)

# Yan et al 2022

**A benchmark Community Land Model Version 5 (CLM5) large ensemble dataset to support hydrological applications over the Conterminous United States.**

Yan, Hongxiang<sup>1</sup>
Sun, Ning<sup>1</sup>
Eldardiry, Hisham<sup>1</sup>
Thurber, Travis<sup>1</sup>
Reed, Patrick M.<sup>2</sup>
Malek, Keyvan<sup>2</sup>
Gupta, Rohini S.<sup>2</sup>
Kennedy, Daniel<sup>3</sup>
Swenson, Sean<sup>3</sup>
Vernon, Chris R.<sup>1</sup>
Burleyson, Casey D.<sup>1</sup>
Rice, Jennie S.<sup>1</sup>

1. Pacific Northwest National Laboratory
2. Cornell University
3. National Center for Atmospheric Research

## Abstract

Land surface models such as Community Land Model Version 5 (CLM5) are essential tools for simulating the behaviors of the terrestrial system. Despite the extensive application of CLM5, limited attention has been paid to the underlying uncertainties associated with its hydrologic parameters and the implications that these uncertainties have on water resources applications. To address this long-standing issue, we conduct a comprehensive hydrologic parameter uncertainty characterization (UC) of CLM5 over the hydroclimatic gradients of the Conterminous United States using five meteorological datasets. Key datasets produced from the UC experiment include a benchmark dataset of CLM5 default hydrological performance, parameter sensitivity identified for 28 hydrological metrics, and large ensemble outputs for hydrological predictions. The presented datasets can assist CLM5 calibration and to support broad applications such as evaluating vulnerabilities to droughts and floods. The dataset can be used to identify under what hydroclimate conditions parametric uncertainties demonstrate substantial effects on hydrological predictions and clarify where further investigations are needed to understand how land runoff uncertainties interact with other Earth system processes.


## Journal Reference

A benchmark Community Land Model Version 5 (CLM5) large ensemble dataset to support hydrological applications over the Conterminous United States. Yan et al. 2022. In preparation.


## Data Reference

### Input Data

Daymet: Daily Surface Weather Data on a 1-km Grid for North America, Version 4 https://doi.org/10.3334/ORNLDAAC/1840

Jones, A.D., Rastogi D., Vahmani P., Stansfield A., Reed K., Ullrich P., Rice J.S.: Thermodynamic Global Warming Simulations (v1.0.0) [Data set]. MSD-LIVE Data Repository. DOI TBD.

Livneh B., E.A. Rosenberg, C. Lin, B. Nijssen, V. Mishra, K.M. Andreadis, E.P. Maurer, and D.P. Lettenmaier, 2013: A Long-Term Hydrologically Based Dataset of Land Surface Fluxes and States for the Conterminous United States: Update and Extensions, Journal of Climate, 26, 9384⦣8364;⬓9392.

NLDAS project (2021), NLDAS Primary Forcing Data L4 Hourly 0.125 x 0.125 degree V2.0, Edited by David M. Mocko, NASA/GSFC/HSL, Greenbelt, Maryland, USA, Goddard Earth Sciences Data and Information Services Center (GES DISC), https://doi.org/10.5067/THUF4J1RLSYG

PRISM Climate Group, Oregon State University, https://prism.oregonstate.edu, data created 4 Feb 2014, accessed 16 Dec 2020.

### Derived and Output Data

Yan, H., Sun, N., Eldardiry, H., Thurber, T., Reed, P. M., Malek, K., Gupta, R. S., Kennedy, D., Swenson, S., Vernon, C. R., Burleyson, C. D., & Rice, J. S. (2022). CLM5 CAMELS Basins Ensemble (v0.0.2) [Data set]. MSD-LIVE Data Repository. https://doi.org/10.57931/1884563


## Code Reference

IM3 CLM (CLM version 5.1 modified with parameter tuning support):
CLM & IM3 Development Teams. (2022). IMMM-SFA/im3-clm: v1.0.0 (v1.0.0). Zenodo. https://doi.org/10.5281/zenodo.6653705

CLM5:
Lawrence, D. M., Fisher, R. A., Koven, C. D., Oleson, K. W., Swenson, S. C., Bonan, G., et al. (2019). The Community Land Model version 5: Description of new features, benchmarking, and impact of forcing uncertainty. Journal of Advances in Modeling Earth Systems, 11, 4245– 4287. https://doi.org/10.1029/2018MS001583


## Contributing Modeling Software

im3-clm
| Model | Version | Repository Link | DOI |
|-------|---------|-----------------|-----|
| im3-clm | v1.0.0 | https://github.com/immm-sfa/im3-clm | https://doi.org/10.5281/zenodo.6653705 |


## Reproduce the Experiment

`CLM_config.py`: python2 script used to build 1,500 CLM5 cases, change environmental variables, and submit cases.

`CLM_cdf2ascii.py`: python3 script used to extract basin runoff from CLM5 default netcdf varaibles; this will generate a time series of CLM5 runoff.

`gen_streamflow_CLM_usgs`: python3 script used to generate basin streamflow (m3/s) by including basin area and extract observed streamflow data from CAMELS data; this will generate a time series of CLM5 streamflow and observed streamflow for estimating different metrics.

`gen_default_flow_metrics.py`: python3 script used to generate metrics using default parameter CLM5 simulation.

`gen_LHS_flow_metrics_mp.py`: python3 script used to generate metrics for ensemble CLM5 simulation.


## Reproduce the Figures

`default.m`, `ensemble.m`, `SA_plot.m`: matlab script example used to produce default parameter performance figure, ensemble parameter performance figure, and sensitivity analysis figure
