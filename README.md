# data_task
Data task for RA application

## File Description
This file contains the following data sets and do files.
1. simulate_raw_data.do - which contains stata code that generates three data sets, including baseline.dta (baseline survey), treatment.dta (treatment assignment), and endline.dta (endline survey).
2. analysis. do - which contains data merging, data visualization, and regression analysis.

## Data Description
------------------------------------------------------------------------------------------------------------------------------------------
id --                                                                                                                                 ID
------------------------------------------------------------------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [1,4999]                      Units: 1
         Unique values: 4,500                     Missing .: 0/4,500

                  Mean: 2503.04
             Std. dev.: 1443.92

           Percentiles:     10%       25%       50%       75%       90%
                          492.5    1247.5    2510.5    3750.5    4494.5

------------------------------------------------------------------------------------------------------------------------------------------
age --                                                                                                                                    Age
------------------------------------------------------------------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [18,84]                       Units: 1
         Unique values: 67                        Missing .: 0/4,500

                  Mean: 51.1482
             Std. dev.: 19.3104

           Percentiles:     10%       25%       50%       75%       90%
                             24        34        51        68        78

------------------------------------------------------------------------------------------------------------------------------------------
female   --                                                                                                                       Female (1)
------------------------------------------------------------------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [0,1]                         Units: 1
         Unique values: 2                         Missing .: 0/4,500

            Tabulation: Freq.  Value
                        2,240  0
                        2,260  1

------------------------------------------------------------------------------------------------------------------------------------------
non_white  --                                                                                                                  Non-white (1)
------------------------------------------------------------------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [0,1]                         Units: 1
         Unique values: 2                         Missing .: 0/4,500

            Tabulation: Freq.  Value
                        2,659  0
                        1,841  1

------------------------------------------------------------------------------------------------------------------------------------------
edu_yrs     --                                                                                                            Years of Education
------------------------------------------------------------------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [6,22]                        Units: 1
         Unique values: 17                        Missing .: 0/4,500

                  Mean: 12.1256
             Std. dev.: 3.71274

           Percentiles:     10%       25%       50%       75%       90%
                              7         9        12        15        17

------------------------------------------------------------------------------------------------------------------------------------------
social_media  --                                                                                         Social Media Usage (hours per week)
------------------------------------------------------------------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [3,27]                        Units: 1
         Unique values: 25                        Missing .: 0/4,500

                  Mean: 14.0507
             Std. dev.: 3.79347

           Percentiles:     10%       25%       50%       75%       90%
                              9        11        14        17        19

------------------------------------------------------------------------------------------------------------------------------------------
covid_uptake_bl  --                                                                                                          Baseline Uptake
------------------------------------------------------------------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [0,1]                         Units: 1
         Unique values: 2                         Missing .: 0/4,500

            Tabulation: Freq.  Value
                        3,180  0
                        1,320  1

------------------------------------------------------------------------------------------------------------------------------------------
income     --                                                                                                                   Income Level
------------------------------------------------------------------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [1,4]                         Units: 1
         Unique values: 4                         Missing .: 0/4,500

            Tabulation: Freq.  Value
                        1,186  1
                        2,360  2
                          884  3
                           70  4

------------------------------------------------------------------------------------------------------------------------------------------
treatment    --                                                                                                                  (unlabeled)
------------------------------------------------------------------------------------------------------------------------------------------

                  Type: Numeric (float)
                 Label: treatment

                 Range: [0,2]                         Units: 1
         Unique values: 3                         Missing .: 0/4,500

            Tabulation: Freq.   Numeric  Label
                        1,507         0  Control
                        1,495         1  Reason Ad
                        1,498         2  Emotion Ad

------------------------------------------------------------------------------------------------------------------------------------------
covid_uptake_el   --                                                                                                           Enline Uptake
------------------------------------------------------------------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [0,1]                         Units: 1
         Unique values: 2                         Missing .: 0/4,500

            Tabulation: Freq.  Value
                        2,477  0
                        2,023  1

------------------------------------------------------------------------------------------------------------------------------------------
ad_recall  --                                                                                                              Recall rate of Ad
------------------------------------------------------------------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [0,1]                         Units: 1
         Unique values: 2                         Missing .: 0/4,500

            Tabulation: Freq.  Value
                        2,349  0
                        2,151  1

------------------------------------------------------------------------------------------------------------------------------------------
attitude_change   --                                                                                                         Attitude Change
------------------------------------------------------------------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [-1.3223122,2.930969]         Units: 1.000e-10
         Unique values: 2,993                     Missing .: 0/4,500

                  Mean:  .49228
             Std. dev.: .548591

           Percentiles:     10%       25%       50%       75%       90%
                              0         0   .384605   .825017   1.27951

------------------------------------------------------------------------------------------------------------------------------------------
treated   --                                                                                                                     (unlabeled)
------------------------------------------------------------------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [0,1]                         Units: 1
         Unique values: 2                         Missing .: 0/4,500

            Tabulation: Freq.  Value
                        1,507  0
                        2,993  1

------------------------------------------------------------------------------------------------------------------------------------------
treatment_reason    --                                                                                                           (unlabeled)
------------------------------------------------------------------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [0,1]                         Units: 1
         Unique values: 2                         Missing .: 0/4,500

            Tabulation: Freq.  Value
                        3,005  0
                        1,495  1

------------------------------------------------------------------------------------------------------------------------------------------
treatment_emotion    --                                                                                                          (unlabeled)
------------------------------------------------------------------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [0,1]                         Units: 1
         Unique values: 2                         Missing .: 0/4,500

            Tabulation: Freq.  Value
                        3,002  0
                        1,498  1

## Instruction of Execution
Download simulate_raw_data.do and analysis.do files. Modify the file path. Then run each file.

## Logic

### Data Simulation
1. Set up conditions for baseline survey.

Setting up required number of observations and seed for consistent random results.

2. Generate key variables.

Generate variables such as id, age, female, non_white, edu_yrs, social_media, baseline covid uptake, income. Then set each variable into appropriate range. For example, education was set to be within the range of 6 and 22 with mean of 12; similarly, income was categorized into three level with majority of population lie on the second level.

4. Randomize treatment.

Keep variable id, and then randomly assign treatments.

4. Generate endline survey.

Randomly drop 500 observation as designated. Then, merge the baseline data with the treatment data, and then generate endline covid uptake variable.

5. Generate other variables for further analysis

Generate variables like advertisment recall rate and attitude changes for future analysis.

### Data Analysis
1. Merge Data

Merge the data sets using id, then keep the matched observations, so leaving 4500 sample points.

2. Descriptive statistics

Generate a table indicating mean value among different treatment groups.

3. Comparison

Using t test to evaluate the difference among treated and control groups.

4. Data visualization

Generate a bar graph to visualize the effectiveness of the treatments comparing to the control group.

5. Regression analysis

Using logistic regression, we found that reason advertisment group is 1.46 times more frequent in COVID uptake; emotional advertisement is 1.2 times.
