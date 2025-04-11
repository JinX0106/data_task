* Change the working directory
cd "/Users/jin/Documents/Knowledge Base/Knowledge Attic/Coding/Stata/Illinois"

/* 
Add the required packages
ssc install table1, replace
ssc install ftools, replace
ssc install parallel, replace
ssc install reghdfe, replace
*/

* Simulate the raw data:

/* baseline survey */
clear
set obs 5000
set seed 1234

* Generate key variables

// ID
gen id = _n
label variable id "ID"

// Age
gen age = floor(runiform(18, 85))
label variable age "Age"

gen female = rbinomial(1, 0.505)    // female rate based on 2023 census
label variable female "Female (1)"

gen non_white = rbinomial(1, 0.42) // Non-white population rate based on 2023 census
label variable non_white "Non-white (1)"

// Years of Education (based on age)
gen edu_yrs = round(12 + 4*invnorm(uniform()))
label variable edu_yrs "Years of Education"
replace edu_yrs = 6 if edu_yrs < 6
replace edu_yrs = 22 if age >= 22 & edu_yrs > 22

// Social media usage
gen social_media = rpoisson(14)
label variable social_media "Social Media Usage (hours per week)"
replace social_media = 0 if social_media < 0

// Covid uptake
gen covid_uptake_bl = rbinomial(1, 0.3)
label variable covid_uptake_bl "Baseline Uptake"

// Income (percentile)
gen income = .
replace income = 1 if runiform() < 0.3  // low income < 30%
replace income = 2 if mi(income) & runiform() < 0.8  // median income 50%
replace income = 3 if mi(income)  // high income >20%
replace income = income + (edu_yrs > 16)
label variable income "Income Level"

save "baseline.dta", replace

/* Random assign treatment */
use "baseline.dta", clear
preserve
keep id
gen treatment = mod(id,3)  // 0=Control, 1=Reason, 2=Emotion
save "treatment.dta", replace
restore

/* endline survey */
use "baseline.dta", clear
set seed 5678
gen temp = uniform()
sort temp
drop if _n > 4500

merge 1:1 id using "treatment.dta", keep(matched) nogen

gen uptake_rate = 0.4

replace uptake_rate = uptake_rate + 0.08 if treatment == 1 & covid_uptake == 0
replace uptake_rate = uptake_rate + 0.06 if treatment == 2 & covid_uptake == 0

replace uptake_rate = uptake_rate + (age/10)*0.003

gen covid_uptake_el = rbinomial(1, uptake_rate)
label variable covid_uptake_el "Endline Uptake"

// other variables
gen ad_recall = cond(treatment > 0, rbinomial(1, 0.7), 0)
label variable ad_recall "Recall rate of Ad"
gen attitude_change = rnormal(0.5, 0.3) * treatment
label variable attitude_change "Attitude Change"

keep id age female non_white edu_yrs social_media income covid_uptake_* ad_recall attitude_change

save "endline.dta", replace

