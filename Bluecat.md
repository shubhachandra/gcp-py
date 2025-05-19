SELECT t1.*
FROM `project.dataset.table1` AS t1
LEFT JOIN (
  SELECT DISTINCT subutil.subneturi AS subnet_uri
  FROM `project.dataset.table2` AS t2,
       UNNEST(t2.payload_v1_report.iputilizationinfo) AS iputil,
       UNNEST(iputil.subnetiputilization) AS subutil
) AS t2_flat
ON t1.subnet_uri = t2_flat.subnet_uri
WHERE t2_flat.subnet_uri IS NULL;

