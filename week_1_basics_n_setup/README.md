# Module 1 Homework: Docker & SQL
Question 1. Understanding docker first run
Run docker with the python:3.12.8 image in an interactive mode, use the entrypoint bash.
What's the version of pip in the image?

`pip --version`

pip 24.3.1 from /usr/local/lib/python3.12/site-packages/pip (python 3.12)


Question 2. Understanding Docker networking and docker-compose
Given the following docker-compose.yaml, what is the hostname and port that pgadmin should use to connect to the postgres database?
db:5432

Question 3. Trip Segmentation Count
During the period of October 1st 2019 (inclusive) and November 1st 2019 (exclusive), how many trips, respectively, happened:
Up to 1 mile
In between 1 (exclusive) and 3 miles (inclusive),
In between 3 (exclusive) and 7 miles (inclusive),
In between 7 (exclusive) and 10 miles (inclusive),
Over 10 miles
Answers:
104,802; 198,924; 109,603; 27,678; 35,189

```sql
select 
case when trip_distance <= 1 THEN 'up to 1 mile'
when trip_distance<=3 THEN '1-3 miles'
when trip_distance <= 7 THEN '3-7 miles'
when trip_distance <= 10 THEN '7-10 miles'
else 'over 10 miles' END as trip_bucket,
count(*)
from green_taxi_data
where 1=1
and CAST(lpep_pickup_datetime as date) >= CAST('2019-10-01' as date)
and CAST(lpep_pickup_datetime as date) < CAST('2019-11-01' as date)
and CAST(lpep_dropoff_datetime as date) >= CAST('2019-10-01' as date)
and CAST(lpep_dropoff_datetime as date) < CAST('2019-11-01' as date)
group by 1
```

Question 4. Longest trip for each day
Which was the pick up day with the longest trip distance? Use the pick up time for your calculations.
Tip: For every day, we only care about one single trip with the longest distance.
2019-10-31



```sql
select 
CAST(lpep_pickup_datetime as date), trip_distance
from green_taxi_data
order by trip_distance desc
limit 1
```

Question 5. Three biggest pickup zones
Which were the top pickup locations with over 13,000 in total_amount (across all trips) for 2019-10-18?
Consider only lpep_pickup_datetime when filtering by date.
East Harlem North, East Harlem South, Morningside Heights

```sql
select 
zones."Zone", sum(total_amount) as total_sum
from green_taxi_data
join zones
on green_taxi_data."PULocationID" = zones."LocationID"
where CAST(lpep_pickup_datetime as date) = CAST('2019-10-18' as date)
group by 1
having sum(total_amount) > 13000
order by total_sum desc
```

Question 6. Largest tip
For the passengers picked up in October 2019 in the zone named "East Harlem North" which was the drop off zone that had the largest tip?
Note: it's tip , not trip
We need the name of the zone, not the ID.
JFK Airport

```sql
select 
doz."Zone", tip_amount
from green_taxi_data t
join zones puz
on t."PULocationID" = puz."LocationID"
join zones doz
on t."DOLocationID" = doz."LocationID"
where 1=1
and CAST(lpep_pickup_datetime as date) >= CAST('2019-10-01' as date)
and CAST(lpep_pickup_datetime as date) < CAST('2019-11-01' as date)
and puz."Zone" = 'East Harlem North'
order by tip_amount desc
```

Terraform
In this section homework we'll prepare the environment by creating resources in GCP with Terraform.
In your VM on GCP/Laptop/GitHub Codespace install Terraform. Copy the files from the course repo here to your VM/Laptop/GitHub Codespace.
Modify the files as necessary to create a GCP Bucket and Big Query Dataset.
Question 7. Terraform Workflow
Which of the following sequences, respectively, describes the workflow for:
Downloading the provider plugins and setting up backend,
Generating proposed changes and auto-executing the plan
Remove all resources managed by terraform`
Answers:
terraform init, terraform apply -auto-approve, terraform destroy

