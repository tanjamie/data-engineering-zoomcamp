-- Question 3
-- How many taxi trips were there on January 15? Consider only trips that started on January 15.
SELECT COUNT(tpep_pickup_datetime) 
FROM yellow_taxi_data 
WHERE CAST(tpep_pickup_datetime AS DATE) = '2021-01-15';
-- Notes
-- Use single quote to indicate string type for date 2021-01-15, ouble quote wont do
-- Double quote is used to specify column name



-- Questions 4
-- Find the largest tip for each day. On which day it was the largest tip in January?
-- Use the pick up time for your calculations. 
-- (note: it's not a typo, it's "tip", not "trip")
SELECT CAST(tpep_pickup_datetime AS DATE) AS pick_up_day, MAX(tip_amount) AS max_tip
FROM yellow_taxi_data
GROUP BY pick_up_day
ORDER BY max_tip DESC
LIMIT 1;
-- Notes
-- You can use the column names you've assigned from SELECT clause



-- Question 5
-- What was the most popular destination for passengers picked up in central park on January 14?
-- Use the pick up time for your calculations.
-- Enter the zone name (not id). If the zone name is unknown (missing), write "Unknown".
SELECT COALESCE(dropoff."Zone", 'Unknown') AS dropoff_location, 
    COUNT(dropoff."LocationID") AS num_of_dropoff
FROM yellow_taxi_data ytd LEFT JOIN zones pickup
	ON ytd."PULocationID" = pickup."LocationID"
	LEFT JOIN zones dropoff
	ON ytd."DOLocationID" = dropoff."LocationID"
WHERE pickup."Zone" = 'Central Park' 
    AND CAST(ytd."tpep_pickup_datetime" AS DATE) = '2021-01-14'
GROUP BY dropoff_location
ORDER BY num_of_dropoff DESC
LIMIT 1;
-- Notes
-- Since we only need one output, COALESCE is sufficient to check whether it is NULL or not



-- Question 6
-- What's the pickup-dropoff pair with the largest average price for a ride (calculated based on total_amount)?
-- Enter two zone names separated by a slash. For example: "Jamaica Bay / Clinton East".
-- If any of the zone names are unknown (missing), write "Unknown". For example, "Unknown / Clinton East".
SELECT CONCAT(COALESCE(pickup."Zone", 'Unknown'), ' / ', COALESCE(dropoff."Zone", 'Unknown')), 
	AVG(ytd."total_amount") AS average_price
FROM yellow_taxi_data ytd LEFT JOIN zones pickup
	ON ytd."PULocationID" = pickup."LocationID"
	LEFT JOIN zones dropoff
	ON ytd."DOLocationID" = dropoff."LocationID"
GROUP BY pickup."Zone", dropoff."Zone"
ORDER BY average_price DESC;
-- Notes
-- CONCAT to concatenate outputs

-- fin
