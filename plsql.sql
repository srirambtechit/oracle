-- working table space

create table myuser (id integer, name varchar(20));

insert into myuser values (1, 'sriram');

select * from myuser;

select * from emp;


-- sample addition program in pl/sql
declare
	a integer;
	b integer;
	c integer;
begin
	a := 3;
	b := 2;
	c := a + b;
	dbms_output.put_line('Hello world');
	dbms_output.put_line('Sum is ' || c );
end



-- creating procedure in oracle pl/sql
create or replace procedure add_user(id in number, name in varchar2) is
	begin
             insert into myuser values(id, name);
	     dbms_output.put_line('User inserted');
end add_user;


-- removing procedure from DB
drop procedure add_user;


-- invoking procedure from pl/sql
begin
	add_user(1, 'prabhu');
	add_user(2, 'surya');
end;


-- explicit cursor example
-- 1. Declare the cursor to initialize in the memory.
-- 2. Open the cursor to allocate memory.
-- 3. Fetch the cursor to retrieve data.
-- 4. Close the cursor to release allocated memory.

declare
	e_id emp.empno%type;
	e_name emp.ename%type;
	e_sal emp.sal%type;
	cursor emp_cursor is select empno, ename, sal from emp;
begin
	open emp_cursor;

	loop

	fetch emp_cursor into e_id, e_name, e_sal;

	exit when emp_cursor%notfound;

	dbms_output.put_line(e_id || ' ' || e_name || ' ' || e_sal);

	end loop;

	close emp_cursor;
end


-- implicit cursor
declare
	total_row number(2);
begin
	update emp
	set sal = sal + 1000;
	if sql%notfound then
		dbms_output.put_line('No rows to update');
	elsif sql%found then
		total_row := sql%rowcount;
		dbms_output.put_line(total_row || ' rows updated');
	end if;
end



-- Exception handling
-- 1. System-defined Exceptions
-- 2. User-defined Exceptions
declare
	e_id emp.empno%type := 1000;
	e_ename emp.ename%type;
	e_sal emp.sal%type;
begin
	select ename, sal into e_ename, e_sal from emp where empno = e_id;

	dbms_output.put_line('Name ' || e_ename);
	dbms_output.put_line('Salary ' || e_sal);
	
exception
	when no_data_found then
		dbms_output.put_line('No such employee');
	when others then
		dbms_output.put_line('Unknown error');
end



-- 2. User-defined Exceptions
-- 	  Raising exception explicitly
declare
	ename_not_match EXCEPTION;
	e_ename emp.ename%type;
begin
	select ename into e_ename from emp where empno = 7698;
	dbms_output.put_line('employee name is ' || e_ename);

	if e_ename <> 'KING' then
		raise ename_not_match;
	end if;

	dbms_output.put_line('Matched employee name is ' || e_ename);
	
exception
	when ename_not_match then
		dbms_output.put_line('Employee name is not matched');
	when others then
		dbms_output.put_line('error');
end




