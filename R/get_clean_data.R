get_clean_data <- function(raw_data) {
    raw_data %>% 
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
}