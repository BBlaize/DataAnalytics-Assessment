WITH CustomerTransactions AS (
    SELECT
        u.id AS customer_id,
        u.name,
        COUNT(s.id) AS total_transactions,
        SUM(s.confirmed_amount) AS total_inflow_value, -- the earliest signup date for each customer
        MIN(u.created_on) AS signup_date
    FROM
        users_customuser u
    LEFT JOIN
        savings_savingsaccount s ON u.id = s.owner_id
    WHERE
        s.confirmed_amount > 0 -- only transactions with a positive confirmed amount (inflows)
    GROUP BY
        u.id, u.name
),
AccountTenure AS (
    SELECT
        customer_id,
        name,
        total_transactions,
        total_inflow_value,
        TIMESTAMPDIFF(MONTH, signup_date, CURDATE()) AS tenure_months 
        -- calculate the difference in months between signup and now
    FROM
        CustomerTransactions
    WHERE
        TIMESTAMPDIFF(MONTH, signup_date, CURDATE()) > 0 
) -- exclude customers with zero tenure to avoid division by zero
SELECT
    at.customer_id,
    at.name,
    at.tenure_months,
    at.total_transactions,
    (at.total_transactions / at.tenure_months) * 12 * (at.total_inflow_value / at.total_transactions * 0.001 / 100) AS estimated_clv
FROM
    AccountTenure at
WHERE
    at.total_transactions > 0 -- CLV is calculated for customers with at least one transaction
ORDER BY
    estimated_clv DESC;