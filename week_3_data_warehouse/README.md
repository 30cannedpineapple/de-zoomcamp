# Module 3 Homework

Below are the SQL queries used to create tables and run SQL queries in Homework 3

```SQL
CREATE OR REPLACE EXTERNAL TABLE `de-zoom-camp-449005.nytaxi.yellow_tripdata2024`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://nytaxidatawarehouseweek3/yellow_tripdata_2024-*.parquet']
);

select COUNT(*) from `de-zoom-camp-449005.nytaxi.yellow_tripdata2024`

CREATE OR REPLACE TABLE `de-zoom-camp-449005.nytaxi.nonpartitioned_yellow_tripdata2024`
AS SELECT * FROM `de-zoom-camp-449005.nytaxi.yellow_tripdata2024`;

select count(*) from `de-zoom-camp-449005.nytaxi.nonpartitioned_yellow_tripdata2024`


select count(distinct PULocationID) from `de-zoom-camp-449005.nytaxi.nonpartitioned_yellow_tripdata2024`


select count(distinct PULocationID) from `de-zoom-camp-449005.nytaxi.yellow_tripdata2024`

select PULocationID from `de-zoom-camp-449005.nytaxi.nonpartitioned_yellow_tripdata2024`

select PULocationID, DOLocationID from `de-zoom-camp-449005.nytaxi.nonpartitioned_yellow_tripdata2024`

select count(*)
from `de-zoom-camp-449005.nytaxi.nonpartitioned_yellow_tripdata2024`
where fare_amount = 0


CREATE OR REPLACE TABLE `de-zoom-camp-449005.nytaxi.partitioned_yellow_tripdata2024`
PARTITION BY DATE(tpep_dropoff_datetime) 
CLUSTER BY VendorID AS
SELECT * FROM  `de-zoom-camp-449005.nytaxi.yellow_tripdata2024`

select distinct VendorID from `de-zoom-camp-449005.nytaxi.nonpartitioned_yellow_tripdata2024`
where tpep_dropoff_datetime between '2024-03-01' and '2024-03-15'

select distinct VendorID from `de-zoom-camp-449005.nytaxi.partitioned_yellow_tripdata2024`
where tpep_dropoff_datetime between '2024-03-01' and '2024-03-15'

select COUNT(*) from `de-zoom-camp-449005.nytaxi.nonpartitioned_yellow_tripdata2024`

select COUNT(*) from `de-zoom-camp-449005.nytaxi.partitioned_yellow_tripdata2024`
```