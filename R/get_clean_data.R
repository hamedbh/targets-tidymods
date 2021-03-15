get_clean_data <- function(raw_data) {
    assertthat::assert_that(tibble::is.tibble(raw_data))
    ref_input_colnames <- c(
        "acct_status",
        "duration",
        "credit_history",
        "purpose",
        "amount",
        "savings_acct",
        "present_emp_since",
        "pct_of_income",
        "sex_status",
        "other_debtor_guarantor",
        "resident_since",
        "property",
        "age",
        "other_debts",
        "housing",
        "num_existing_credits",
        "job",
        "num_dependents",
        "telephone",
        "foreign_worker",
        "outcome"
    )
    
    assertthat::assert_that(all(colnames(raw_data) == ref_input_colnames))
    
    res <- raw_data %>% 
        # details of the factors are taken from the data dictionary
        # Can ignore warnings, which are because there are no rows with the 
        # given Axx code. These manipulations use functions from the forcats 
        # package, which makes factors much easier
        mutate(
            acct_status = fct_recode(
                acct_status, 
                overdrawn = "A11",
                below_200DM = "A12",
                over_200DM = "A13",
                no_acct = "A14"
            ),
            credit_history = fct_recode(
                credit_history,
                none_taken_all_paid = "A30",
                all_paid_this_bank = "A31",
                all_paid_duly = "A32",
                past_delays = "A33",
                critical_acct = "A34"
            ),
            purpose = fct_recode(
                purpose,
                car_new = "A40",
                car_used = "A41",
                furniture_equipment = "A42",
                radio_tv = "A43",
                dom_appliance = "A44",
                repairs = "A45",
                education = "A46",
                retraining = "A48",
                business = "A49",
                others = "A410"
            ),
            savings_acct = fct_recode(
                savings_acct,
                to_100DM = "A61",
                to_500DM = "A62",
                to_1000DM = "A63",
                over_1000DM = "A64",
                unknwn_no_acct = "A65"
            ),
            present_emp_since = fct_recode(
                present_emp_since,
                unemployed = "A71",
                to_1_yr = "A72",
                to_4_yrs = "A73",
                to_7_yrs = "A74",
                over_7_yrs = "A75"
            ),
            sex_status = fct_recode(
                sex_status,
                male_divorced = "A91",
                female_married = "A92",
                male_single = "A93",
                male_married = "A94"
            ),
            other_debtor_guarantor = fct_recode(
                other_debtor_guarantor,
                none = "A101",
                co_applicant = "A102",
                guarantor = "A103"
            ),
            property = fct_recode(
                property,
                real_estate = "A121",
                savings_insurance = "A122",
                car_other = "A123",
                unknwn_none = "A124"
            ),
            other_debts = fct_recode(
                other_debts,
                bank = "A141",
                stores = "A142",
                none = "A143"
            ),
            housing = fct_recode(
                housing,
                rent = "A151",
                own = "A152",
                for_free = "A153"
            ),
            job = fct_recode(
                job,
                unemp_unskilled_nonres = "A171",
                unskilled_res = "A172",
                skilled_official = "A173",
                mgmt_highqual = "A174"
            ),
            telephone = fct_recode(telephone,
                                   no = "A191",
                                   yes = "A192"),
            foreign_worker = fct_recode(foreign_worker,
                                        yes = "A201",
                                        no = "A202"),
            outcome = fct_recode(outcome,
                                 good = "1",
                                 bad = "2") %>% 
                # set "bad" as the first level, therefore the target
                fct_relevel("bad")
        ) %>%
        # create gender, a simplification of sex_status, to use instead
        mutate(
            gender = fct_collapse(
                sex_status,
                male = "male_divorced",
                male = "male_single",
                male = "male_married",
                female = "female_married"
            )
        ) %>%
        select(-sex_status)
    
    assertthat::assert_that(tibble::is.tibble(res))
    
    ref_output_colnames <- c(
        "acct_status",
        "duration",
        "credit_history",
        "purpose",
        "amount",
        "savings_acct",
        "present_emp_since",
        "pct_of_income",
        "other_debtor_guarantor",
        "resident_since",
        "property",
        "age",
        "other_debts",
        "housing",
        "num_existing_credits",
        "job",
        "num_dependents",
        "telephone",
        "foreign_worker",
        "outcome",
        "gender"
    )
    
    assertthat::assert_that(all(colnames(res) == ref_output_colnames))
    
    assertthat::assert_that(
        all(
            res[["acct_status"]] %in% c("overdrawn", 
                                        "below_200DM", 
                                        "over_200DM", 
                                        "no_acct")
        ), 
        all(
            res[["credit_history"]] %in% c("none_taken_all_paid", 
                                           "all_paid_this_bank", 
                                           "all_paid_duly",
                                           "past_delays", 
                                           "critical_acct")
        ), 
        all(res[["purpose"]] %in% c("car_new",
                                    "car_used",
                                    "furniture_equipment",
                                    "radio_tv",
                                    "dom_appliance",
                                    "repairs",
                                    "education",
                                    "retraining",
                                    "business",
                                    "others")
        ), 
        all(res[["savings_acct"]] %in% c("to_100DM",
                                         "to_500DM",
                                         "to_1000DM",
                                         "over_1000DM",
                                         "unknwn_no_acct")
        ), 
        all(res[["present_emp_since"]] %in% c("unemployed",
                                              "to_1_yr",
                                              "to_4_yrs",
                                              "to_7_yrs",
                                              "over_7_yrs")
        ), 
        all(res[["other_debtor_guarantor"]] %in% c("none",
                                                   "co_applicant",
                                                   "guarantor")
        ), 
        all(res[["property"]] %in% c("real_estate",
                                     "savings_insurance",
                                     "car_other",
                                     "unknwn_none")
            ), 
        all(res[["other_debts"]] %in% c("bank",
                                        "stores",
                                        "none")
            )
    )
    res
    
}