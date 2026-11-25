\# E-commerce Customer Behaviour \& Sales Intelligence



\## 1. Project Overview



This project analyses real-world historical e-commerce transaction data to understand sales performance, customer purchasing behaviour, product performance and revenue trends.



The project uses Excel, MySQL and Power BI to transform raw transaction data into meaningful business insights and interactive dashboards.



\## 2. Business Problem



E-commerce businesses generate large amounts of transaction data. However, raw data alone cannot explain which products generate the most revenue, which customers contribute the most value, or when sales are highest.



This project addresses these questions through data cleaning, exploratory analysis, SQL queries and interactive visualisation.



\## 3. Project Objectives



\- Clean and prepare raw e-commerce transaction data.

\- Analyse overall sales performance and revenue trends.

\- Identify top-performing products and countries.

\- Understand customer purchasing frequency and repeat behaviour.

\- Segment customers based on spending and RFM analysis.

\- Develop an interactive Power BI dashboard.

\- Generate actionable business recommendations.



\## 4. Dataset Information



\*\*Dataset:\*\* Online Retail Dataset  

\*\*Source:\*\* UCI Machine Learning Repository  

\*\*Link:\*\* https://archive.ics.uci.edu/dataset/352/online+retail



The dataset contains historical transactions from a UK-based online retailer between December 2010 and December 2011.



Original dataset:

\- 541,909 transaction records

\- 8 columns



After data cleaning:

\- 392,692 transaction records

\- 9 columns, including the calculated Revenue column



The analysis uses the cleaned dataset.



\## 5. Tools and Technologies



\- Microsoft Excel – Data cleaning, formulas, PivotTables and sales analysis.

\- MySQL – Data querying, aggregation, customer analysis and RFM segmentation.

\- Power BI – Interactive dashboard development and data visualisation.

\- SQL – Data analysis using GROUP BY, subqueries, CASE statements, CTEs and window functions.



\## 6. Data Cleaning



The original dataset was inspected for:

\- Missing Customer IDs and product descriptions.

\- Duplicate records.

\- Cancelled transactions.

\- Negative quantities.

\- Zero or negative unit prices.



Invalid records were removed according to the project's cleaning rules.



A new Revenue column was calculated:



Revenue = Quantity × UnitPrice



\## 7. SQL Analysis



The SQL analysis covered:



1\. Overall sales performance.

2\. Average Order Value (AOV).

3\. Monthly revenue trends.

4\. Country-wise revenue analysis.

5\. Top-performing products.

6\. Top customers by revenue.

7\. Repeat customer analysis.

8\. Customer spending segmentation.

9\. Sales by day of the week.

10\. Monthly order trends.

11\. Quarterly sales analysis.

12\. Country-wise revenue contribution.

13\. Customer purchase frequency.

14\. Sales by hour of the day.

15\. RFM metric calculation.

16\. RFM customer segmentation.

17\. Revenue contribution by RFM segment.



\## 8. Power BI Dashboard



The interactive dashboard includes:



\- Total Revenue

\- Total Orders

\- Total Customers

\- Average Order Value

\- Monthly Revenue Trend

\- Country-wise Revenue

\- Top Products

\- Top Customers

\- Date and Country slicers



\## 9. Project Screenshots



### Power BI Dashboard

![Power BI Dashboard](Screenshots/Screenshot%202026-11-25%20133212.png)

### Excel Analysis

![Excel Analysis 1](Screenshots/Screenshot%202026-11-25%20133420.png)

![Excel Analysis 2](Screenshots/Screenshot%202026-11-25%20133434.png)


### SQL Analysis

![SQL Analysis 1](Screenshots/Screenshot%202026-11-25%20133731.png)

![SQL Analysis 2](Screenshots/Screenshot%202026-11-25%20133818.png)




\## 10. Key Business Findings



Based on the cleaned dataset:



\- Total Revenue: £8,887,208.89

\- Total Orders: 18,532

\- Total Customers: 4,338

\- Total Quantity Sold: 5,152,002

\- Average Order Value: £479.56

\- Repeat Customers: 2,845

\- UK Revenue Contribution: 81.97%

\- Champions Customer Segment: 994 customers

\- Champions Revenue Contribution: Approximately 65.47%



\## 11. Business Recommendations



\- Focus on retaining high-value customers through loyalty programmes.

\- Encourage one-time customers to make repeat purchases.

\- Develop targeted campaigns for at-risk customers.

\- Explore opportunities to increase international sales.

\- Promote high-performing products.

\- Align marketing activities with peak purchasing hours.



\## 12. Project Structure



\- Datasets – Original and cleaned datasets.

\- Excel Analysis – Data cleaning, analysis.

\- SQL Analysis – Consolidated SQL analysis script.

\- Power BI Dashboard – Interactive business intelligence dashboard.



\## 13. Conclusion



This project demonstrates an end-to-end data analytics workflow, starting from raw transaction data and progressing through data cleaning, SQL analysis and dashboard development.



It highlights how data analytics can help businesses understand customer behaviour, monitor sales performance and make data-driven decisions.



\## 14. Data Source



UCI Machine Learning Repository – Online Retail Dataset



https://archive.ics.uci.edu/dataset/352/online+retail

