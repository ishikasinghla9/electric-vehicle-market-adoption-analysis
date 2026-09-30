use df

select * from df.ev_vehicle

-- some business problems
-- q1 Which manufacturers have the highest EV registrations, and what is their average electric range?
SELECT make AS manufacturer,COUNT(*) AS total_registrations,
ROUND(AVG(`electric range`),2) AS avg_electric_range
FROM ev_vehicle
GROUP BY make
ORDER BY total_registrations DESC;

-- q2 Which manufacturers provide the best balance between market popularity and electric range?
SELECT make AS manufacturer,
COUNT(*) AS total_registrations,
ROUND(AVG(`electric range`),2) AS avg_electric_range,
RANK() OVER(ORDER BY COUNT(*) DESC,
AVG(`electric range`) DESC) AS overall_rank
FROM ev_vehicle
GROUP BY make;

-- q3 Which states, counties, and cities have the highest electric vehicle adoption?
SELECT state, COUNT(*) AS total_ev
FROM ev_vehicle
GROUP BY state
ORDER BY total_ev DESC;

SELECT county, COUNT(*) AS total_ev
FROM ev_vehicle
GROUP BY county
ORDER BY total_ev DESC;

SELECT city,COUNT(*) AS total_ev
FROM ev_vehicle
GROUP BY city
ORDER BY total_ev DESC;

-- q4  Which regions have the greatest diversity of EV manufacturers and models?
SELECT state, COUNT(DISTINCT make) AS manufacturers,
COUNT(DISTINCT model) AS models
FROM ev_vehicle
GROUP BY state
ORDER BY manufacturers DESC,
models DESC;
         
-- q5 How has EV adoption changed across different model years?
SELECT `model year`,
    COUNT(*) AS registrations
FROM ev_vehicle
GROUP BY `model year`
ORDER BY `model year`;

-- q6 What is the distribution of BEVs and PHEVs across different regions?
SELECT state, `electric vehicle type`, COUNT(*) AS total_vehicles
FROM ev_vehicle
GROUP BY state, `electric vehicle type`
ORDER BY state;

-- q7 How are CAFV-eligible vehicles distributed across manufacturers and vehicle types?
SELECT make, `electric vehicle type`,`Clean Alternative Fuel Vehicle (CAFV) Eligibility`, COUNT(*) AS total_vehicles
FROM ev_vehicle
GROUP BY make, `electric vehicle type`, `Clean Alternative Fuel Vehicle (CAFV) Eligibility`
ORDER BY make;

-- q8 Do CAFV-eligible vehicles offer higher electric ranges than non-eligible vehicles?
SELECT `Clean Alternative Fuel Vehicle (CAFV) Eligibility`, COUNT(*) AS total_vehicles, 
ROUND(AVG(`electric range`),2) AS avg_range,
MAX(`electric range`) AS max_range,
MIN(`electric range`) AS min_range
FROM ev_vehicle
GROUP BY `Clean Alternative Fuel Vehicle (CAFV) Eligibility`

-- q9 Based on registrations, electric range, and CAFV eligibility, which manufacturers are the strongest overall performers?
SELECT make, COUNT(*) AS registrations, ROUND(AVG(`electric range`),2) AS avg_range,
SUM(CASE WHEN `Clean Alternative Fuel Vehicle (CAFV) Eligibility` LIKE '%Eligible%' THEN 1 ELSE 0
END) AS `Clean Alternative Fuel Vehicle (CAFV) Eligibility`,
RANK() OVER(ORDER BY COUNT(*) DESC, AVG(`electric range`) DESC,
SUM(CASE WHEN `Clean Alternative Fuel Vehicle (CAFV) Eligibility` LIKE '%Eligible%' THEN 1 ELSE 0 END) DESC) AS overall_rank
FROM ev_vehicle
GROUP BY make;
-- TESLA 


