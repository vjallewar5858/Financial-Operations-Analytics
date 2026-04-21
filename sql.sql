-- renamed table
ALTER TABLE "bank-additional-full" RENAME TO bank_customers;

-- customer base review

SELECT 
    COUNT(*) AS total_customers,
    AVG(age) AS avg_age,
    MIN(age) AS youngest,
    MAX(age) AS oldest
FROM bank_customers;

--column names--
PRAGMA table_info(bank_customers);

-- Identifying target segments for revenue strategy--
SELECT 
    job,
    COUNT(*) AS customer_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bank_customers), 2) AS percentage
FROM bank_customers
GROUP BY job
ORDER BY customer_count DESC;

-- KPI: conversion rate = subscribers / tota customers per segment--
SELECT 
    job,
    COUNT(*) AS total,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate_pct
FROM bank_customers
GROUP BY job
ORDER BY conversion_rate_pct DESC;

-- what portion of customers carry default risk?--
SELECT 
    "default",
    loan,
    housing,
    COUNT(*) AS customer_count
FROM bank_customers
GROUP BY "default", loan, housing
ORDER BY customer_count DESC;

--renaming some columns__

ALTER TABLE bank_customers 
RENAME COLUMN "default" TO default_status;
RENAME COLUMN "emp.var.rate" TO emp_var_rate;
RENAME COLUMN "cons.price.idx" TO cons_price_idx;
RENAME COLUMN "cons.conf.idx" TO cons_conf_idx;

--which month yeilds best depositw subscription rate--
SELECT 
    month,
    COUNT(*) AS contacts,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS success_rate
FROM bank_customers
GROUP BY month
ORDER BY success_rate DESC;

-- segment customers for targeted product offers--
SELECT 
    education,
    COUNT(*) AS total,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS converted,
    ROUND(AVG(CASE WHEN y = 'yes' THEN 1.0 ELSE 0.0 END) * 100, 2) AS conversion_pct
FROM bank_customers
GROUP BY education
ORDER BY conversion_pct DESC;

--Do customers with successful prior contact convert better?--
SELECT 
    poutcome AS previous_outcome,
    COUNT(*) AS customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS converted,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate
FROM bank_customers
GROUP BY poutcome
ORDER BY conversion_rate DESC;

--which age gap is our most valuable customer--
SELECT 
    CASE 
        WHEN age < 25 THEN 'Under 25'
        WHEN age BETWEEN 25 AND 34 THEN '25–34'
        WHEN age BETWEEN 35 AND 44 THEN '35–44'
        WHEN age BETWEEN 45 AND 54 THEN '45–54'
        WHEN age BETWEEN 55 AND 64 THEN '55–64'
        ELSE '65+' 
    END AS age_band,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate
FROM bank_customers
GROUP BY age_band
ORDER BY conversion_rate DESC;

-- Executive summary — where are conversions concentrated?--

SELECT 
    job,
    education,
    COUNT(*) AS segment_size,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS total_converted,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate,
    ROUND(AVG(age), 1) AS avg_age
FROM bank_customers
GROUP BY job, education
HAVING total_converted > 50
ORDER BY conversion_rate DESC
LIMIT 10;