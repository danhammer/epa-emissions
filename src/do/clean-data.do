clear all
set mem 500m
set more off

global basedir "~/Dropbox/github/danhammer/epa-emissions"
global outdir "~/Dropbox/Public"
global tempdir "/tmp"

cd $basedir

*** 2004
*** CLASS A

insheet using "data/raw/04actrr.txt", clear
gen model_year = 2004
save $tempdir/class-a, replace

*** 2005
*** CLASS A

insheet using "data/raw/05actrr.txt", clear
gen model_year = 2005
append using $tempdir/class-a
save $tempdir/class-a, replace

*** 2006
*** CLASS A

insheet using "data/raw/06actrr.csv", comma clear
gen model_year = 2006
append using $tempdir/class-a
save $tempdir/class-a, replace

*** 2007
*** CLASS A

insheet using "data/raw/07actrr.txt", clear
gen model_year = 2007
append using $tempdir/class-a
save $tempdir/class-a, replace

*** 2008
*** CLASS A

insheet using "data/raw/08actrr.txt", clear
gen model_year = 2008
append using $tempdir/class-a
save $tempdir/class-a, replace

*** 2009
*** CLASS B

local varlist "mfrcd mfrname enginefamily efsys evapfamily evfsys division carline ecsev displ tran etw axratio dynohp targetcoeffa targetcoeffb targetcoeffc setcoeffa setcoeffb setcoeffc tstprc tstprocdesc fueltyp fueltypedescription salesarea ulife emission certlevel standard tier multdf adddf"

insheet using "data/raw/09actrr.csv", comma clear
renames vi_mfr_cd - esx_add_df_qty \ `varlist'
gen model_year = 2009
save $tempdir/class-b, replace
append using $tempdir/class-a
replace ulife = "" if ulife == "N/A"
destring ulife, replace
save $tempdir/class-ab, replace

*** 2010
*** CLASS C

insheet using "data/raw/10actrr.csv", comma clear
drop v??
replace model_year = "2010"

* strange observation, all screwed up
drop if cert_level == "F" 
destring cert_level, replace
destring emission_standard, replace
destring add_df, replace
destring mult_df, replace
destring react_factor, replace
destring dwn_diesel_adj_factor, replace
destring up_diesel_adj_factor, replace
destring react_factor, replace
save $tempdir/class-c, replace

*** 2011
*** CLASS C

insheet using "data/raw/11actrr.csv", comma clear
replace model_year = "2011"
append using $tempdir/class-c
save $tempdir/class-c, replace

*** 2012
*** CLASS C

insheet using "data/raw/12actrr.csv", comma clear
replace model_year = "2012"
append using $tempdir/class-c
save $tempdir/class-c, replace

*** 2013
*** CLASS C

insheet using "data/raw/13actrr.csv", comma clear
replace model_year = "2013"
append using $tempdir/class-c

*** fix class C 

use $tempdir/class-c, clear
destring model_year, replace
rename cert_mfr_nm mfrname
rename targetcoefalbf targetcoeffa
rename targetcoefblbfmph targetcoeffb
rename targetcoefclbfmph2 targetcoeffc
rename setcoefalbf setcoeffa
rename setcoefblbfmph setcoeffb
rename setcoefclbfmph2 setcoeffc
rename displacement displ
rename mult_df multdf
rename add_df adddf
rename useful_life_miles ulife
rename test_proc testprc
rename emission_name emission
rename cert_level certlevel
rename emission_standard standard
rename cert_region salesarea
rename standard_lvl tier
rename test_proc_desc tstprocdesc
rename test_fuel fueltyp
rename certified_testgroup enginefamily
rename certified_evap_family evapfamily

drop *_desc

append using $tempdir/class-ab
compress
save $outdir/compiled.dta, replace


rm $tempdir/class-a.dta
rm $tempdir/class-b.dta
rm $tempdir/class-ab.dta
rm $tempdir/class-c.dta



* emissions of differnt vehicles of nox and different polutions
* hybrid, diesel, 

* by car, wide form, total emissions -- hybrid

* at what part of the country, should you buy diesel, hybrid,

* metric for should is cost.  mendelsohn.  

* what do the rnd* variable mean? cert_level and standard?  what does the id mean?  testprc?
* what different tests are there for testprc?  tab testprc?
* fuel type, vehicle class, -- what does vehicle class mean?
* ulife
* emission
* rnd emission


* vars of interest: year model curbweight idvariable hybrid fueltype 









