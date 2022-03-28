#  Assignment Overview
 Assignment 2: U.S. COVID Trends  (INFO-201, Winter 2022)

 Acknowledgement:
 Thanks to Mike Freeman, Kyle Thayer, and David Hendry for developing this assignment.


## 1 Background
```
       |       xxx
       |      x
       |     x
  f(t) |       
       |    x
       |xxxx      
       -----------------
        123456789 ... N
             Time --->
```
 This figure shows a rough sketch of a "cumulative sum" time series.

 A time series means data collected sequentially, usually at regular
 time intervals; for example, every 15 minutes, every 24 hours, or
 some other appropriate unit of time. A "cumulative sum" means that
 at each point something changes and that the time series is the sum
 of all previous changes.

 Each "x" in the figure represents a data point in a time series,
 with 1 being the earliest recording and N being the most recent.
 The y-axis, represents the cumulative sum of things being counted.
 Sometimes there are large changes, sometimes there are no changes.

 In a cumulative sum time series, the most recent point is also
 the total count (objects made, tasks completed, events that
 have occurred, etc.).

## 2 Introduction

 In this assignment, you will work with three datasets, each  
 is a cumulative sum time series. The time interval is one day (24 hours) and two things are being recorded during
 each daily interval:

    - cases -  the number of COVID infections
    - deaths - the number of deaths due to COVID

 Further, the case and death counts are collected at three different geographic levels:

     - national
        - The U.S. nation as a whole
     - state
        - U.S. States (50 official U.S. States, plus District of Columbia, plus other territories)
     - county
        - Each state is divided into counties. There are around 3,000 counties in the U.S. And, FYI, Washington State has 39 counties.*

 These geographic levels differ in granularity. A state is made up of
 counties and the nation as a whole is made of states.  Thus, in theory
 the county data should add up to the state data and the state data should
 add up to the national data.

 The data for Assignment 2 come from the New York Times

     The New York Times. (2022). Coronavirus (Covid-19) Data in the
          United States. Retrieved [January, 2022],
          from https://github.com/nytimes/covid-19-data."

 The charts that you might have seen in the New York Times
 are created from this data:
      https://www.nytimes.com/interactive/2021/us/covid-cases.html

It worth pausing to consider what this data represents and the profound importance it has had on all of our lives.

### 3 Instructions

 As with Assignment 1, there are two kinds of prompts:

    Coding prompts:      Write the necessary code to compute the answer.
                         For grading, it is important that you store your
                         answers in the variable names listed with each
                         question in `backtics`. Please make sure to store
                         the appropriate variable type (e.g.,
                         a string, a vector, a data frame, etc.).

                         Note: Unless otherwise stated, use DPLYR functions
                         to solve all coding tasks.

    Reflection prompts:  For each prompt marked `REFLECTION`, please write
                         a response in your `README.md` file.

 ## 4 Getting Started

 Some of the coding prompts are difficult. If you get stuck,
 here are some suggestions:

1. Work slowly and systematically. Try to break the problem into small parts and tackle the parts, one by one.   
2. Clear the RStudio environment variables frequently. Check that variables contain exactly that data you expect. It is good practice to source your code from the beginning of the file.  
3. Go to the textbook and study the basics - complete the lecture exercises.   
4. Search and read the dplyr documentation here:  
- dplyr API documents: https://dplyr.tidyverse.org/reference/index.html  
- dply cheatsheet    : https://github.com/rstudio/cheatsheets/blob/main/data-transformation.pdf  
5. Post a message on Discord and/or ask for help from your TA
6. Do a Google search.  

  As always, if something is unclear please ask a Teaching Assistant.
