 import excel "C:\Users\glk22nhj\OneDrive - Bangor University\CRA\FINAL_DATA .xlsx", sheet("data") firstrow
reshape long Moodyrating SPrating ESG GDPperCapita Unemployment CurrentAccountBalance GovernmentEffectiveness Inflation, i(ISO3) j(year)
ssc install asdoc
asdoc pwcorr ESG GDPperCapita Unemployment CurrentAccountBalance GovernmentEffectiveness Inflation
asdoc pwcorr ESG GDPperCapita Unemployment CurrentAccountBalance Inflation
gen averating = ( Moodyrating + SPrating )/2
asdoc regress averating ESG GDPperCapita CurrentAccountBalance Unemployment Inflation, robust
asdoc regress averating ESG GDPperCapita Unemployment Inflation, robust
asdoc sum ESG GDPperCapita Unemployment GovernmentEffectiveness Inflation averating Moodyrating SPrating