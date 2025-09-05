use "C:\Users\qiuji\Desktop\ccerdata123_for.dta"
global ccer tlngdp tsecondary tloans tinc_pub temp2 turban tagri tlnrain ttem tpilot tair tinfo
*Table A1
*CSDID
*无控制变量
csdid lnco2out  , time(year) gvar(zuixaonian) method(dripw) cluster(county_id) agg(simple) notyet
*有控制变量
csdid lnco2out $ccer , time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
estat event, estore(co2)
event_plot co2, graph_opt(xtitle("Relative time of CCER projects put into operation") ytitle("Average treatment effect") xlabel(-6(1)3) ) ///
           default_look ciplottype(rcap) stub_lag(Tp#) stub_lead(Tm#) trimlag(6) trimlead(6) together

*无控制变量		   
csdid lnpm25m , time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
*有控制变量		   
csdid lnpm25m $ccer , time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
estat event, estore(co2)
event_plot co2, graph_opt(xtitle("Relative time of CCER projects put into operation") ytitle("Average treatment effect") xlabel(-6(1)3) ) ///
           default_look ciplottype(rcap) stub_lag(Tp#) stub_lead(Tm#) trimlag(6) trimlead(6) together	 

*Table A2
reghdfe lnco2out cap $ccer , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons 
reghdfe lnpm25m cap $ccer , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons 
reghdfe lnpm25m cap_poor cap poor $ccer , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons 
reghdfe lnpm25m cap_minorities cap minorities $ccer , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons

*Table A3 
reghdfe lnpm25m post_poor post poor $ccer , absorb(year county_id) cluster(county_id) keepsingletons
reghdfe lnpm25m post_poor post poor $ccer , absorb( year county_id city_id#c.year) cluster(county_id) keepsingletons 
reghdfe lnpm25m post_minorities post minorities $ccer , absorb(year county_id) cluster(county_id) keepsingletons
reghdfe lnpm25m post_minorities post minorities $ccer , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons 

*Table A4
csdid lnco2out $ccer , time(year) gvar(zuixiaonian_n) method(dripw) cluster(county_id) agg(simple) notyet
csdid lnpm25m $ccer , time(year) gvar(zuixiaonian_n) method(dripw) cluster(county_id) agg(simple) notyet
reghdfe lnpm25m fpost_poor fpost poor $ccer , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons 
reghdfe lnpm25m fpost_minorities fpost minorities $ccer , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons 

*Table A5 
csdid lnco2out $ccer if aa_90 ==1, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet   
csdid lnpm25m $ccer if aa_90 ==1, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet	
reghdfe lnpm25m post_poor post poor $ccer if aa_90 ==1, absorb( year county_id city_id#c.year) cluster(county_id) keepsingletons 
reghdfe lnpm25m post_minorities post minorities $ccer if aa_90 ==1, absorb(year county_id city_id#c.year) cluster(county_id)  keepsingletons 

*Table A6
csdid lnco2_new $ccer , time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
csdid lnpm25_new $ccer , time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet	
reghdfe lnpm25_new post_poor post poor $ccer , absorb( year county_id city_id#c.year) cluster(county_id) keepsingletons 
reghdfe lnpm25_new post_minorities post minorities $ccer , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons 	

*Table A7	
csdid lnco2out $ccer if fx==0, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
csdid lnpm25m $ccer if fx==0, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
reghdfe lnpm25m post_poor post poor $ccer if fx==0, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons 
reghdfe lnpm25m post_minorities post minorities $ccer if fx==0, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons 

*Table A9
**Panel A
csdid lnco2out $ccer if b1 ==1, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
csdid lnco2out $ccer if b2 ==1, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
csdid lnco2out $ccer if b3 ==1, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
csdid lnco2out $ccer if b4 ==1, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
csdid lnco2out $ccer if b5 ==1, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
csdid lnco2out $ccer if b6 ==1, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
**Panel B
csdid lnpm25m $ccer if b1 ==1, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet 
csdid lnpm25m $ccer if b2 ==1, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet 
csdid lnpm25m $ccer if b3 ==1, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet 
csdid lnpm25m $ccer if b4 ==1, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet 
csdid lnpm25m $ccer if b5 ==1, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet 
csdid lnpm25m $ccer if b6 ==1, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet 

*Table A10	
reghdfe lnpm25m post_poor post poor $ccer if b1 ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnpm25m post_poor post poor $ccer if b2 ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnpm25m post_poor post poor $ccer if b3 ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnpm25m post_poor post poor $ccer if b4 ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnpm25m post_poor post poor $ccer if b5 ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnpm25m post_poor post poor $ccer if b6 ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons

*Table A11	
reghdfe lnpm25m post_minorities post minorities $ccer if b1 ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnpm25m post_minorities post minorities $ccer if b2 ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnpm25m post_minorities post minorities $ccer if b3 ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnpm25m post_minorities post minorities $ccer if b4 ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnpm25m post_minorities post minorities $ccer if b5 ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnpm25m post_minorities post minorities $ccer if b6 ==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons

*Table A12	
csdid lnco2out $ccer if east ==1 , time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
csdid lnco2out $ccer if east ==0 , time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
csdid lnpm25m $ccer if east ==1 , time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
csdid lnpm25m $ccer if east ==0 , time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet

*Table A13	
reghdfe lnpm25m post_poor post poor $ccer if east ==1  , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnpm25m post_poor post poor $ccer if east ==0  , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnpm25m post_minorities post minorities $ccer if east ==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnpm25m post_minorities post minorities $ccer  if east ==0 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
	
*Table A14	
csdid lnlstzp $ccer , time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
reghdfe lnlstzp post_poor post poor $ccer, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnlstzp post_minorities post minorities $ccer, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons

csdid lnlsfmsq $ccer , time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet   
reghdfe lnlsfmsq post_poor post poor $ccer , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnlsfmsq post_minorities post minorities $ccer , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons

*Table A15
csdid lnco2out $ccer if lstzg==1 , time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
csdid lnco2out $ccer if lstzg==2 , time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
csdid lnpm25m $ccer if lstzg==1 , time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
csdid lnpm25m $ccer if lstzg==2 , time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet

csdid lnco2out $ccer if lsfmsqg==1, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet
csdid lnco2out $ccer if lsfmsqg==2, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet 
csdid lnpm25m $ccer if lsfmsqg==1, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet 
csdid lnpm25m $ccer if lsfmsqg==2, time(year) gvar(zuixiaonian) method(dripw) cluster(county_id) agg(simple) notyet

*Table A16
reghdfe lnpm25m post_poor post poor $ccer if lstzg==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnpm25m post_poor post poor $ccer if lstzg==2, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnpm25m post_minorities post minorities $ccer if lstzg==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnpm25m post_minorities post minorities $ccer if lstzg==2, absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons

reghdfe lnpm25m post_poor post poor $ccer if lsfmsqg==1 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnpm25m post_poor post poor $ccer if lsfmsqg==2 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingletons
reghdfe lnpm25m post_minorities post minorities $ccer if lsfmsqg==1, absorb(year county_id city_id#c.year) cluster(county_id) keepsingleton
reghdfe lnpm25m post_minorities post minorities $ccer if lsfmsqg==2 , absorb(year county_id city_id#c.year) cluster(county_id) keepsingleton 

*Table A19	
ttest co2_out, by (poor) 
ttest pm25m, by (poor)
ttest gdp_d, by (poor)
ttest gdp2pp, by (poor)  
ttest loan_fin_d, by (poor) 
ttest pub_out_d, by (poor) 
ttest pop_2, by (poor) 
ttest czhlp, by (poor) 
ttest nongji, by (poor) 
ttest lnrain, by (poor) 
ttest wendu,  by (poor) 
ttest car_market,  by (poor)
ttest aenvir,  by (poor)
ttest info2018,  by (poor)

ttest co2_out, by (minorities) 
ttest pm25m, by (minorities) 
ttest gdp_d, by (minorities) 
ttest gdp2pp, by (minorities) 
ttest loan_fin_d, by (minorities)
ttest pub_out_d, by (minorities) 
ttest pop_2, by (minorities) 
ttest czhlp, by (minorities) 
ttest nongji, by (minorities) 
ttest lnrain, by (minorities)  
ttest wendu,  by (minorities) 
ttest car_market,  by (minorities)
ttest aenvir,  by (minorities)
ttest info2018,  by (minorities) 

*Table A20	    
ttest co2_out, by (treat) unequal //1
ttest pm25m, by (treat) unequal //1
ttest gdp_d, by (treat) unequal //1
ttest gdp2pp, by (treat)  //1
ttest loan_fin_d, by (treat)   //1
ttest pub_out_d, by (treat) unequal //1
ttest pop_2, by (treat) unequal //1
ttest czhlp, by (treat) unequal //1
ttest nongji, by (treat) unequal //1
ttest lnrain, by (treat) unequal //1
ttest wendu, by (treat) unequal //1
ttest car_market, by (treat) unequal //1
ttest aenvir, by (treat) unequal //1
ttest info2018, by (treat) unequal //1

*Fig A2*
preserve
drop ddd_ppre1
global ddd ddd_ppre* ddd_current ddd_ppost*
global dd treat_ppre* treat_ppost* poor_ppre* poor_ppost* treat_current poor_current
global d ppre* current ppost*
reghdfe lnpm25m $ddd $dd $d $ccer , absorb(year county_id city_id#c.year) cluster(county_id) keepsingleton 
est store a2
matrix coef = e(b)
matrix list coef
matrix cov = e(V)
matrix list cov 
gen coef = .
gen se = .
forvalues i = 1(1)10 {
 replace coef = coef[1,`i'] if _n==`i'
 replace se = sqrt(cov[`i',`i']) if _n==`i'
}
gen lb=coef-invttail(e(df_r),0.025)*se
gen ub=coef+invttail(e(df_r),0.025)*se
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
scheme(s1mono) legend(size(vsmall) order(1 "{stSerif:Point Estimate}" 2 "{stSerif:95% CI}")) ///
graphregion(color(white)) //
restore

*Fig A3*
preserve
drop ddd_ppre1
global ddd ddd_ppre* ddd_current ddd_ppost*
global dd treat_ppre* treat_ppost* minorities_ppre* minorities_ppost* treat_current minorities_current
global d ppre* current ppost*
est clear 
xtset year county_id
reghdfe lnpm25m $ddd $dd $d $ccer , absorb(year county_id city_id#c.year) cluster(county_id) keepsingleton 
est store a2
matrix coef = e(b)
matrix list coef
matrix cov = e(V)
matrix list cov 
gen coef = .
gen se = .
forvalues i = 1(1)10 {
 replace coef = coef[1,`i'] if _n==`i'
 replace se = sqrt(cov[`i',`i']) if _n==`i'
}
gen lb=coef-invttail(e(df_r),0.025)*se
gen ub=coef+invttail(e(df_r),0.025)*se
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
scheme(s1mono) legend(size(vsmall) order(1 "{stSerif:Point Estimate}" 2 "{stSerif:95% CI}")) ///
graphregion(color(white))
restore
	

