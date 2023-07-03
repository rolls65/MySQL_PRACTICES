create database dailytask;

use dailytask;

create table student 
(sid int primary key,	
stnumber varchar(40) unique not null,
fname varchar(40) not null,
address varchar(40),
gender enum('male','female')
)

----Basic SQL commands ----

select * from student;

insert into student values (1,'CS100','Abilash','India','male'),(2,'ME201','Azar','UK','male'),(3,'CS101','Mehrin','UK','female'),(4,'ME202','Ashish','India','male'),(5,'EE300','Mariam','UK','female');

select stnumber as student_id,fname as FullName,address,gender from student;

select stnumber as student_id,upper(fname) as FullName,address,gender from student;

update student set fname='Micheal' where sid=1;

select stnumber as student_id,upper(fname) as FullName,address,gender from student limit 3;

select stnumber as student_id,upper(fname) as FullName,address,gender from student where fname like 'A%';

select stnumber as student_id,upper(fname) as FullName,address,gender from student where address ='UK';

select * from tutorial.us_housing_units where west >50;

select * from tutorial.us_housing_units where south <= 20;

select * from tutorial.us_housing_units WHERE month_name='February';

select * from tutorial.us_housing_units WHERE month_name > 'N';

select year,month,west,south,midwest,northeast,(south + west + midwest) as total from tutorial.us_housing_units; 

select year,month,west,south,midwest,northeast from tutorial.us_housing_units 
where west > (northeast + midwest);

select 
west/(west+south+midwest+northeast) * 100 as westPercentage,
south/(west+south+midwest+northeast) * 100 as southPercentage,
midwest/(west+south+midwest+northeast) * 100 as midwestPercentage,
northeast/(west+south+midwest+northeast) * 100 as northeastPercentage
from tutorial.us_housing_units 
where year >= 2000;

SELECT *
  FROM tutorial.billboard_top_100_year_end where group_name like '%Ludacris%';

SELECT *
  FROM tutorial.billboard_top_100_year_end where upper(artist) like 'DJ%';

SELECT *
  FROM tutorial.billboard_top_100_year_end  where artist in ('M.C. Hammer','Hammer','Elvis Presley');
  
  SELECT *
  FROM tutorial.billboard_top_100_year_end 
    where year between 1985 and 1990;
    
    SELECT *
  FROM tutorial.billboard_top_100_year_end where song_name is NULL;
    
    SELECT *
  FROM tutorial.billboard_top_100_year_end where year_rank <= 10 and group_name like '%Ludacris%';
  
SELECT *
  FROM tutorial.billboard_top_100_year_end where year in (1990, 2000, 2010) and year_rank=1;
  
  SELECT *
  FROM tutorial.billboard_top_100_year_end where year = 1960 and song_name like '%love%';
  
   SELECT *
  FROM tutorial.billboard_top_100_year_end 
   where year_rank <= 10 and (artist='Katy Perry' OR artist='Bon Jovi');

SELECT *
  FROM tutorial.billboard_top_100_year_end 
   where (year between 1970 and 1979 OR year between 1990 and 1999) and song_name like '%California%';
   
 SELECT *
  FROM tutorial.billboard_top_100_year_end 
  where artist = 'Dr. Dre' and (year < 2001 or year > 2009);
  
   SELECT *
  FROM tutorial.billboard_top_100_year_end 
  where song_name not like '%a%' and year=2013 ;
  
  SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year = 2012
 ORDER BY song_name DESC;
 
  SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year = 2010
 ORDER BY year_rank, artist ;
 
 SELECT *
  FROM tutorial.billboard_top_100_year_end
  where group_name like '%T-Pain%' ORDER by year_rank desc;
  
  SELECT *
  FROM tutorial.billboard_top_100_year_end
  where year_rank between 10 and 20 ----rank from 10 to 20
  and year in (1993, 2003,2013) ---select year 
  order by year, year_rank
  
---------------------------------------------------------------------------------

------------- intermediate SQL Query -----------  

  SELECT count(low) as low FROM tutorial.aapl_historical_stock_price 
  
  SELECT 
count(year) as year,
count(month) as month,
count(open) as open,
count(high) as high,
count(low) as low,
count(close) as close,
count(volume) as volume
  FROM tutorial.aapl_historical_stock_price 
  
select sum(open)/count(open) as avg FROM tutorial.aapl_historical_stock_price
  
select min(low) FROM tutorial.aapl_historical_stock_price

select max(close-open) FROM tutorial.aapl_historical_stock_price

select avg(volume) as avg_volume from tutorial.aapl_historical_stock_price where volume is NOT NULL

 select year,month,SUM(volume) as share_total
  FROM tutorial.aapl_historical_stock_price 
  group by year,month 
  order by year,month
  
    select year,AVG(close - open) as daily_avg 
    from tutorial.aapl_historical_stock_price 
    group by year
    
select year,month,MIN(low) as lowest,MAX(high) as highest from tutorial.aapl_historical_stock_price group by month,year

 select year,month,MIN(low) as lowest,MAX(high) as highest 
        from tutorial.aapl_historical_stock_price 
        group by month,year
        having max(high)>400
        ORDER by year,month
        
select player_name,state,CASE WHEN state ='CA' then 'yes' ELSE 'NO' END as from_california
        FROM benn.college_football_players  order by from_california DESC;
        
select player_name,height,
	CASE WHEN height > 80 then 'over 80' 
         WHEN height > 70  and height <= 80 then '70 - 80' 
         WHEN height > 60  and height <= 70 then '60 - 70' 
         WHEN height > 50  and height <= 60 then '50 - 60' 
        ELSE 'below 50' END as height_range
        FROM benn.college_football_players  order by height_range DESC;
        
 select *,CASE WHEN year in ('JR','SR') then player_name 
 ELSE NULL end as jr_sr_players
 from benn.college_football_players
        
select CASE WHEN state in ('CA','OR','WA') then 'West coast'
WHEN state = 'TX' then 'Texas' 
else 'other' END as regions,
count(1) as players
from benn.college_football_players
where weight >= 300
group by 1

SELECT case WHEN year in ('FR','SO') then 'under class'
WHEN year in ('JR','SR')  then 'upper class'
ELSE null end as class,
sum(weight)
from  benn.college_football_players WHERE state='CA' GROUP BY 1

select state, 
COUNT(case when year='FR' then 1 else null END) as fr_count,
COUNT(case when year='SO' then 1 else null END) as so_count,
COUNT(case when year='JR' then 1 else null END) as jr_count,
COUNT(case when year='SR' then 1 else null END) as sr_count,
count(1) as total_players
from benn.college_football_players group by state;

select case when school_name < 'n' then 'A-M'
when school_name  > 'n' then 'N-Z'
else null end as name_group,
count(1)
from benn.college_football_players group by 1 order by name_group

SELECT DISTINCT year
  FROM tutorial.aapl_historical_stock_price
 ORDER BY year
 
SELECT count(DISTINCT month) as count_month, year FROM tutorial.aapl_historical_stock_price group by year

SELECT count(DISTINCT month) as count_month, count(distinct year) as count_year FROM tutorial.aapl_historical_stock_price

select players.school_name,players.player_name,players.position,weight
  from benn.college_football_players players 
  where players.state='GA'
  order by weight desc
  
SELECT *
  FROM benn.college_football_players players
  JOIN benn.college_football_teams teams
    ON teams.school_name = players.school_name
    
SELECT players.player_name,players.school_name,teams.conference
  FROM benn.college_football_players players
  JOIN benn.college_football_teams teams
    ON (teams.school_name = players.school_name) where division ='FBS (Division I-A Teams)'
    
select count(acq.company_permalink) as acquisition_count,count(comp.permalink) as comp_count 
from tutorial.crunchbase_acquisitions acq inner join 
tutorial.crunchbase_companies comp on (acq.company_permalink=comp.permalink)

select count(acq.company_permalink) as acquisition_count,count(comp.permalink) as comp_count 
from tutorial.crunchbase_acquisitions acq left join 
tutorial.crunchbase_companies comp on (acq.company_permalink=comp.permalink)

select comp.state_code,
count(distinct acq.company_permalink) as acquired_count,count(distinct comp.permalink) as permcomp_count  
from tutorial.crunchbase_acquisitions acq 
right join tutorial.crunchbase_companies comp on (acq.company_permalink=comp.permalink)
where comp.state_code is not null group by 1 order by 1 desc

select comp.name as company_name,comp.status as status,count(distinct investment.investor_name) as unique_investment_name
from tutorial.crunchbase_companies comp 
left join tutorial.crunchbase_investments investment 
on (investment.company_permalink = comp.permalink)
WHERE comp.state_code = 'NY'
group by comp.name,comp.status
order by 3 desc;

select case when investment.investor_name is null then 'No Investor'
else investment.investor_name end as investor_details,
count(distinct comp.permalink) as company_invested_in
from tutorial.crunchbase_companies comp 
left join tutorial.crunchbase_investments investment 
on (investment.company_permalink = comp.permalink)
group by 1
order by 2 desc

select 
count(case when comp.permalink is not null and inv.company_permalink is null then comp.permalink
else null end) as company_only,
count(case when comp.permalink is  null and inv.company_permalink is not null then inv.company_permalink
else null end) as investment_only,
count(case when comp.permalink is  not null and inv.company_permalink is not null then comp.permalink
else null end) as both_count
from tutorial.crunchbase_companies comp
full join tutorial.crunchbase_investments_part1 inv
on comp.permalink = inv.company_permalink

 select company_permalink,company_name,investor_name 
 from tutorial.crunchbase_investments_part1 
 where upper(company_name) ilike 'T%'
 union all
 select company_permalink,company_name,investor_name 
 from tutorial.crunchbase_investments_part2 
 where upper(company_name) ilike 'M%'
 
 select 'data set 1' as data_set_no,comp.status,count(distinct part1.investor_name)
from tutorial.crunchbase_companies comp
left join tutorial.crunchbase_investments_part1 part1
on (part1.company_permalink = comp.permalink)
group by 1,2
union all
select 'data set 2' as data_set_no,comp.status,count(distinct part2.investor_name)
from tutorial.crunchbase_companies comp
left join tutorial.crunchbase_investments_part2 part2
on (part2.company_permalink = comp.permalink)
group by 1,2

SELECT companies.permalink,
       companies.name,
       investments.company_name,
       investments.company_permalink
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments_part1 investments
    ON companies.permalink = investments.company_permalink
   AND companies.name = investments.company_name
   
select CAST(funding_total_usd as varchar) as funding_total,
CAST(founded_at_clean as varchar) as founded_cat_clean 
from tutorial.crunchbase_companies_clean_date

select company.category_code,
count(case when acquisitions.acquired_at_cleaned <= company.founded_at::timestamp + INTERVAL '3 years'
then 1 ELSE null END) as acquired_3_year,
count(case when acquisitions.acquired_at_cleaned <= company.founded_at::timestamp + INTERVAL '5 years'
then 1 ELSE null END) as acquired_5_year,
count(case when acquisitions.acquired_at_cleaned <= company.founded_at::timestamp + INTERVAL '10 years'
then 1 ELSE null END) as acquired_10_year,
count(1) as total
FROM tutorial.crunchbase_companies_clean_date company
  JOIN tutorial.crunchbase_acquisitions_clean_date acquisitions
  ON (acquisitions.company_permalink = company.permalink)
  where founded_at_clean IS NOT NULL
  group by 1 order by 5 desc

SELECT incidnt_num,date,SUBSTR(date, 4, 2) AS day
  FROM tutorial.sf_crime_incidents_2014_01
  
