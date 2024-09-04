SELECT agent_names, campaign_names, sources
FROM fct_sales
WHERE array_length(agent_names, 1) <> array_length(campaign_names, 1) AND
      array_length(campaign_names, 1) <> array_length(sources, 1)