SELECT
    RANK() OVER(ORDER BY SUM(total_revenue) DESC) AS rank,
    agent_names[array_length(agent_names, 1)] AS agent_name,
    AVG(total_revenue) AS average_revenue,
    COUNT(product_name) AS sales_count,
    AVG(discount_amount) AS average_discount
FROM fct_sales
GROUP BY agent_names[array_length(agent_names, 1)]
ORDER BY rank