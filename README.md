# drivers_health_certificate
## Description
Make a graph for each driver of HR and blood pressure readings by examination over a period of time, in order. Also note on the graphs when the driver's limits (health) were changed. In this way we want to check how the certificates (medicine) affect the drivers' health indicators. This report is planned to be provided to client companies on a regular basis, so that they in turn regulate driver health in some way. It is also possible to perform additional analytics on how the change of boundaries affected the drivers' health indicators (visualization, etc.).
## How to run and the results
**1.	Upload driver boundary changes according to the specified script from postgres for the required period of time for the required organization:**

```sql
WITH RankedEvents AS (
    SELECT
        e.personnel_number,
        b.employee_id,
        TO_CHAR(b.set_at, 'YYYY-MM-DD HH24:MI:SS') AS formatted_set_at,
        ROW_NUMBER() OVER (PARTITION BY b.employee_id ORDER BY b.set_at DESC) AS rn
    FROM
        medrec.boundaries b
        INNER JOIN structures.employees e ON e.id = b.employee_id
    WHERE
        e.org_id in (1464, 1465, 1466, 1467, 1468, 1469, 1470, 1471, 1472, 1473, 1474, 1475)
        AND b.set_at BETWEEN '2023-08-01 00:00:00.000' AND '2024-01-31 23:59:59.999'
)
SELECT
    personnel_number as "Табельный номер",
    formatted_set_at as "Время последнего изменения гранни"
FROM
    RankedEvents
WHERE
    rn = 1;
```
As a result, we get the following data in csv format:
![image](https://github.com/CompilerCaster/drivers_health_certificate/assets/128957307/5571a1a9-31a6-4785-8d36-93dd668c78a0)



