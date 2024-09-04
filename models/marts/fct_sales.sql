{{ config(materialized='table') }}

WITH fct_sales AS (
    SELECT
        COALESCE(MIN("Product Name"), 'N/A') AS Product_Name,
        ARRAY_AGG(COALESCE("Sales Agent Name", 'N/A')) AS Agent_names,
        COALESCE(MIN("Country"), 'N/A') AS Country,
        ARRAY_AGG(COALESCE("Campaign Name", 'N/A')) AS Campaign_names,
        ARRAY_AGG(COALESCE("Source", 'N/A')) AS Sources,
        COALESCE(MIN("Total Amount ($)"), 0) + COALESCE(MIN("Total Rebill Amount"), 0) - COALESCE(MIN("Returned Amount ($)"), 0) AS Total_revenue,
        MIN("Total Rebill Amount") AS Rebill_revenue,
        MIN("Number Of Rebills") AS Number_Of_Rebills,
        MIN("Discount Amount ($)") AS Discount_amount,
        MIN("Returned Amount ($)") AS Returned_Amount,
        MIN("Return Date Kyiv"::timestamp) AS Return_Date_Kyiv,
        MIN("Return Date Kyiv"::timestamp) AT TIME ZONE 'EET' AT TIME ZONE 'UTC' AS Return_Date_UTC,
        MIN("Return Date Kyiv"::timestamp) AT TIME ZONE 'EET' AT TIME ZONE 'EDT' AS Return_Date_EDT,
        DATE_PART('day', MIN("Return Date Kyiv") - MIN("Order Date Kyiv")) AS Days_From_Order_To_Return,
        MIN("Order Date Kyiv"::timestamp) AS Order_Date_Kyiv,
        MIN("Order Date Kyiv"::timestamp) AT TIME ZONE 'EET' AT TIME ZONE 'UTC' AS Order_Date_UTC,
        MIN("Order Date Kyiv"::timestamp) AT TIME ZONE 'EET' AT TIME ZONE 'EDT' AS Order_Date_EDT
    FROM
        {{ref('stg_sales')}}
    GROUP BY
        "Reference ID"
    )

SELECT *
FROM fct_sales