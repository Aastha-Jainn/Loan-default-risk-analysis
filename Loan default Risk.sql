SELECT * FROM loan_application;
SELECT * FROM borrower_profiles;

ALTER TABLE borrower_profiles
RENAME COLUMN ï»¿borrower_id TO borrower_id;

-- Some calculated overall parameters.
SELECT COUNT(Loan_id) AS NumOfLoans,
	   SUM(loan_amount) AS Total_loan_amount,
       ROUND(AVG(loan_amount),2) AS avg_loan_amount,
	   SUM(defaulted) as Total_defaults,
       ROUND(AVG(defaulted),2) AS overall_default_rate,
       ROUND(AVG(interest_rate),2) AS avg_int_rate,
       ROUND(AVG(dti_ratio),2) AS avg_dti_ratio
FROM loan_application;



-- Average default rate
SELECT 
    COUNT(Loan_id) AS total_loans,
    SUM(defaulted) AS defaulted_loans,
    ROUND(AVG(defaulted) * 100, 2) AS default_rate_pct
FROM 
	loan_application;
    
-- Default rate for each LOAN PURPOSE
SELECT loan_purpose, 
	   COUNT(Loan_id) AS NumOfLoans,
       SUM(defaulted) AS NumOfDefaulted_loans,
       ROUND(AVG(defaulted) *100, 2) AS default_rate_pct,
       ROUND(AVG(loan_amount), 2) AS avg_loan_amount
FROM loan_application
GROUP BY loan_purpose
ORDER BY default_rate_pct DESC;

-- Default rate for each type of employment status
SELECT b.employment_status,
	   COUNT(l.Loan_id) AS NumOfLoans,
       SUM(l.defaulted) AS NumOfDefaulted_loans,
       ROUND(AVG(l.defaulted)*100,2) AS default_rate_pct
FROM borrower_profiles b 
JOIN loan_application l 
ON b.borrower_id=l.borrower_id
GROUP BY b.employment_status
ORDER BY default_rate_pct DESC;

-- Average loan amount of defaulted vs. non-defaulted loans for each loan purpose.
SELECT loan_purpose,
	   ROUND(AVG(CASE WHEN defaulted=1
				THEN loan_amount
                END),2) AS avg_defaulted_loan_amount,
	   ROUND(AVG(CASE WHEN defaulted=0
				THEN loan_amount
                END), 2) AS avg_nonDefaulted_loan_amount
FROM loan_application
GROUP BY loan_purpose;


-- Avg Default rate and avg defaultLoan amount with home_ownership
SELECT b.home_ownership,
	   SUM(l.defaulted) AS NumOfdefaultedLoans,
       ROUND(AVG(l.defaulted)*100,2) AS avg_default_rate,
       ROUND(AVG(CASE WHEN l.defaulted=1
						THEN l.loan_amount
                        END),2) AS avg_Default_loan_amount
FROM borrower_profiles b
JOIN loan_application l 
ON b.borrower_id=l.borrower_id
GROUP BY b.home_ownership
ORDER BY avg_Default_loan_amount DESC;

-- Default Rate by credit score (creating bins for credit score)
SELECT MAX(credit_score), MIN(credit_score)
FROM borrower_profiles;

SELECT 
    b.borrower_id,
    b.credit_score,
    l.Loan_id,
    l.defaulted
FROM borrower_profiles b
JOIN loan_application l
    ON b.borrower_id = l.borrower_id;
    
SELECT 
    COUNT(*) AS total_borrowers,
    COUNT(credit_score) AS borrowers_with_credit_score,
    SUM(credit_score IS NULL) AS missing_credit_scores
FROM borrower_profiles;
SELECT COUNT(Loan_id) FROM loan_application;
    
SELECT 
	CASE
		WHEN b.credit_score BETWEEN 520 AND 599 THEN 'Poor(520-599)'
        WHEN b.credit_score BETWEEN 600 AND 649 THEN 'Fair(600-649)'
        WHEN b.credit_score BETWEEN 650 AND 699 THEN 'Good(650-699)'
        WHEN b.credit_score BETWEEN 700 AND 749 THEN 'Very good(700-749)'
        WHEN b.credit_score > 749 THEN 'Excellent(>750)'
	END AS credit_score_category,
    
    COUNT(l.Loan_id) AS total_loans,
    SUM(l.defaulted) AS defaulted_loans,
    ROUND(AVG(l.defaulted)*100,2) AS default_rate_pct
    
FROM borrower_profiles b
JOIN loan_application l
ON b.borrower_id=l.borrower_id
GROUP BY credit_score_category
ORDER BY default_rate_pct DESC;


-- DEFAULT RATE vs DTI ratio
SELECT
    MIN(dti_ratio) AS min_dti,
    MAX(dti_ratio) AS max_dti,
    ROUND(AVG(dti_ratio), 2) AS avg_dti,
    ROUND(STDDEV(dti_ratio), 2) AS std_dti
FROM loan_application;

SELECT 
	CASE
		WHEN dti_ratio<20 THEN 'Very low(<20)'
        WHEN dti_ratio BETWEEN 20 AND 40 THEN 'low(20-40)'
        WHEN dti_ratio BETWEEN 40 AND 60 THEN 'moderate(40-60)'
        WHEN dti_ratio BETWEEN 60 AND 80 THEN 'high(60-80)'
        WHEN dti_ratio>80 THEN 'Very high(>80)'
	END AS dti_category,
    COUNT(Loan_id) As total_loanss,
    SUM(defaulted) AS defaulted_loans,
    ROUND(AVG(defaulted)*100,2) AS default_rate_pct
    
FROM loan_application
GROUP BY dti_category
ORDER BY default_rate_pct DESC;

-- Default rate vs Dti_ratio+credit score
SELECT 
	CASE
		WHEN b.credit_score BETWEEN 520 AND 599 THEN 'Poor(520-599)'
        WHEN b.credit_score BETWEEN 600 AND 649 THEN 'Fair(600-649)'
        WHEN b.credit_score BETWEEN 650 AND 699 THEN 'Good(650-699)'
        WHEN b.credit_score BETWEEN 700 AND 749 THEN 'Very good(700-749)'
        WHEN b.credit_score > 749 THEN 'Excellent(>750)'
	END AS credit_score_category,
    CASE
		WHEN l.dti_ratio<20 THEN 'Very low(<20)'
        WHEN l.dti_ratio BETWEEN 20 AND 40 THEN 'low(20-40)'
        WHEN l.dti_ratio BETWEEN 40 AND 60 THEN 'moderate(40-60)'
        WHEN l.dti_ratio BETWEEN 60 AND 80 THEN 'high(60-80)'
        WHEN l.dti_ratio>80 THEN 'Very high(>80)'
	END AS dti_category,
    COUNT(l.Loan_id) AS total_loans,
    SUM(l.defaulted) AS defaulted_loans,
    ROUND(AVG(l.defaulted)*100, 2) AS default_rate_pct
FROM borrower_profiles b
JOIN loan_application l
ON b.borrower_id=l.borrower_id
GROUP BY credit_score_category,dti_category
ORDER BY default_rate_pct DESC;
    
-- Time-based analysis
SELECT application_date,
		YEAR(STR_TO_DATE(application_date, '%d-%m-%Y')) AS year
FROM loan_application;


SELECT YEAR(STR_TO_DATE(application_date, '%d-%m-%Y')) AS year,
		COUNT(Loan_id) as total_loans,
        SUM(defaulted) as defaulted_loans,
        ROUND(AVG(defaulted)*100,2) As default_rate_pct
FROM loan_application
GROUP BY year;

-- Are borrowers taking loans that are large relative to their income?
-- Loan-to-Income Ratio = Loan Amount / Annual Income
-- Comparing default rate wrt to loan income ratio
SELECT l.Loan_id, l.loan_amount, b.annual_income,
		ROUND(l.loan_amount/b.annual_income, 2) AS loan_income_ratio
FROM borrower_profiles b
JOIN loan_application l
ON b.borrower_id=l.borrower_id;

SELECT MAX(ROUND(l.loan_amount/b.annual_income, 2)),
	MIN(ROUND(l.loan_amount/b.annual_income, 2))
FROM borrower_profiles b
JOIN loan_application l
ON b.borrower_id=l.borrower_id;

SELECT
    CASE
        WHEN l.loan_amount / b.annual_income BETWEEN 0.00 AND 0.20 THEN '0-0.2'
        WHEN l.loan_amount / b.annual_income BETWEEN 0.20 AND 0.40  THEN '0.21-0.4'
        WHEN l.loan_amount / b.annual_income BETWEEN 0.40 AND 0.60 THEN '0.41-0.6'
        WHEN l.loan_amount / b.annual_income BETWEEN 0.60 AND 0.80 THEN '0.61-0.8'
        WHEN l.loan_amount / b.annual_income> 0.80 THEN '>0.80'
    END AS loan_income_ratio_category,

    COUNT(*) AS total_loans,
    SUM(l.defaulted) AS defaulted_loans,
    ROUND(AVG(l.defaulted) * 100, 2) AS default_rate_pct

FROM borrower_profiles b
JOIN loan_application l
ON b.borrower_id=l.borrower_id
GROUP BY loan_income_ratio_category
ORDER BY default_rate_pct;

SELECT MAX(days_delinquent), MIN(days_delinquent) FROM loan_application;

-- CREATING RISK SCORE for multiple factors
SELECT
    risk_score,
    COUNT(*) AS total_loans,
    SUM(defaulted) AS defaulted_loans,
    ROUND(AVG(defaulted) * 100, 2) AS default_rate_pct

FROM (
    SELECT
        l.loan_id,

        (
            CASE WHEN b.credit_score < 650 THEN 1 ELSE 0 END +
            CASE WHEN l.dti_ratio > 60 THEN 1 ELSE 0 END +
            CASE WHEN l.loan_amount / b.annual_income > 1 THEN 1 ELSE 0 END +
            CASE WHEN l.days_delinquent > 30 THEN 1 ELSE 0 END
        ) AS risk_score,

        l.defaulted

    FROM borrower_profiles b
	JOIN loan_application l
	ON b.borrower_id=l.borrower_id
) AS risk_data

GROUP BY risk_score
ORDER BY risk_score;

