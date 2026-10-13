Customer Churn Analysis Using SQL

Project Overview

This project analyzes customer churn to understand which customers leave the service, which customer segments have higher churn, and which customer behaviors are associated with customer attrition.

The goal is to transform customer data into actionable business insights and recommendations that could help improve customer retention.

Project Objectives

Measure overall customer churn.

Compare churn across customer segments.

Explore customer behavior associated with churn.

Compare spending between active and churned customers.

Apply advanced SQL techniques to analyze customer data.

Identify high-risk customer segments and propose retention strategies.

Dataset and Tools

Dataset: Customer Churn Dataset from Kaggle

Database: SQLite

Tools: Python, Pandas, SQLite, SQL

Project Workflow

1. Data Exploration

Loaded the training dataset using Pandas.

Reviewed the dataset structure, rows, columns, and data types.

Checked missing values and customer ID uniqueness.

Identified an entirely empty row in the dataset.

2. Data Cleaning

Removed the entirely empty row.

Checked customer ID uniqueness.

Loaded the cleaned training data into an SQLite database.

Created the customer_churn table for SQL analysis.

3. Overall Churn Analysis

Analyzed the overall churn rate and compared the number of churned customers with active customers.

Key findings:

The dataset contained 249,999 churned customers and 190,833 active customers.

The overall churn rate was 56.71%.

SQL techniques: COUNT(), CASE, GROUP BY, ORDER BY, and aggregate functions.

4. Customer Segmentation

Compared churn across different customer groups.

Segments analyzed:

Subscription Type

Contract Length

Gender

Age Group

Key findings:

Basic had the highest churn rate among the three subscription types.

All customers with monthly contracts were labeled as churned in this dataset.

Churn rates differed across gender and age groups.

The 60–65 age group had a 100% observed churn rate, while the 50–59 group also showed unusually high churn.

SQL techniques: CASE, AVG(), GROUP BY, and ORDER BY.

5. Customer Behavior Analysis

Explored the relationship between churn and customer behavior.

Factors analyzed:

Support Calls

Payment Delay

Usage Frequency

Tenure

Last Interaction

Key findings:

Customers with more support calls generally showed higher churn rates.

Payment delays of 21–30 days were associated with a 100% observed churn rate.

Lower usage frequency was generally associated with higher churn.

Shorter tenure values showed higher churn in the observed results.

Longer periods since the last interaction were associated with higher churn.

SQL techniques: AVG(), GROUP BY, ORDER BY, and LIMIT.

6. Customer Value Analysis

Compared average total spending between active and churned customers.

Key findings:

Active customers had an average total spend of 749.95.

Churned customers had an average total spend of 541.29.

Active customers had higher average spending across all three subscription types.

SQL techniques: AVG(), GROUP BY, and multi-column grouping.

7. Advanced SQL Analysis

Applied advanced SQL concepts to deepen the analysis.

Techniques used:

CTE: Organized intermediate churn-rate calculations.

RANK(): Ranked subscription types by churn rate and customers by spending.

DENSE_RANK(): Ranked customers while avoiding gaps between tied ranks.

LIMIT: Retrieved the top 10 customers by total spending.

AVG() OVER(): Compared individual customer spending with the average for their subscription type.

LAG(): Retrieved the previous customer's spending in customer ID order.

LEAD(): Retrieved the next customer's spending in customer ID order.

SUM() OVER(): Calculated a running total of spending within each subscription type.

8. High-Risk Customer Analysis

Combined multiple behavioral indicators to examine a customer segment with high observed churn.

Conditions tested:

Support Calls >= 5

Payment Delay >= 21

Usage Frequency <= 9 as an additional condition

Key findings:

Customers meeting the first two conditions: 45,837.

Customers meeting all three conditions: 13,803.

All customers in both segments were labeled as churned in this dataset.

These results identify a segment worth investigating, but the unusually strong pattern should be validated before being used in business decisions.

Business Insights

Contract Risk: Monthly-contract customers showed an unusually high level of churn.

Subscription Risk: Basic subscriptions had the highest churn rate among subscription types.

Support and Payments: Frequent support calls and long payment delays were associated with higher churn.

Engagement: Lower usage and longer periods without interaction were associated with higher churn.

Customer Value: Churned customers had lower average total spending than active customers.

High-Risk Segment: Customers meeting the selected support-call and payment-delay conditions had complete observed churn in this dataset.

Business Recommendations

Investigate Monthly Contracts: Examine why monthly-contract customers are churning and test retention strategies.

Improve Customer Support: Identify recurring support issues and address their root causes.

Proactively Contact At-Risk Customers: Investigate customer needs when frequent support calls and payment delays occur together.

Improve Engagement: Test personalized campaigns for customers with low usage or long periods without interaction.

Understand Spending Patterns: Investigate why average spending differs between active and churned customers.

Validate Unusual Patterns: Review data quality, churn definitions, and segment sizes before applying these findings operationally.

Limitations

The analysis identifies associations and does not establish causation.

Some segments show unusually high churn, including 100% observed rates. These results require further validation.

The analysis is based on the available training dataset and may not represent all real-world customers.

The top 10 spending results may include ties, meaning multiple customers can share the same spending value.

Repository Structure

customer-churn-analysis/
├── README.md
└── customer_churn_analysis.sql

