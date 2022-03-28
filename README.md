# A2: U.S. COVID Trends

## Overview
In many ways, we have come to understand the gravity and trends in the COVID-19 pandemic through data. Regardless of media source, people are consuming more epidemiological information than ever, primarily through reported figures, charts, and maps.

This assignment is your opportunity to work directly with the same data used by the New York Times. While the analysis is guided through a series of questions, it is your opportunity to use programming skills to ask more detailed questions about the pandemic.

You'll load the data directly from the [New York Times GitHub page](https://github.com/nytimes/covid-19-data/), and you should make sure to read through their documentation to understand the meaning of the datasets.

Note: this is a long assignment. I strongly suggest that you **start early**, and approach it with patience. We're asking real questions of real data, and there is inherent trickiness involved.

For more helpful details, see `assignment-overview.md`

## Getting Started
You should start this assignment by opening up the `analysis.R` script. The script will guide you through an initial analysis of the data.

* **Coding prompts.** Complete the coding prompts in `analysis.R`.  Your goal is correct code that is understanable.
* **Reflection prompts.** Throughout the script, there are prompts labeled `REFLECTION`. Please write 1 - 3 sentences for each of these prompts below.
As appropriate, provide evidence (e.g., facts from the datasets), give justification for your opinions, or genuinely reflect on your views.  Please strive for concise, clear, and interesting writing.

## Reflection Prompts

**R1:** Loading Data  
 R1. REFLECTION:  
(a) How does the County-level data differ from the the State-level and U.S. National-level?

The national-level has the least number of rows and columns. It also has the least number of observations.

(b) What is the same about these three datasets?

The one same case happening in the county are also be recorded in both state-level and nation-level.

(c) What does the feature "fips" mean? Do a Google search and/or visit: https://www.census.gov/library/reference/code-lists/ansi.html

Fips is the Federal Information Processing Standards. FIPS are standards and guidelines for federal computer systems that are developed by National Institute of Standards and Technology (NIST) in accordance with the Federal Information Security Management Act (FISMA) and approved by the Secretary of Commerce.

**R2**: Exploratory Analysis  
R2. REFLECTION:   

(a) What did you learn about the dataset when you calculated the state with the lowest cases? What does that tell you about testing your assumptions in a dataset?

It is surprised to see that there is only one case in American Samoa. Dealing with the complicated calculation, the best way is write the code step by step.

(b) Is the location with the highest number of cases the location with the most deaths? If not, why do you believe that may be the case?

The county with the highest cases is not the county with the highest death. The number of death is corresponding to the local medical level.

**R3**: Grouped Analysis  
R3. REFLECTION:  

(a) Why are there so many observations (counties) in the variable `lowest_in_each_state`? That is, wouldn't you expect the number to be around 50?

Before I ran my code, I did expect the number should be about the number of states. But after I printed out the result, I realized that the lowest county in each state can be not only one. That is why the observations in variable `lowest_in_each_state` are more than what I expected.

**R4:** Joins  
R4. REFLECTION:   
When the check was carried out on January 25, 2022, an inconsistency was found.

(a) Given the work that you've just completed (4.a - 4.f), what can you say about the source of the inconsistency?

The number of cases in states and the number of cases in nation may come from different primary source. It is predictable that different sources have different result.

(b) What might be your next step to discover where exactly in the data the inconsistency lies?

We can deep into the data by counties and states. Also, we can even to find the data from other primary source and do a comparsion.

**R5**: Your Learning  
R5. REFLECTION    
(a) What, if anything, made you curious? What, if anything, surprised you about this coding work? What might you do the same or differently on your next data wrangling project?

I got a sense of achievement by using code to find the specific summary behind the huge set of data. I am also surprised I can camp up the new material we learned in class easily when I was coding. Overall, it is pretty interesting to use R dealing with a huge set of data.
