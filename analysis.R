# 1 Loading data ------------------------------------------------------------

# You'll load the NYT COVID data at the national, state, and county level. As you move
# through the assignment, you'll need to consider the appropriate data to
# answer each question.

# NOTE: To load the data you will need to get the "raw URLs" from the New
# York Times GitHub page: https://github.com/nytimes/covid-19-data/:

# This `rm(list = ls())` will clear your environment variables - helpful for keeping
# your work tidy and for debugging. You will find bugs more more quickly
# if you study your environment variables and start fresh frequently.
rm(list = ls())


# 1.a Load the tidyverse package and dplyr
install.packages("dplyr")
install.packages("tidyverse")
library("tidyverse")
library("dplyr")

# NOTE: In these coding tasks, replace the NULL value to the correct R code.
#       For some of the prompts, we have typed the variable names for you,
#       to save you a little typing!

# 1.b Load the *national level* data into a variable. `national`
national <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us.csv")

# 1.c Load the *state level* data into a variable. `states`
states <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")

# 1.d Load the *county level* data into a variable. `counties`
#     NOTE: This is a large dataset. It may take 30-60 seconds to load.
counties <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")

# 1.e How many observations (rows) are in each dataset?
# Create `obs_national`, `obs_states`, `obs_counties`
obs_national <- nrow(national)
obs_states <- nrow(states)
obs_counties <- nrow(counties)

# 1.f How many features (columns) are there in each dataset?
# Create `num_features_national`, `num_features_states`, `num_features_counties`
num_features_national <- ncol(national)
num_features_states <- ncol(states)
num_features_counties <- ncol(counties)

# R1.a REFLECTION: Use View() to open the three datasets and explore
#      the data, and with documentation form the New York Times, answer
#      these questions:
view(counties)
view(national)
view(states)
#        (a) How does the County-level data differ from the
#            the State-level and U.S. National-level?
#        (b) What is the same about these three datasets?
#        (c) What does the feature "fips" mean? Do a Google search and/or
#            visit: https://www.census.gov/library/reference/code-lists/ansi.html

# 2 Exploratory Analysis ----------------------------------------------------

# Use functions from the DPLYR package to explore the datasets by answering
# the following questions. Note, you must return the specific column being
# asked about. You do this with the pull() function. For example:
#
#       What is the earliest date in the National-level dataset? `earliest_date`
#       This code is CORRECT because pull() is used to return a single value:
#       earliest_date <- national %>%
#           filter(date == min(date)) %>%
#           pull(date)
#
#       This is NOT correct because an entire row is returned
#       earliest_date <- national %>%
#           filter(date == min(date))

# NOTE: Unless otherwise stated, use DPLYR functions to solve all coding
#       tasks.

# 2.a How many total cases have there been in the U.S. by the most recent date
# in the dataset? `total_us_cases`
total_us_cases <- national %>% filter(date == max(date)) %>% pull(cases)
print(total_us_cases)

# 2.b How many total deaths have there been in the U.S. by the most recent date
# in the dataset? `total_us_deaths`
total_us_deaths <- national %>% filter(date == max(date)) %>% pull(deaths)
print(total_us_deaths)

# 2.c Which state has had the highest number of cases?
# `state_highest_cases`
state_highest_cases <- states %>% filter(cases == max(cases)) %>% pull(state)

# 2.d What is the highest number of cases in a state?
# `num_highest_state`
num_highest_state <- states %>% filter(cases == max(cases)) %>% pull(cases)

# 2.e Which state has the highest ratio of deaths to cases (deaths/cases),
# as of the most recent date? HINT: You may need to create a new column in
# order to do this. `state_highest_ratio`
states <- mutate(states, ratio_deaths_cases = deaths / cases)
state_highest_ratio <- states %>% filter(ratio_deaths_cases == max(ratio_deaths_cases)) %>% pull(state)

# 2.f Which state has had the fewest number of cases *as of the most
# recent date*? HINT: This is a little trickier to calculate than the
# maximum because of the meaning of the row. `state_lowest_cases`
state_lowest_cases <- states %>% filter(date == max(date)) %>% filter(cases == min(cases)) %>% pull(state)

# R2.a REFLECTION: (a) What did you learn about the dataset when you calculated
#      the state with the lowest cases; and (b) What does that tell you about
#      testing your assumptions in a dataset?
#      REMINDER: Please answer in the README.md.

# 2.g Which county has had the highest number of cases?
# `county_highest_cases`
county_highest_cases <- counties %>% filter(cases == max(cases)) %>% pull(county)

# 2.h What is the highest number of cases that have happened in a single county?
# `num_highest_cases_county`
num_highest_cases_county <- counties %>% filter(cases == max(cases)) %>% pull(cases)

# 2.i Because there are multiple counties with the same name across states, it
# will be helpful to have a column that stores the county and state together,
# in this form: "COUNTY, STATE". Therefore, add a new column to your `counties`
# data frame called `location` that stores the county and state (separated by
# a comma and space). You can do this in at least two ways:
#   (1) `mutate()`   and the `paste0()` string function; or
#   (2) `unite()`  - see https://tidyr.tidyverse.org/reference/unite.html
#       (Note: Be sure to keep the original columns.
#              To do so, use the parameter `remove=FALSE`.)
counties <- counties %>% mutate(location = paste0(county, ", ", state))

# 2.j What is the name of the location (county, state) with the highest number
# of deaths? `location_most_deaths`
location_most_deaths <- counties %>% filter(deaths == max(deaths, na.rm = TRUE)) %>% pull(location)

# R2.b REFLECTION: Is the location with the highest number of cases the
#      location with the most deaths? If not, why do you believe that may be
#      the case?
location_most_cases <- counties %>% filter(cases == max(cases, na.rm = TRUE)) %>% pull(location)

# NOTE: As you have seen, the three datasets are "cumulative sums," that is, running
# totals of the number of cases and deaths. On each day the cases and deaths counts
# either stay the same or increase. They should never decrease. It is often very
# helpful to know by how much the numbers have increased (if at all) between
# successive times.

# 2.k Add a new column to your `national` data frame called `new_cases`; that is,
# the number new cases each day.
# HINTS:
#    (1) Recall that the dyplr mutate() function is used to add new columns.
#    (2) The dyplr lag() function will be very helpful. Search "R dplyr lag()"
#        on Google and look for a good link.
national <- mutate(national, new_cases = cases - lag(cases))

# 2.l Similarly, the `deaths` columns *is not* the number of new deaths per day.
# Add  a new column to the `national` data frame called `new_deaths`
# that has the number of *new* deaths each day
national <- mutate(national, new_deaths = deaths - lag(deaths))

# 2.m What was the date when the most new cases occurred?
# `date_most_cases`
date_most_cases <- national %>% filter(new_cases == max(new_cases, na.rm = TRUE)) %>% pull(date)

# 2.n What was the date when the most new deaths occurred?
# `date_most_deaths`
date_most_deaths <- national %>% filter(new_deaths == max(new_deaths, na.rm = TRUE)) %>% pull(date)

# 2.o How many people died on the date when the most deaths occurred? `most_deaths`
most_deaths <- date_most_deaths <- national %>% filter(new_deaths == max(new_deaths, na.rm = TRUE)) %>% pull(new_deaths)

# 2.p Create a (very basic) plot by passing `national$new_cases` column to the
# `plot()` function. Store the result in a variable `new_cases_plot`.
new_cases_plot <- plot(national$new_cases)

# 2.q Create a (very basic) plot by passing the `new_deaths` column to the
# `plot()` function. Store the result in a variable `new_deaths_plot`.
new_deaths_plot <- plot(national$new_deaths)

# 3. Grouped Analysis --------------------------------------------------------

# An incredible power of R is to perform the same computation *simultaneously*
# across groups of rows. As you know, this capability is called aggregation, and
# it relies on the group_by() and summarize() functions in dplyr.
#
# For more on summarize, see: https://dplyr.tidyverse.org/index.html
# For more on group_by() see: https://dplyr.tidyverse.org/articles/grouping.html?q=group%20_%20by#group_by

# 3.a What is the county with the *current* highest number of cases in each state?
# *Current* means the the most recent date. Your answer, stored in
# `highest_in_each_state`, should be a *vector* of  `location` names, that is,
# the column with COUNTY, STATE.  HINT: Be careful about the order of filtering
# your data.
highest_in_each_state <- counties %>% filter(date == max(date)) %>% group_by(state) %>% filter(cases == max(cases)) %>% pull(location)

# 3.b Using the variable `highest_in_each_state`, which location (COUNTY, STATE) has had
# the highest number of cases in Washington? `highest_in_wa`
# Hint: Use the function str_detect() from the stringr() package.
highest_in_wa <- highest_in_each_state[str_detect(highest_in_each_state, "Washington")]

# 3.c What is the county with the *current* (e.g., on the most recent date)
# lowest number of deaths in each state? Your answer, stored in
# `lowest_in_each_state`, should be a *vector* of
# `location` names (the column with COUNTY, STATE).
lowest_in_each_state <- counties %>% filter(date == max(date)) %>% group_by(state) %>% filter(deaths == min(deaths)) %>% pull(location)

# R3.a REFLECTION: Why are there so many observations (counties) in the
#      variable `lowest_in_each_state`? That is, wouldn't you expect
#      the number to be around 50?
print(lowest_in_each_state)

# 3.d What *proportion* of counties have had zero deaths in each state?
# This is a very simple question. But, as is often the case, with data
# and code, it is actually quite complex. Consider that:
#    prop =  n_counties / total_counties,   where n_counties is the number of counties with zero deaths
#                       and total_counties is the total number of counties.
# Given this, the goal is to return a *data frame* with both the state name
# and the proportion (`prop`) in a variable called `prop_no_deaths`
#
# There are several ways to tackle this question. This is a long but
# relatively straightforward approach:
#    (1) Create a data frame with two columns: `state` and `n_counties`.
#    (2) Create a second data frame with two columns: `state` and `total_counties`
#    (3) Join the two data frames by `state` and add the `prop` column
#    (4) You will note that the data frame from step 3 has a lot of NAs.
#        Why? You can replace the NAs with `replace_na()`
#        See https://tidyr.tidyverse.org/reference/replace_na.html

# NOTE: As you work on steps (1) and (2) carefully consider how to group
# the data.
deaths_counties <- counties %>% group_by(state) %>% filter(date == max(date)) %>% filter(deaths == 0) %>% summarize(deaths_counties = n())
total_counties <- counties %>% group_by(state) %>% filter(date == max(date)) %>% summarize(total_counties = n())
prop_no_deaths <- left_join(deaths_counties, total_counties, by="state") %>% mutate(prop = deaths_counties / total_counties)

# 3.e Using the `prop_no_deaths` variable (3.d), what proportion of counties in
# Washington State have had zero deaths? `wa_prop_no_deaths`
wa_prop_no_deaths <- prop_no_deaths %>% filter(state=="Washington") %>% pull(prop)
wa_prop_no_deaths
# 4. Joins  --------------------------------------------------------

# As described at the New York Times GitHub page, collecting this
# data has been a massive effort. Accordingly, there might be
# mistakes in the data. After all, data is being collected
# for more than 3,000 U.S. counties.
#
# (Incidentally, to determine exactly how many counties are in your
# dataset you could use this command:
#    n_distinct(counties$location) or
#    length(unique(counties$location))
# See: https://dplyr.tidyverse.org/reference/n_distinct.html)
#
# One check for data consistency is the following:
#
#     On each day, (a) All the County case counts for
#     a State (`counties` data frame) should sum to the State
#     case counts (`states`); and, also, (b) The States case
#     counts should sum to the National case counts (`national`).
#
# If (a) is false or (b) is false, then something is wrong.
#
# A convenient way to test for this data consistency check
# is to create the following four-column data frame
# (`all_totals`) and then compare the national, state, and
# county totals:
#
# all_totals:
# date | national_total_cases | state_total_cases | county_total_cases
#
# Column                Brief description
# date:                 Each day in the time series
# national_total_cases: The case counts in the `national` data frame
# state_total_cases:    The sum of all case counts in the `states` data frame
# county_total_cases:   The sum of all case counts in the `counties` data frame
#
# We now guide you through the steps for this consistency check. We've typed the
# variable names to save you a little bit of work.
#
# 4.a Create a `county_by_day` data frame with columns:
#     `date` and `county_total_cases`. HINT: To summarize
#      the case counts, how do you need to group the data?
county_by_day <- counties %>% group_by(date) %>% summarize(county_total_cases=sum(cases))

# 4.b Create a `state_by_day` data frame with columns:
#     `date` and `state_total_cases`.  HINT: See previous
#      hint.
state_by_day <- states %>% group_by(date) %>% summarize(state_total_cases=sum(cases))

# 4.c Join the `county_by_day` and `state_by_day` data frames. Call
#     this data frame `totals_by_day`.
totals_by_day <- left_join(county_by_day, state_by_day, by="date")

# 4.d Join `totals_by_day` with the `nation` data frame and, for
#     clarity, rename the `cases` column to `national_total_cases`. Call
#     this data frame `all_totals`.
all_totals <- left_join(totals_by_day, national, by="date")
names(all_totals)[4] <- "national_total_cases"

# Finally, with this convenient data frame (`all_totals`), you can
# write code to test the consistency check.

# 4.e How many differences do you find between `national_total_cases` and
#     `state_total_cases`?
#     `national_state_diff`  (as a numeric value - use pull() function )
national_state_diff <- pull(all_totals, national_total_cases) - pull(all_totals, state_total_cases)

# 4.f How many differences do you find between `state_total_cases` and
#     `county_total_cases'?
#     `state_county_diff` (as a numeric value - use the pull() function)
state_county_diff <- pull(all_totals, state_total_cases) - pull(all_totals, county_total_cases)
print(state_county_diff)

# R4.a REFLECTION: When the check was carried out on January 25, 2022
#      an inconsistency was found. (a) Given the work that you've just
#      completed (4.a - 4.f), what can you say about the source of the
#      inconsistency? (b) What might be your next step to discover where
#      exactly in the data the inconsistency lies? To answer questions
#      (a) and (b), consider exploring the data frames that
#      you have created in the above steps.

# 5. Independent exploration -------------------------------------------------

# 5.a In sections 2-4, you were asked to find answers to questions about
#     three cumulative sum time series, of profound importance for making
#     sense of the present and for shaping human action in the future.
#     Now, it is your turn. Ask your own question and then wrangle some
#     data to answer your question. Show that your code works. As
#     appropriate, please comment your code so that it is understandable.

# QUESTION:  What is the trend of the increasing cases in WA? Solve this question by creating a new data frame called trend_wa and using plot() ...
#            ..................................    and the code is ...
trend_wa <- states %>% group_by(state) %>% filter(state=="Washington", na.rm=TRUE) %>% summarize(cases, na.rm=TRUE)
plot(trend_wa)

# 6. Your learning  ----------------------------------------------------------

# R5.a REFLECTION: Please briefly comment on one of these or similar questions:
#      What, if anything, made you curious? What, if anything,
#      surprised you about this coding work? What might you do the same
#      or differently on your next data wrangling project?