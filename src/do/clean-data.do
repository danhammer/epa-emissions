clear all
set mem 500m
set more off

global basedir "~/Dropbox/github/danhammer/epa-emissions"
global tempdir "/tmp"

cd $basedir

*** 2010

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
save $tempdir/temp, replace

*** 2011

insheet using "data/raw/11actrr.csv", comma clear
append using $tempdir/temp
save $tempdir/temp, replace

*** 2012

insheet using "data/raw/12actrr.csv", comma clear
append using $tempdir/temp
save $tempdir/temp, replace

*** 2013

insheet using "data/raw/13actrr.csv", comma clear
append using $tempdir/temp

compress
save $basedir/data/compiled.dta, replace
