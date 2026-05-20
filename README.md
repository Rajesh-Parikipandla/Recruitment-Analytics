# Recruitment Analytics
This project focuses on analyzing recruitment data to evaluate hiring efficiency, identify bottlenecks in the hiring pipeline, and support data-driven decision-making. The dashboard provides a comprehensive view of candidate flow, recruiter performance, sourcing 
effectiveness, placements, and overall recruitment trends using Microsoft Power BI and MySQL. 

<h2> Objectives: </h2>

* Analyze recruitment data to understand hiring trends and recruitment performance.  
* Track candidate movement across different stages of the hiring pipeline.  
* Evaluate recruiter performance based on submissions, interviews, and joining’s.  
* Identify bottlenecks affecting the recruitment process and hiring efficiency.  
* Measure important KPIs such as joining’s, revenue, conversion rate and time-to-hire.  
* Build an interactive dashboard to support data-driven recruitment decisions.

<h2>Dataset: </h2>

The dataset is structured across three Excel sheets 
Job_Requirements_Table:  
* Job_ID  
* Role  
* Client 
* Priority 
* Employment_Type 
* Open_Date 
* Close_Date 
* TAT 
* Requisition_Status 

Candidate_Pipeline_Table: 
* Candidate_ID  
* Job_ID 
* Visa_Status 
* Source (LinkedIn, Dice, Job Boards, Referral, Internal Database) 
* Recruiter_Name  
* Submission_Date 
* Interviewed 
* Offer 
* Joining_Status 
* Backout 
* TAT_Days 

Financial_Table: 
* Candidate_ID 
* Job_ID 
* Client  
* Bill_Rate  
* Pay_Rate 
* Total_Margin 

The three tables are linked relationally via Job_ID (between Jobs and Pipeline) and Candidate_ID (between Pipeline and Finance), forming a star-schema-like structure ideal for both SQL joins and Power BI data modelling. 

<h2>Tools & Technologies: </h2>

* Microsoft Excel — Used for storing and handling raw recruitment data.  
* Python — Used for data cleaning, preprocessing, and exploratory data analysis (EDA) using Pandas.  
* MySQL — Used for database creation, applying primary key and foreign key relationships, additional data cleaning, and solving business queries.  
* Microsoft Power BI — Used for KPI creation, dashboard development, and interactive data visualization.

<h2>Key Features: </h2>

* End-to-end recruitment analytics workflow  
* Data cleaning and preprocessing using Python and MySQL  
* Exploratory Data Analysis (EDA) for recruitment insights  
* Relational database design using primary and foreign keys  
* SQL-based business query analysis  
* KPI tracking for placements, revenue, recruiter performance, and hiring efficiency  
* Interactive dashboard creation using Microsoft Power BI  
* Visual analysis of recruitment pipeline and sourcing effectiveness  
* Business-focused insights for data-driven hiring decisions

<h2>Data Cleaning: </h2>

* Removed duplicate and null records from the dataset.
* Standardized column names, date formats, and text values.
* Handled missing and inconsistent recruitment data using Python (Pandas).
* Applied primary key and foreign key relationships in MySQL.
* Prepared clean and structured data for SQL analysis and dashboard reporting.

<h2>Python – Exploratory Data Analysis (EDA): </h2>

Python was used for Exploratory Data Analysis (EDA) using Pandas, Matplotlib, and Seaborn to understand recruitment trends and hiring performance.

The analysis included:

* Recruiter performance analysis
* Candidate pipeline stage analysis
* Source-wise candidate distribution
* Placement and closure trends
* Revenue analysis
* Hiring efficiency and time-to-hire metrics
* Identification of missing values, duplicates, and data inconsistencies

Various visualizations and charts were created to identify patterns, trends, and business insights from the recruitment dataset.

<h2>SQL Analysis: </h2>

MySQL was used to perform business query analysis on the recruitment dataset. SQL queries were written to analyze recruitment performance, hiring trends, recruiter productivity, joining's, revenue, and sourcing effectiveness.

The analysis included:

* Recruiter-wise performance analysis
* Client-wise hiring trends
* Candidate pipeline tracking
* Placement and closure analysis
* Revenue analysis
* Aging requisition analysis
* Source-wise hiring performance
* KPI calculations and business insights

Primary key and foreign key relationships were also created to maintain data integrity and support relational analysis.

<h2>Power BI Dashboard</h2>

An interactive dashboard was developed using Microsoft Power BI to visualize recruitment performance and key hiring metrics. The dashboard provides a clear and comprehensive view of the recruitment process through dynamic charts, KPIs, and filters.

The dashboard includes:

* Recruiter performance analysis
* Candidate pipeline tracking
* Placement and closure metrics
* Revenue analysis
* Source-wise hiring performance
* Client-wise recruitment trends
* Aging requisition analysis
* KPI cards for offers, revenue, submissions, interviews, and joining's

Interactive slicers and visualizations were used to support data-driven recruitment decisions and improve hiring efficiency.

<h2>Dashboard Preview: </h2>

![Recruitment Dashboard](Recruitment%20Analytics%20-%20PowerBI%20Image.jpg)

<h2>Key Insights: </h2>

* Identified top-performing recruiters based on candidate closures and joining’s.  
* Analyzed candidate movement across different hiring stages to detect recruitment bottlenecks.  
* Evaluated sourcing channels to understand the most effective candidate sources.  
* Tracked hiring trends, joining success rate, and recruiter productivity.  
* Measured important KPIs such as total joining’s, revenue generated, and average time-to-hire.  
* Developed interactive visualizations to support faster and data-driven recruitment decisions using Microsoft Power BI.

<h2>Recommendations: </h2>

*  Improve submission quality by strengthening pre-screening and improving JD-to profile matching to reduce irrelevant submissions and increase interview conversion rates.  
* Focus on high-performing recruiters such as Sanjay Mehta and Sunita Rao, who  generate higher revenue per closure. Their sourcing methods and client engagement strategies can be analyzed and replicated across teams.  
* Address aging job requisitions by reviewing positions that have remained open for a long period. Revising job requirements, prioritizing urgent roles, or closing inactive positions can improve recruitment efficiency.  
* Improve client-specific hiring performance by analyzing low fill-rate accounts such as Wipro and identifying challenges related to salary expectations, role requirements, or interview processes.  
* Optimize sourcing strategies by monitoring conversion rates across recruitment channels and allocating efforts toward higher-performing sources.  
* Track visa-related risks more effectively by monitoring OPT candidate work authorization timelines to reduce last-stage drop-offs and hiring delays.

<h2>Conclusion: </h2>

This project successfully demonstrates an end-to-end Recruitment Analytics workflow using  real-world US IT staffing data. The data was cleaned, analyzed, and transformed using Python and MySQL, followed by interactive dashboard creation in Microsoft Power BI. 
The analysis provided valuable insights into recruiter performance, hiring trends, sourcing effectiveness, placements, and recruitment bottlenecks. By tracking important KPIs and visualizing recruitment data, the project supports data-driven decision-making and helps 
improve overall hiring efficiency. 
This project also strengthened practical skills in data cleaning, SQL analysis, EDA, database design, and business intelligence reporting.

<h3>Rajesh Parikipandla <br>
Aspiring Data Analyst <br>
SQL | Power BI | Python | Excel <br> 
Hyderabad</h3>

