
--Create retirement_titles table from employees & titles csv's
Select e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
Into retirement_titles
from employees as e
inner join titles as t
On e.emp_no = t.emp_no
where (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
order by e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, t.title
into unique_titles
from employees as e
left join titles as t
on (e.emp_no = t.emp_no)
where e.birth_date between '1952-01-01' and '1955-12-31'
ORDER BY e.emp_no, to_date DESC;

--Create retiring titles table
Select Count(title),title
into retiring_titles
from unique_titles
group by title
order by count(title) desc;

--Create mentorship eligibilty table
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
Into mentorship_eligibilty
from employees as e
left join titles as t
On (e.emp_no = t.emp_no)
left join dept_employees as de
On (e.emp_no = de.emp_no)
where (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
order by e.emp_no;