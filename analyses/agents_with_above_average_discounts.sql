SELECT
    agent_names[array_length(agent_names, 1)] AS agent_name,
    AVG(discount_amount) AS average_discount
FROM fct_sales
GROUP BY agent_names[array_length(agent_names, 1)]
HAVING AVG(discount_amount) > (SELECT AVG(discount_amount) FROM fct_sales)