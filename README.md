# oracle


### IN clause to display all values with IN data

`select e.empno, a.id 
from (
select 300 as id from dual
union all
select 500 from dual
union all
select 600 from dual
) a
left join emp e
on e.comm = a.id
where a.id in (300, 500, 600);`
