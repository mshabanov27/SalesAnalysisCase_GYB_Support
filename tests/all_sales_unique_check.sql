SELECT product_name, agent_names, order_date_kyiv
FROM fct_sales
GROUP BY product_name, agent_names, order_date_kyiv
HAVING(COUNT(product_name) > 1)