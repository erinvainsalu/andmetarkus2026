# Employee Report

## Problem Statement
HR department wants an overview of active and left employees over time and results of the satisfaction survey.

## Plan
I will create a Power BI report to give this overview.

## Data
HR department provided two files:
- Employee_Satisfaction_Survey.xlsx
- HR_dataset.csv

### Data cleaning
I checked data for uniqueness, formats and outliers through PowerQuery.
Survey dataset didn't have an unique key column. I created a new column "AnswerKey" which combined "Question Round" and "Answer ID".
In HR dataset I removed columns containing personal data: "First Name", "Last Name", "Email". Also removed column "Employment Status" as the data in that column was not up to date according to the HR department.
Column "Salary" was changed to Decimal Number format.