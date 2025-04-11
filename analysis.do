/* merge data */
use "baseline.dta", clear
merge 1:1 id using "treatment.dta", nogen
merge 1:1 id using "endline.dta", keep(matched) nogen

label define treatment 0 "Control" 1 "Reason Ad" 2 "Emotion Ad"
label values treatment treatment

gen treated = treatment != 0 
gen treatment_reason = treatment == 1
gen treatment_emotion = treatment == 2

/* Descriptive statistics   */
table treatment, ///
  statistic(mean age) ///
  statistic(mean female) ///
  statistic(mean non_white) ///
  statistic(mean edu_yrs) ///
  statistic(mean income) ///
  statistic(mean social_media) ///
  nformat(%9.3f mean female) ///
  nformat(%9.3f mean edu_yrs)


/* Between-group variation */
ttest covid_uptake_el, by(treated)  // Treated vs Control
ttest covid_uptake_el if treated, by(treatment_reason) // Reason vs Emotion

tabulate treatment covid_uptake_el, chi2

/* Data visualization */
graph bar (mean) covid_uptake_el, over(treatment) ///
  ytitle("Covid Uptake") title("Uptake Comparison Among Groups (Endline)") ///
  blabel(bar, format(%9.2f)) scheme(s1mono)  
graph export "treatment_effect.png", replace

/* Regression Analysis */
logit covid_uptake_el i.treatment age female non_white edu_yrs social_media income, or
eststo model1

margins treatment, post
eststo margins1

/* Result output */
esttab model1 using "regression_results.rtf", ///
  b(%9.3f) se(%9.3f) star(* 0.10 ** 0.05 *** 0.01) ///
  label replace wide
