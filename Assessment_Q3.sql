SELECT
    p.id AS plan_id,
    p.owner_id,
    CASE
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type, -- find the most recent transaction date for each plan
    MAX(s.transaction_date) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days
FROM
    plans_plan p
LEFT JOIN
    savings_savingsaccount s ON p.id = s.plan_id
WHERE
    p.is_deleted = 0 -- active plans
    AND p.is_archived = 0
GROUP BY
    p.id, p.owner_id, type
HAVING
    MAX(s.transaction_date) < DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    OR MAX(s.transaction_date) IS NULL  -- filter for plans where the last transaction date 
    -- is older than one year from the current date OR where there have been no transactions at all
ORDER BY
    inactivity_days DESC;