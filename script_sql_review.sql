-- Criando a tabela
CREATE TABLE loan_data(
    person_age INT NOT NULL,
    person_income INT NOT NULL,
    person_home_ownership VARCHAR(100) NOT NULL,
    person_emp_length FLOAT,
    loan_intent VARCHAR(100) NOT NULL,
    loan_grade VARCHAR(10) NOT NULL,
    loan_amnt INT NOT NULL,
    loan_int_rate FLOAT,
    loan_status INT NOT NULL,
    loan_percent_income FLOAT NOT NULL,
    cb_person_default_on_file VARCHAR(10) NOT NULL,
    cb_person_cred_hist_length INT NOT NULL
);

-- Importando os dados do .csv
COPY loan_data(person_age,person_income,person_home_ownership,person_emp_length,loan_intent,loan_grade,loan_amnt,loan_int_rate,loan_status,loan_percent_income,cb_person_default_on_file,cb_person_cred_hist_length)
FROM 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 16\databases\credit_risk_dataset.csv'
CSV HEADER
DELIMITER ','
ENCODING 'UTF-8';

-- Visualizando a tabela
SELECT *
FROM loan_data;

-- Selecionando uma única coluna e vendo as duas primeiras linhas
SELECT person_age
FROM loan_data
LIMIT 2;

-- Selecionando valores distintos de idade, ordenando e vendo as primeiras 15 linhas
select distinct person_age as unique_age
from loan_data
order by unique_age
limit 15;

-- Criando uma visualização
create view person_data as
select person_age, person_income, person_home_ownership, person_emp_length
from loan_data;

-- Visualizando a view anterior
select *
from person_data;

-- Contando e somando colunas
select count(person_age) as count_ages, sum(person_income) as total_income
from loan_data;

-- Contando todos os registros do dataset
select count(*) as total_records
from loan_data;

-- Selecionando valores únicos
select distinct person_home_ownership
from loan_data;

-- Contando valores únicos
select count(distinct person_age) as count_distinct_ages
from loan_data;

-- Filtrando com operadores
select count(person_home_ownership)
from loan_data 
where person_age <= 25;

select count(person_home_ownership)
from loan_data 
where person_age <> 25;

select *
from loan_data 
where person_home_ownership = 'OWN';

-- Filtrando com operadores e OR, AND, BETWEEN
select *
from loan_data 
where person_home_ownership = 'OWN' or loan_intent = 'EDUCATION';

select *
from loan_data 
where person_home_ownership = 'OWN' AND loan_intent = 'EDUCATION';

select *
from loan_data 
where person_age between 25 and 30;

select *
from loan_data 
where (person_home_ownership = 'OWN' or person_home_ownership = 'MORTGAGE') AND (loan_intent = 'EDUCATION' or loan_intent = 'MEDICAL');

-- Filtrando textos com like e not like
-- % match zero, one, or many characters
-- _ match a single character
select *
from loan_data 
where loan_intent like '%AL';

select *
from loan_data 
where loan_intent not like '%AL';

select *
from loan_data 
where loan_intent like '_E%';

-- Usando WHERE IN
select *
from loan_data 
where person_age = 25
or person_age = 30
or person_age = 35;

select *
from loan_data 
where person_age in (25, 30, 35);

select *
from loan_data 
where person_home_ownership IN ('OWN', 'MORTGAGE');

-- Contando valores nulos e não nulos
select count(*)
from loan_data 
where person_age is null;

select count(*)
from loan_data 
where person_age is not null;

-- Funções agregadores
select avg(person_age)
from loan_data;

select max(person_age)
from loan_data;

select min(person_age)
from loan_data;

select sum(person_income)
from loan_data;

select count(distinct person_income)
from loan_data;

-- Funções agregadores com textos
select max(loan_intent)
from loan_data;

select min(loan_intent) as min_loan_intent
from loan_data;

-- Agregação + WHERE
select avg(person_income)
from loan_data 
where person_age < 35;

select avg(person_income)
from loan_data 
where person_age >= 35;

-- Arredondando valores
select round(avg(person_income), 2) as average_income
from loan_data 
where person_age < 35;

select round(avg(person_income), -2) as average_income
from loan_data 
where person_age < 35;

select (person_age - person_emp_length) as person_not_emp_length
from loan_data;

-- Ordenando colunas
select *
from loan_data 
order by person_age, person_income desc;

-- Agrupando colunas com GROUP BY
select person_home_ownership, round(avg(person_income),2) as avg_person_income
from loan_data 
group by person_home_ownership;

select person_home_ownership, loan_intent, round(avg(person_income),2) as avg_person_income
from loan_data 
group by person_home_ownership, loan_intent;

-- Filtrando com HAVING para registros agrupados
select person_home_ownership, round(avg(person_income),2) as avg_person_income
from loan_data 
group by person_home_ownership
having round(avg(person_income),2) > 50000;