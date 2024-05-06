select distinct
e.surname as Фамилия,
e.name as Имя,
e.patronymic as Отчетство,
e.gender as Пол,
e.personnel_number as Табельный номер,
e.id as id сотрудника,
ad_sys as АД систолическое,
ad_dis as АД диастолическое,
pulse as ЧСС,
a.started_at as Дата и время осмотра,
a.id as id осмотра
from processing.inspections_pool_resolved a
inner join structures.organizations o
on a.org_id = o.id
inner join structures.employees e
on e.id = a.employee_id
inner join (SELECT
json_data-'result'-'value'-'pulse' AS pulse,
json_data-'result'-'value'-'pressure'-'systolic' AS ad_sys,
json_data-'result'-'value'-'pressure'-'diastolic' AS ad_dis,
ipr.id as id
FROM
processing.inspections_pool_resolved ipr ,
jsonb_array_elements(ipr.steps) AS json_data
WHERE
json_data-'type' = 'tonometry') t
on t.id = a.id
where a.type = 'AFTER_TRIP' and o.id in (1464, 1465, 1466, 1467, 1468, 1469, 1470, 1471, 1472, 1473, 1474, 1475)
and a.started_at between '2023-08-01 000000.000 +0300' and '2024-01-31 235959.999 +0300'
order by a.started_at desc;

$$ language plpgsql;
