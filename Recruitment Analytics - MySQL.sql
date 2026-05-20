show databases;
create database recruitment_analytics;
use recruitment_analytics;

show tables;
select * from candidates_pool;
select * from finance_details;
select * from jobs;

describe jobs;
describe candidates_pool;
describe finance_details;

-- adjusting type in jobs --

alter table jobs
add primary key (job_id),
modify job_id varchar(20),
modify `role` varchar(100),
modify `client` varchar(20),
modify client_spoc varchar(50),
modify open_date date,
modify closing_date date;

-- adjusting type in candidates_pool --

select * from candidates_pool;

select sum(interview_date is null or interview_date = '') from candidates_pool;

SET SQL_SAFE_UPDATES = 0;

UPDATE candidates_pool
SET submission_date = NULL
WHERE submission_date = '' or submission_date is null;

UPDATE candidates_pool
SET interview_date = NULL
WHERE interview_date = '' or interview_date is null;

UPDATE candidates_pool
SET offer_date = NULL
WHERE offer_date = '' or offer_date is null;

UPDATE candidates_pool
SET joining_date = NULL
WHERE joining_date = '' or joining_date is null;

UPDATE candidates_pool
SET tat_days = NULL
WHERE tat_days = '' or tat_days is null;

UPDATE candidates_pool
SET submission_to_interview_days = NULL
WHERE submission_to_interview_days = '' or submission_to_interview_days is null;

describe candidates_pool;

alter table candidates_pool
add primary key (candidate_id),
modify candidate_id varchar(20),
add foreign key (job_id) references jobs(job_id),
modify job_id varchar(20),
modify candidate_name varchar(100),
modify candidate_email varchar(100),
modify `role` varchar(100),
modify visa_status varchar(30),
modify `source` varchar(20),
modify recruiter_emp_id varchar(100),
modify recruiter_name varchar(100),
modify submission_date date,
modify interview_date date,
modify offer_date date,
modify joining_date date,
modify offer varchar(40),
modify client_spoc varchar(40),
modify offer_acceptance tinyint,
modify tat_bucket varchar(20);

describe finance_details;

select * from finance_details;

select DISTINCT f.candidate_id
from finance_details f
left join candidates_pool c
on f.candidate_id = c.candidate_id
where c.candidate_id is null or c.candidate_id = '';

delete from finance_details
where candidate_id in (
'CAND006',
'CAND024',
'CAND113',
'CAND147',
'CAND164',
'CAND206',
'CAND307',
'CAND400'
);

UPDATE finance_details
SET candidate_id = TRIM(candidate_id);

UPDATE candidates_pool
SET candidate_id = TRIM(candidate_id);

alter table finance_details
add foreign key (job_id) references jobs(job_id),
modify job_id varchar(20),
add foreign key (candidate_id) references candidates_pool(candidate_id),
modify candidate_id varchar(20),
modify client varchar(20);

create table recruitment_summary as
select
p.candidate_id,
p.job_id,
p.role,
p.client,
p.recruiter_name,
p.source,
p.visa_status,
p.notice_period,
p.interviewed,
p.offer,
p.joining_status,
p.backout,
p.tat_days,
j.priority,
j.requisition_status,
f.total_margin
from candidates_pool p
left join jobs j
on p.job_id = j.job_id
left join finance_details f
on p.candidate_id = f.candidate_id;

select * from recruitment_summary;


/* =========================================
           Avg TAT by Priority & Client
========================================= */

select
client,
priority,
round(avg(tat_days),2) as avg_tat
from recruitment_summary
group by client,priority
order by avg_tat desc;


/* =========================================
    Recruiter Ranking by Closures & Margin
========================================= */

with recruiter_perf as(
select
recruiter_name,
count(case when joining_status='Joined' then 1 end) as total_closures,
round(sum(total_margin),2) as total_margin
from recruitment_summary
group by recruiter_name
)

select *,
dense_rank() over(
order by total_closures desc,total_margin desc
) as recruiter_rank
from recruiter_perf;


/* =========================================
		Backout Rate by Visa & SourceT
========================================= */

select
visa_status, source, count(*) as total_offers,
sum(case when backout='Yes' then 1 else 0 end) as backouts,
round(
100.0*
sum(case when backout='Yes' then 1 else 0 end)
/count(*),2
) as backout_rate
from recruitment_summary
where offer='Yes'
group by visa_status,source
order by backout_rate desc;


/* =========================================
         Pipeline Conversion Funnel
========================================= */

select
count(*) as total_submissions,
sum(case when interviewed='Yes' then 1 else 0 end) as interviews,
sum(case when offer='Yes' then 1 else 0 end) as offers,
sum(case when joining_status='Joined' then 1 else 0 end) as joins
from recruitment_summary;


/* =========================================
           Aging Jobs >30 Days
========================================= */

select
job_id, client, role, days_open, target_submissions
from jobs
where days_open > 30
and target_submissions < 5
order by days_open desc;


/* =========================================
		Monthly Submission Trend
========================================= */

select
submission_month,
count(*) as total_submissions,
sum(closure_flag) as closures
from candidates_pool
group by submission_month
order by submission_month;


/* =========================================
		Client-wise Fill Rate & Revenue
========================================= */

select
client,
count(distinct job_id) as total_jobs,
sum(case when joining_status='Joined' then 1 else 0 end) as total_hires,
round(
100.0*
sum(case when joining_status='Joined' then 1 else 0 end)
/count(distinct job_id),2
) as fill_rate,
round(sum(total_margin),2) as revenue
from recruitment_summary
group by client
order by revenue desc;


/* =========================================
          Visa Status Conversion
========================================= */

select
visa_status,
count(*) as submissions,
sum(case when joining_status='Joined' then 1 else 0 end) as hires,
round(
100.0*
sum(case when joining_status='Joined' then 1 else 0 end)
/count(*),2
) as conversion_rate
from recruitment_summary
group by visa_status
order by conversion_rate desc;


/* =========================================
          Source Effectiveness
========================================= */

select
source,
count(*) as total_submissions,
sum(case when joining_status='Joined' then 1 else 0 end) as total_hires,
sum(total_margin) as revenue,
round(
100.0*
sum(case when joining_status='Joined' then 1 else 0 end)
/count(*),2
) as conversion_rate
from recruitment_summary
group by source
order by conversion_rate desc;


/* =========================================
         TAT Bucket Distribution
========================================= */

select
case
when tat_days<=15 then 'Fast'
when tat_days<=30 then 'Moderate'
when tat_days<=60 then 'Slow'
else 'Critical'
end as tat_category,
count(*) as total_hires
from recruitment_summary
group by tat_category;

/* =========================================
		Notice Period Impact on Backout
========================================= */

select
notice_period,
count(*) as total_offers,
sum(case when backout='Yes' then 1 else 0 end) as backouts,
round(
100.0*
sum(case when backout='Yes' then 1 else 0 end)
/count(*),2
) as backout_rate
from recruitment_summary
where offer='Yes'
group by notice_period
order by backout_rate desc;

-- Createing Dimension Tables --

create table recruiter as
select distinct recruiter_name
from candidates_pool;

alter table recruiter
add recruiter_id int auto_increment primary key;

select * from recruiter;

create table client as
select distinct client
from jobs;

alter table client
add client_id int auto_increment primary key;

alter table candidates_pool
add recruiter_id int;

update candidates_pool p
join recruiter r
on p.recruiter_name=r.recruiter_name
set p.recruiter_id=r.recruiter_id;

select * from candidates_pool;

alter table jobs
add client_id int;


update jobs j
join client c
on j.client=c.client
set j.client_id=c.client_id;

select * from jobs;