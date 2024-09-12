 --1.what are the mode of rides available on rapido
select distinct r.services 
from rides r 
order by 1

--2.how many completed and cancelled numeric & %
select r.ride_status, count(r.ride_status) as nos from rides r
group by r.ride_status 

--3.most common source and distination
select r."source" , count(r."source") from rides r
group by r."source" 
order by 2 desc
limit 5

select r.destination , count(r.destination) from rides r
group by r.destination 
order by 2 desc
limit 5

--4.average ride charge per km
select avg(r.ride_charge)/avg(r.distance) as avgChargePerKM 
from rides r 

--5.average misc charge per km
select avg(r.misc_charge)/avg(r.distance) as avgMiscChargePerKM 
from rides r 

--6.mode of payment
select distinct r.payment_method 
from rides r
order by 1

--7.total amount and service
select r.services, sum(r.total_fare) 
from rides r
group by r.services
order by 1

--8.average cancelled km
select avg(r.distance), max(r.distance), min(r.distance)
from rides r 
where r.ride_status = 'cancelled'

--9.what services cancelled most,least
select r.services, count(r.services) 
from rides r 
where r.ride_status = 'cancelled'
group by r.services 
order by 2 desc

--10.peak top 5 distination with avg cost
select r.destination ,round(avg(r.total_fare)/avg(r.distance),2) as avgCostPerKM from rides r
group by r.destination 
order by count(r.destination) desc
limit 5

--11.peak top 5 source with avg cost
select r."source" ,round(avg(r.total_fare)/avg(r.distance),2) as avgCostPerKM from rides r
group by r."source" 
order by count(r."source") desc
limit 5

--12.total amount and payment mode
select r.payment_method , sum(r.total_fare) 
from rides r
group by r.payment_method 
order by 1

--13.total amount by month
select date_part('month',r."date") , sum(r.total_fare) 
from rides r
group by date_part('month',r."date")
order by 1

--14.total amount by hour
select date_part('hour',r."time") , round(sum(r.total_fare),0) 
from rides r
group by date_part('hour',r."time")
order by 2 desc

--15.services vs status counts
select r.services, r.ride_status,
count(r.services),
sum(case when ride_status = 'cancelled' then 0 else r.total_fare end) as totalFare, 
sum(case when ride_status = 'cancelled' then 0 else distance end) as totalTravelledDistance
from rides r 
group by r.services, r.ride_status 
order by 1 asc
