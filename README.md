# DataAnalytics-Assessment
## Per-Question Explanations
### 1-  High-Value Customers with Multiple Products
The objective is to dentify customers with both funded savings and investment plans, ordered by total deposits.
The process I foolowed is to:
- Joins users_customuser, plans_plan, and savings_savingsaccount to link customers, plans, and transactions.
- Filters for plans with confirmed_amount > 0 (funded).
- Use conditional COUNT to count funded savings and investment plans separately.
- HAVING clause to ensure customers have at least one of funded savings and investment plan type.
- Then Order by total_deposits to find high-value customers.
### 2- Transaction Frequency Analysis

### 3- Account Inactivity Alert

### 4- Customer Lifetime Value (CLV) Estimation

## Challenges


