clear all
set mem 500m
set more off

global compiled "~/Dropbox/Public"
global out "~/Dropbox/github/danhammer/epa-emissions/data"

cd $compiled

use compiled.dta, clear

* keep relevant variables
keep model_year mfrname vehicle_id curb_weight test_number representedtestvehmodel tstprocdesc fueltyp ulife emission rnd_emission_result standard hybrid*

* numerically encode test procedure
encode tstprocdesc, generate(testproc)
drop tstprocdesc

* recode hybrid dummy from string Y/N
gen hybrid = hybrid_yn == "Y"
drop hybrid_yn

save temp, replace

******************************************
* create vehicle characteristic data set *
******************************************

* keep relevant variables
keep model_year mfrname vehicle_id curb_weight hybrid fueltyp ulife repre* test_number

* consider only full-life emissions standards, 10-years or 120,000 miles, whichever comes first
* the full-life emissions tests/standards are denoted with ulife == 120 (1000's of miles)
keep if ulife == 120
duplicates drop

* There are sometimes multiple tests for the same vehicle.
* There are also vehicles (same exact car, not just same model) that are tested with different fuel types (not constant within vehicles)
* collect the constant characteristics
drop test_number ulife fueltyp
duplicates drop

drop if vehicle_id == ""

* rename and label variables
rename model_year year
label var year "Model year"

label var mfrname "Manufacturer name"

rename representedtestvehmodel model
label var model "Vehicle model"

rename curb_weight weight
label var weight "Curb weight (lbs)"

label var hybrid "Hybrid (1 == yes / 0 == no)"

sort vehicle_id
save $out/car-characteristics.dta, replace

*****************************
* create emissions data set *
*****************************

use temp, clear
keep if ulife == 120
keep vehicle_id emission rnd_emission_result fueltyp testproc 
rename rnd_emission_result res_
drop if vehicle_id == ""

duplicates drop vehicle_id fueltyp testproc emission, force

replace emission = "HC_NM" if emission == "HC-NM"
replace emission = "HC_NM_NOX_COMP" if emission == "HC-NM+NOX-COMP" 
replace emission = "HC_TOTAL" if emission == "HC-TOTAL" 
replace emission = "OPT_CREE" if emission == "OPT-CREE" 
replace emission = "PM_COMP" if emission == "PM-COMP" 

reshape wide res_, i(vehicle_id fueltyp testproc) j(emission) string
compress
save $out/emissions_out.dta, replace















