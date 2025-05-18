WITH MonthlyTransactions AS (
    SELECT
        u.id AS customer_id,
        DATE_FORMAT(s.transaction_date, '%Y-%m') AS transaction_month, -- extract the year and month 
        -- from the transaction date to group transactions monthly
        COUNT(*) AS transaction_count
    FROM
        users_customuser u
    JOIN
        savings_savingsaccount s ON u.id = s.owner_id
    WHERE
        s.confirmed_amount > 0 -- consider only inflow transactions
    GROUP BY
        u.id,
        transaction_month
),
CustomerMonthlyAverages AS (
    SELECT
        customer_id,
        AVG(transaction_count) AS avg_monthly_transactions
    FROM
        MonthlyTransactions
    GROUP BY
        customer_id
)
SELECT
    CASE
        WHEN cma.avg_monthly_transactions < 3 THEN 'Low Frequency'
        WHEN cma.avg_monthly_transactions >= 3 AND cma.avg_monthly_transactions < 10 THEN 'Medium Frequency'
        WHEN cma.avg_monthly_transactions >= 10 THEN 'High Frequency'
        
    END AS frequency_category, -- categorize customers based on their average monthly transaction frequency
    COUNT(cma.customer_id) AS customer_count,
    AVG(cma.avg_monthly_transactions) AS avg_transactions_per_month
FROM
    CustomerMonthlyAverages cma
GROUP BY
    frequency_category;