SELECT
    u.id AS owner_id,
    u.name,
    COUNT(CASE WHEN p.is_regular_savings = 1 AND s.confirmed_amount > 0 THEN p.id END) AS savings_count,
    -- Count of regular savings plans with confirmed deposits greater than zero
    COUNT(CASE WHEN p.is_a_fund = 1 AND s.confirmed_amount > 0 THEN p.id END) AS investment_count,
    -- count of investment (fund) plans with confirmed deposits greater than zero
    SUM(s.confirmed_amount / 100) AS total_deposits
FROM
    users_customuser u
JOIN
    plans_plan p ON u.id = p.owner_id
LEFT JOIN
    savings_savingsaccount s ON p.id = s.plan_id
WHERE
    p.is_regular_savings = 1 AND s.confirmed_amount > 0
    OR p.is_a_fund = 1 AND s.confirmed_amount > 0
GROUP BY
    u.id, u.name
HAVING
    savings_count > 0 AND investment_count > 0 -- include only users who have at least one regular savings plan 
    -- AND at least one investment fund with confirmed deposits.
ORDER BY
    total_deposits DESC; -- ordering the results by highest total deposits