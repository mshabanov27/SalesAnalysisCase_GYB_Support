WITH revenue_sums_by_month AS (
    SELECT DATE_TRUNC('month', order_date_kyiv) AS month,
    SUM(total_revenue) AS total_revenue_sum
    FROM fct_sales
    GROUP BY DATE_TRUNC('month', order_date_kyiv)
    ORDER BY DATE_TRUNC('month', order_date_kyiv)
    )
SELECT
    month,
    COALESCE(
       total_revenue_sum/LAG(total_revenue_sum) OVER(ORDER BY month) * 100.0 - 100.0,
       100.0
    ) AS percent_change
FROM revenue_sums_by_month