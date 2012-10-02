clear all
set mem 500m
set more off

global basedir "~/Dropbox/github/danhammer/epa-emissions"
global outdir "~/Dropbox/Public"
global tempdir "/tmp"

cd $basedir
rm $tempdir/class-a.dta


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
save $tempdir/class-ab, replace

*** 2010
*** CLASS III

insheet using "data/raw/10actrr.csv", comma clear
drop v??

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
*** CLASS III

insheet using "data/raw/11actrr.csv", comma clear
append using $tempdir/temp
save $tempdir/class-c, replace

*** 2012
*** CLASS III

insheet using "data/raw/12actrr.csv", comma clear
append using $tempdir/temp
save $tempdir/class-c, replace

*** 2013
*** CLASS III

insheet using "data/raw/13actrr.csv", comma clear
append using $tempdir/temp

compress
save $outdir/compiled.dta, replace
