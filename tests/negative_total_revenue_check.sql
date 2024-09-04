SELECT Product_Name
FROM {{ ref('fct_sales') }}
WHERE Total_revenue < 0