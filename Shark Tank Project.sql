
-- Shark Tank Project SQL Script

use xyz;
-- 1.
SELECT * 
FROM shark_tank_cleaned_final;

-- 2. Count total startups
SELECT COUNT(*) AS total_startups 
FROM shark_tank_cleaned_final;

-- 3 Derived Column Deal_Status
SELECT 
    Startup,
    Industry,
    Investor,
    `Ask_Amount(USD)`,
    `Deal_Amount(USD)`,
    `Equity_Asked(%)`,
    `Equity_Given(%)`,
    CASE 
        WHEN `Deal_Amount_Cleaned` > 0 AND Investor <> 'No Deal' THEN 'Deal'
        ELSE 'No Deal'
    END AS Deal_Status
FROM shark_tank_cleaned_final;

-- Queries For Insight 

-- 4  Industry wise startup count

SELECT Industry, COUNT(*) AS startup_count
FROM shark_tank_cleaned_final
GROUP BY Industry
ORDER BY startup_count DESC;

-- 5 Investor wise deals

SELECT Investor, COUNT(*) AS total_deals, SUM(`Deal_Amount_cleaned`) AS total_investment
FROM shark_tank_cleaned_final
WHERE Investor <> 'No Deal'
GROUP BY Investor
ORDER BY total_investment DESC;

-- 6 Equity analyze
SELECT 
    AVG(`Equity_Asked(%)`) AS avg_equity_asked,
    AVG(`Equity_Given(%)`) AS avg_equity_given
FROM shark_tank_cleaned_final;

-- 7 Startup with highest ask

SELECT Startup, Industry, `Ask_Amount(USD)`
FROM shark_tank_cleaned_final
ORDER BY `Ask_Amount(USD)` DESC
LIMIT 1;

-- 8  Success Rate of Startups
SELECT 
    CASE 
        WHEN `Deal_Amount_cleaned` > 0 THEN 'Deal' 
        ELSE 'No Deal' 
    END AS Deal_Status,
    COUNT(*) AS total_startups,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM shark_tank_cleaned_final), 2) AS percentage
FROM shark_tank_cleaned_final
GROUP BY Deal_Status;





