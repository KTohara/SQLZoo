-- Edinburgh Buses
-- 1.
-- How many stops are in the database.

SELECT
  COUNT(*) AS total_stops
FROM
  stops;

-- 2.
-- Find the id value for the stop 'Craiglockhart'

SELECT
  stops.id
FROM
  stops
WHERE
  name = 'Craiglockhart';

-- 3.
-- Give the id and the name for the stops on the '4' 'LRT' service.

SELECT
  stops.id,
  stops.name
FROM
  stops
JOIN
  route ON route.stop = stops.id
WHERE
  route.company = 'LRT'
  AND route.num = 4
ORDER BY
  route.pos;

-- Routes and stops
-- 4.
-- The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53).

-- SELECT
--   company,
--   num,
--   COUNT(*)
-- FROM
--   route
-- WHERE
--   stop=149 OR stop=53
-- GROUP BY
--   company, num

-- Run the query and notice the two services that link these stops have a count of 2.
-- Add a HAVING clause to restrict the output to these two routes.

SELECT
  company,
  num,
  COUNT(*)
FROM
  route
WHERE
  stop=149 OR stop=53
GROUP BY
  company,
  num
HAVING
  COUNT(*) = 2;

-- 5.
-- Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart,
-- without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.

SELECT
  a.company,
  a.num,
  a.stop AS start_stop,
  b.stop AS end_stop
FROM
  route AS a
JOIN
  route AS b ON (
    a.company = b.company
    AND a.num = b.num
  )
WHERE
  a.stop = 53
  AND b.stop = 149

-- 6.
-- The query shown is similar to the previous one, however by joining two copies of the stops 
-- table we can refer to stops by name rather than by number.
-- Change the query so that the services between 'Craiglockhart' and 'London Road' are shown.
-- If you are tired of these places try 'Fairmilehead' against 'Tollcross'

SELECT
  a.company,
  a.num
  stop_a.name,
  stop_b.name
FROM
  route AS a
JOIN
  route AS b ON (
    a.company = b.company
    AND a.num = b.num
  )
JOIN
  stops AS stop_a ON a.stop = stop_a.id
JOIN
  stops AS stop_b ON b.stop = stop_b.id
WHERE
  stop_a.name = 'Fairmilehead'
  AND stop_b.name = 'Tollcross'

-- Using a self join
-- 7.
-- Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')

SELECT DISTINCT
  a.company,
  a.num
FROM
  route AS a
JOIN
  route AS b ON
    a.company = b.company
    AND a.num = b.num
WHERE
  a.stop = 115
  AND b.stop = 137

-- 8.
-- Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'

SELECT
  a.company,
  a.num
FROM
  route a
JOIN
  route b ON
    a.company = b.company
    AND a.num = b.num
JOIN
  stops AS stopa ON a.stop = stopa.id
JOIN
  stops AS stopb ON b.stop = stopb.id
WHERE
  stopa.name = 'Craglockhart'
  AND stopb.name = 'Tollcross'

-- 9.
-- Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus,
-- including 'Craiglockhart' itself, offered by the LRT company.
-- Include the company and bus no. of the relevant services.

SELECT DISTINCT
  stopb.name,
  a.company,
  a.num
FROM
  route a
JOIN
  route b ON
    a.company = b.company
    AND a.num = b.num
JOIN
  stops AS stopa ON a.stop = stopa.id
JOIN
  stops AS stopb ON b.stop = stopb.id
WHERE
  stopa.name ='Craiglockhart'
  AND a.company = 'LRT'
