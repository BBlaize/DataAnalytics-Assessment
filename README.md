# DataAnalytics-Assessment
## Per-Question Explanations
### 1.  High-Value Customers with Multiple Products
The objective is to dentify customers with both funded savings and investment plans, ordered by total deposits.
The process I followed is to:
- Join users_customuser, plans_plan, and savings_savingsaccount to link customers, plans, and transactions.
- Filters for plans with confirmed_amount > 0 (funded).
- Use conditional COUNT to count funded savings and investment plans separately.
- Use HAVING clause to ensure customers have at least one of funded savings and investment plan type.
- Lastly, Order by total_deposits to find high-value customers.
### 2. Transaction Frequency Analysis
The objective is to categorise customers by monthly transaction frequency (High, Medium, Low). The process I followed is to:
- Create MonthlyTransactions CTE: It counts transactions per customer per month, filtering for inflows.
- Create CustomerMonthlyAverages CTE: It calculates the average monthly transactions for each customer.
- Create Main query: I used a CASE statement to categorise customers based on the average.
- Count customers and calculate the average transaction frequency for each category.
### 3. Account Inactivity Alert
The objective is to identify inactive accounts (no transactions in the past year). The process I followed is to:
- Join plans_plan and savings_savingsaccount to link plans and transactions.
- Filter for active plans (is_deleted = 0 and is_archived = 0).
- Categorise plan type as 'Savings', 'Investment', or 'Other'.
- Calculate inactivity_days using DATEDIFF and MAX(s.transaction_date).
- Use HAVING clause filters for plans with no recent activity (older than 1 year or never active).
- Order the result by inactivity_days.
### 4. Customer Lifetime Value (CLV) Estimation
The Objective is to estimate Customer Lifetime Value (CLV) based on account tenure and transaction volume. The process I followed is to:
- Create CustomerTransactions CTE: It alculates total transactions, inflow, and signup date per customer.
- Create AccountTenure CTE: It calculates customer tenure in months.
- Create Main query which calculates estimated_clv using the provided formula. Formula incorporates transaction frequency, average transaction value, and a profit margin.
- Filter out customers with no transactions.
- Order results by CLV in descending order.
## Challenge
- I encountered a challenge when trying to extract the insights for Customer Lifetime Value (CLV) Estimation. My first instinct when thinking about "transactions" for CLV was to consider both inflow (deposits) and outflow (withdrawals) as they both represent customer interaction with their accounts and could contribute to the overall value. However, reviewing the provided tables, specifically the absence of a withdrawals_withdrawal table and the expected output indicated a focus on inflow transactions within savings_savingsaccount.
Therefore, I adjusted the query to filter transactions based on s.confirmed_amount > 0, aligning with the question's implied scope and output structure.
