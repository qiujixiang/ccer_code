*Fig. S1*
preserve
keep if a_80 ==1
ddtiming lnco2 treat_post , i(county_id) t(year) 
ddtiming lnpm25 treat_post , i(county_id) t(year) 
restore

*Fig. S2*
preserve
gen event = year - min_year
replace event =-5 if event < -5
replace event =5 if event > 5
*生成pre+post*
forvalues i=5(-1)1{
  gen ppre_`i'=(event==-`i'& treat==1)
}
gen current=(event==0 & treat==1)
forvalues i=1(1)5{
  gen ppost_`i'=(event==`i'& treat==1)
}
drop ppre_1
est clear
xtset county_id year
qui reghdfe lnco2 ppre_* current ppost_* lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store a1

matrix coef = e(b) //系数
matrix list coef
matrix cov = e(V) //协方差矩阵
matrix list cov 
gen coef = .
gen se = .
forvalues i = 1(1)10 {
 replace coef = coef[1,`i'] if _n==`i'
 replace se = sqrt(cov[`i',`i']) if _n==`i'
}
gen lb=coef-invttail(e(df_r),0.025)*se //置信区间下界
gen ub=coef+invttail(e(df_r),0.025)*se //置信区间上界
keep coef se lb ub
drop if coef == .
	
input 
0 0 0 0
end
	
gen year = _n
replace year = year - 6 if year < 5
replace year = year - 5 if year >= 5 & year < 11
replace year = -1 if year == 11
sort year	

twoway (connect coef year,color(gs1) msize(small)) ///
(line lb year,lwidth(thin) lpattern(dash) lcolor(gs2)) ///
(line ub year,lwidth(thin) lpattern(dash) lcolor(gs2)), ///
yline(0,lwidth(vthin) lpattern(dash) lcolor(teal)) ///
xline(0,lwidth(vthin) lpattern(dash) lcolor(teal)) ///
ylabel(-0.08(0.04)0.04,labsize(*0.85) angle(0)) xlabel(-5(1)5,labsize(*0.75)) ///
ytitle("{stSerif:Impact of CCER projects put into operation on ln(CO2)}", size(small)) ///
xtitle("{stSerif:Relative time of CCER projects put into operation}", size(small)) ///
scheme(s1mono) legend(size(vsmall) order(1 "{stSerif:Point Estimate}" 2 "{stSerif:95% CI}")) ///图例
graphregion(color(white)) //白底

restore

preserve
gen event = year - min_year
replace event =-5 if event < -5
replace event =5 if event > 5
*生成pre+post*
forvalues i=5(-1)1{
  gen ppre_`i'=(event==-`i'& treat==1)
}
gen current=(event==0 & treat==1)
forvalues i=1(1)5{
  gen ppost_`i'=(event==`i'& treat==1)
}
drop ppre_1
est clear
xtset county_id year
qui reghdfe lnpm25 ppre_* current ppost_* lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store a1

matrix coef = e(b) //系数
matrix list coef
matrix cov = e(V) //协方差矩阵
matrix list cov 
gen coef = .
gen se = .
forvalues i = 1(1)10 {
 replace coef = coef[1,`i'] if _n==`i'
 replace se = sqrt(cov[`i',`i']) if _n==`i'
}
gen lb=coef-invttail(e(df_r),0.025)*se //置信区间下界
gen ub=coef+invttail(e(df_r),0.025)*se //置信区间上界
keep coef se lb ub
drop if coef == .
	
input 
0 0 0 0
end
	
gen year = _n
replace year = year - 6 if year < 5
replace year = year - 5 if year >= 5 & year < 11
replace year = -1 if year == 11
sort year	

twoway (connect coef year,color(gs1) msize(small)) ///
(line lb year,lwidth(thin) lpattern(dash) lcolor(gs2)) ///
(line ub year,lwidth(thin) lpattern(dash) lcolor(gs2)), ///
yline(0,lwidth(vthin) lpattern(dash) lcolor(teal)) ///
xline(0,lwidth(vthin) lpattern(dash) lcolor(teal)) ///
ylabel(-0.08(0.04)0.04,labsize(*0.85) angle(0)) xlabel(-5(1)5,labsize(*0.75)) ///
ytitle("{stSerif:Impact of CCER projects put into operation on ln(PM2.5)}", size(small)) ///
xtitle("{stSerif:Relative time of CCER projects put into operation}", size(small)) ///
scheme(s1mono) legend(size(vsmall) order(1 "{stSerif:Point Estimate}" 2 "{stSerif:95% CI}")) ///图例
graphregion(color(white)) //白底
	   
restore	

*Fig. S3*
preserve
gen event = year - min_year
replace event =-5 if event < -5
replace event =5 if event > 5
forvalues i=5(-1)1{
   gen ddd_ppre`i' = (event==-`i' & treat==1 & poor==1)
   gen treat_ppre`i' = (event==-`i' & treat==1)
   gen poor_ppre`i' = (event==-`i' & poor==1)
   gen ppre`i' = (event==-`i')
}
gen ddd_current=(event== 0 & treat==1 & poor==1)
gen treat_current=(event== 0 & treat==1)
gen poor_current=(event== 0 & poor==1)
gen current=(event== 0 & poor==1)
forvalues i=1(1)5{
   gen ddd_ppost`i'=(event==`i' & treat==1 & poor==1)
   gen treat_ppost`i' = (event==`i' & treat==1)
   gen poor_ppost`i' = (event==`i' & poor==1)
   gen ppost`i' = (event==`i')
}
drop ddd_ppre1
global ddd ddd_ppre* ddd_current ddd_ppost*
global dd treat_ppre* treat_ppost* poor_ppre* poor_ppost* treat_current poor_current
global d ppre* current ppost*
qui reghdfe lnpm25m $ddd $dd $d lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80 ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store a2

matrix coef = e(b) //系数
matrix list coef
matrix cov = e(V) //协方差矩阵
matrix list cov 
gen coef = .
gen se = .
forvalues i = 1(1)10 {
 replace coef = coef[1,`i'] if _n==`i'
 replace se = sqrt(cov[`i',`i']) if _n==`i'
}
gen lb=coef-invttail(e(df_r),0.025)*se //置信区间下界
gen ub=coef+invttail(e(df_r),0.025)*se //置信区间上界
keep coef se lb ub
drop if coef == .
	
input 
0 0 0 0
end
	
gen year = _n
replace year = year - 6 if year < 5
replace year = year - 5 if year >= 5 & year < 11
replace year = -1 if year == 11
sort year	

twoway (connect coef year,color(gs1) msize(small)) ///
(line lb year,lwidth(thin) lpattern(dash) lcolor(gs2)) ///
(line ub year,lwidth(thin) lpattern(dash) lcolor(gs2)), ///
yline(0,lwidth(vthin) lpattern(dash) lcolor(teal)) ///
xline(0,lwidth(vthin) lpattern(dash) lcolor(teal)) ///
ylabel(-0.1(0.1)0.1,labsize(*0.85) angle(0)) xlabel(-5(1)5,labsize(*0.75)) ///
ytitle("{stSerif:Impact of CCER projects put into operation on EJ gap of ln(PM2.5)}", size(small)) ///
xtitle("{stSerif:Relative time of CCER projects put into operation}", size(small)) ///
scheme(s1mono) legend(size(vsmall) order(1 "{stSerif:Point Estimate}" 2 "{stSerif:95% CI}")) ///图例
graphregion(color(white)) //白底

restore

*Fig. S4*
preserve
gen event = year - min_year
replace event =-5 if event < -5
replace event =5 if event > 5
forvalues i=5(-1)1{
   gen ddd_ppre`i' = (event==-`i' & treat==1 & minorities==1)
   gen treat_ppre`i' = (event==-`i' & treat==1)
   gen minorities_ppre`i' = (event==-`i' & minorities==1)
   gen ppre`i' = (event==-`i')
}
gen ddd_current=(event== 0 & treat==1 & minorities==1)
gen treat_current=(event== 0 & treat==1)
gen minorities_current=(event== 0 & minorities==1)
gen current=(event== 0 & minorities==1)
forvalues i=1(1)5{
   gen ddd_ppost`i'=(event==`i' & treat==1 & minorities==1)
   gen treat_ppost`i' = (event==`i' & treat==1)
   gen minorities_ppost`i' = (event==`i' & minorities==1)
   gen ppost`i' = (event==`i')
}
drop ddd_ppre1
global ddd ddd_ppre* ddd_current ddd_ppost*
global dd treat_ppre* treat_ppost* minorities_ppre* minorities_ppost* treat_current minorities_current
global d ppre* current ppost*

est clear 
xtset year county_id
qui reghdfe lnpm25m $ddd $dd $d lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80 ==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store a2

matrix coef = e(b) //系数
matrix list coef
matrix cov = e(V) //协方差矩阵
matrix list cov 
gen coef = .
gen se = .
forvalues i = 1(1)10 {
 replace coef = coef[1,`i'] if _n==`i'
 replace se = sqrt(cov[`i',`i']) if _n==`i'
}
gen lb=coef-invttail(e(df_r),0.025)*se //置信区间下界
gen ub=coef+invttail(e(df_r),0.025)*se //置信区间上界
keep coef se lb ub
drop if coef == .
	
input 
0 0 0 0
end
	
gen year = _n
replace year = year - 6 if year < 5
replace year = year - 5 if year >= 5 & year < 11
replace year = -1 if year == 11
sort year	

twoway (connect coef year,color(gs1) msize(small)) ///
(line lb year,lwidth(thin) lpattern(dash) lcolor(gs2)) ///
(line ub year,lwidth(thin) lpattern(dash) lcolor(gs2)), ///
yline(0,lwidth(vthin) lpattern(dash) lcolor(teal)) ///
xline(0,lwidth(vthin) lpattern(dash) lcolor(teal)) ///
ylabel(-0.08(0.04)0.04,labsize(*0.85) angle(0)) xlabel(-5(1)5,labsize(*0.75)) ///
ytitle("{stSerif:Impact of CCER projects put into operation on EJ gap of ln(PM2.5)}", size(small)) ///
xtitle("{stSerif:Relative time of CCER projects put into operation}", size(small)) ///
scheme(s1mono) legend(size(vsmall) order(1 "{stSerif:Point Estimate}" 2 "{stSerif:95% CI}")) ///图例
graphregion(color(white)) //白底

restore

*Table S1*
preserve
keep if a_80 ==1
ddtiming lnco2 treat_post , i(county_id) t(year) 
restore

*Table S2*
preserve
keep if a_80 ==1
ddtiming lnpm25 treat_post , i(county_id) t(year) 
restore

*Table S3*
est clear
xtset county_id year  
global county lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain
qui reg lnco2 treat_post if a_80==1, cluster(county_id)
est store m1
qui reg lnco2 treat_post $county if a_80==1, cluster(county_id)
est store m2
qui reghdfe lnco2 treat_post $county if a_80==1, absorb(year county_id) cluster(county_id) keepsingletons
est store m3
qui reghdfe lnco2 treat_post $county if a_80==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons 
est store m4
qui reg lnpm25 treat_post if a_80==1 , cluster(county_id)
est store m5
qui reg lnpm25 treat_post $county if a_80==1 , cluster(county_id)
est store m6
qui reghdfe lnpm25 treat_post $county if a_80==1 , absorb(year county_id) cluster(county_id)
est store m7
qui reghdfe lnpm25 treat_post $county if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons 
est store m8

*Table S4*
est clear
xtset county_id year  
global county lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain
qui reghdfe lnco2 cap $county if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons 
est store m1
qui reghdfe lnpm25 cap $county if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons 
est store m2
gen cap_poor = cap*poor
gen cap_minorities = cap*minorities
qui reghdfe lnpm25 cap_poor cap poor $county if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons 
est store m3
qui reghdfe lnpm25 cap_minorities cap minorities $county if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons 
est store m4

*Table S5*
est clear
xtset county_id year  
global county lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain
qui reghdfe lnpm25 post_poor post poor $county if a_80==1 , absorb(year county_id) cluster(county_id) keepsingletons
est store m1
qui reghdfe lnpm25 post_poor post poor $county if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m2
qui reghdfe lnpm25 post_minorities post minorities $county if a_80==1 , absorb(year county_id) cluster(county_id) keepsingletons
est store m3
qui reghdfe lnpm25 post_minorities post minorities $county if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m4

*Table S6*
est clear
global county lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain  
qui reghdfe lnco2 fpost $county if a_80 ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m1 
qui reghdfe lnpm25 fpost $county  if a_80 ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m2
qui reghdfe lnpm25 fpost_poor fpost poor $county if a_80 ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m3
qui reghdfe lnpm25 fpost_minorities fpost minorities $county if a_80 ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m4

*Table S7.1.*
*Carbonmarket*
preserve
keep if car_market == 0
est clear
qui reghdfe lnco2 treat_post lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m1
qui reghdfe lnpm25 treat_post lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m2
restore

*Environment*
preserve
gen aenvir =0
replace aenvir=1 if envir1 == 1
replace aenvir=1 if envir2 == 1
keep if aenvir==0
est clear
qui reghdfe lnco2 treat_post lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m1
qui reghdfe lnpm25 treat_post lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m2
restore

*Information*
preserve
keep if info2018 ==0
est clear
qui reghdfe lnco2 treat_post lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m1
qui reghdfe lnpm25 treat_post lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m2
restore

*All*
preserve
keep if car_market == 0
gen aenvir =0
replace aenvir=1 if envir1 == 1
replace aenvir=1 if envir2 == 1
keep if aenvir==0
keep if info2018 ==0
est clear
qui reghdfe lnco2 treat_post lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m1
qui reghdfe lnpm25 treat_post lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m2
restore

*Table S7.2*
*Carbonmarket*
preserve
keep if car_market == 0
est clear 
qui reghdfe lnpm25 post_poor post poor lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m1
qui reghdfe lnpm25 post_minorities post minorities lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m2
restore

*Environment*
preserve
gen aenvir =0
replace aenvir=1 if envir1 == 1
replace aenvir=1 if envir2 == 1
keep if aenvir==0
est clear 
qui reghdfe lnpm25 post_poor post poor lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m1
qui reghdfe lnpm25 post_minorities post minorities lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m2
restore

*Information*
preserve
keep if info2018 ==0
est clear 
qui reghdfe lnpm25 post_poor post poor lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m1
qui reghdfe lnpm25 post_minorities post minorities lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m2
restore

*All*
preserve
keep if car_market == 0
gen aenvir =0
replace aenvir=1 if envir1 == 1
replace aenvir=1 if envir2 == 1
keep if aenvir==0
keep if info2018 ==0
est clear 
qui reghdfe lnpm25 post_poor post poor lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m1
qui reghdfe lnpm25 post_minorities post minorities lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m2
restore

*Table S8*
preserve
drop if treat ==1
gen purchaser_poor = purchaser*poor
gen purchaser_minorities = purchaser*minorities
est clear
xtset county_id year   
global county lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain 
qui reghdfe lnco2 purchaser $county if a_80==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m1
qui reghdfe lnpm25 purchaser $county if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m2
qui reghdfe lnpm25 purchaser_poor purchaser poor $county if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m3
restore

*Table S9*
preserve
gen adjacent_post_poor = adjacent_post * poor
gen adjacent_post_minorities = adjacent_post * minorities
est clear
xtset county_id year   
global county lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain 
reghdfe lnco2 adjacent_post $county if a_80==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m1
reghdfe lnpm25 adjacent_post $county if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m2
qui reghdfe lnpm25 adjacent_post_poor post poor $county if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m3
qui reghdfe lnpm25 adjacent_post_minorities post minorities $county if a_80==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m4
restore

*Table S10.1*
est clear
xtset county_id year  
global county lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain 
reghdfe lnco2 treat_post $county if a_80==1 & east ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m1
reghdfe lnco2 treat_post $county if a_80==1 & east ==0, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m2
reghdfe lnpm25 treat_post $county if a_80==1  & east ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m3
reghdfe lnpm25 treat_post $county if a_80==1  & east ==0, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m4

*Table S10.2*
gen post_east = post*east
gen post_poor_east = post_poor*east
gen post_minorities_east = post_minorities*east

est clear
xtset county_id year   
global county lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain 
qui reghdfe lnpm25 post_poor post poor $county if a_80==1 & east ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m1
qui reghdfe lnpm25 post_poor post poor $county if a_80==1 & east ==0 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m2
qui reghdfe lnpm25 post_minorities post minorities $county if a_80==1  & east ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons 
est store m3
qui reghdfe lnpm25 post_minorities post minorities $county if a_80==1  & east ==0 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m4

*Table S11*
est clear
xtset county_id year 
global county lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain 
qui reghdfe lnco2 treat_post $county if a_80==1 & wind==0, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m1
qui reghdfe lnpm25 treat_post $county if a_80==1 & wind==0, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m2
qui reghdfe lnpm25 post_poor post poor $county if a_80==1 & wind==0 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m3
qui reghdfe lnpm25 post_minorities post minorities $county if a_80==1 & wind==0, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
est store m4

*Table S13*
*****************************************************
**b1=MRU;b2=ECEI;b3=WIPG;b4=FS;b5=RE;b6=Forestry*****
*****************************************************
est clear
xtset county_id year
global county lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain
forvalues i = 1/6{
	qui reghdfe lnco2 treat_post $county if b`i'==1 |b`i'==2 & a_80==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
	est store m`i'
}

est clear
xtset county_id year
global county lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain
forvalues i = 1/6{
	qui reghdfe lnpm25 treat_post $county if b`i'==1 |b`i'==2 & a_80==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
	est store m`i'
}


*Table S14*
est clear
xtset county_id year
global county lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain
forvalues i = 1/6{
	qui reghdfe lnpm25 post_poor post poor $county if b`i'==1 |b`i'==2 & a_80==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
	est store m`i'
}

*Table S15*
est clear
xtset county_id year
global county lngdp second loans_finance lninc_pub emp_2 urban agri_mach lnrain
forvalues i = 1/6{
	qui reghdfe lnpm25 post_minorities post minorities $county if b`i'==1 |b`i'==2 & a_80==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
	est store m`i'
}


*Table S18*	
ttest co2, by (poor) 
ttest pm25, by (poor)
ttest gdp, by (poor)
ttest second, by (poor)  
ttest loans_finance, by (poor) 
ttest inc_pub, by (poor) 
ttest emp_2, by (poor) 
ttest urban, by (poor) 
ttest agri_mach, by (poor) 
ttest lnrain, by (poor) 

ttest co2, by (minorities) 
ttest pm25, by (minorities)
ttest gdp, by (minorities)
ttest second, by (minorities)  
ttest loans_finance, by (minorities) 
ttest inc_pub, by (minorities) 
ttest emp_2, by (minorities) 
ttest urban, by (minorities) 
ttest agri_mach, by (minorities) 
ttest lnrain, by (minorities) 

*Table S19*         
ttest co2, by (treat) unequal 
ttest pm25, by (treat) unequal 
ttest gdp, by (treat) unequal 
ttest second, by (treat)  
ttest loans_finance, by (treat)   
ttest inc_pub, by (treat) unequal 
ttest emp_2, by (treat) unequal 
ttest urban, by (treat) unequal 
ttest agri_mach, by (treat) unequal 
ttest lnrain, by (treat) unequal 








