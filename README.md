# Nursery (Back End)
Nursery is a nursing journaling app that primarily keeps track of breastfeeding sessions and secondarily tracks food the mother has eaten to monitor for adverse reactions in the nursing infant.

## Getting Started

### Feedings
#### Model
The feedings model consists of four data columns: 
* id - key for database records
* start_time - when nursing began
* end_time - when nursing ended
* side - L or R for which side the infant was fed from)

#### Routes
The Nursery API features full CRUD on the feedings model

Function | Action | URL
--- | --- | ---
Create | POST | /feedings
Read | GET | /feedings
Update | PUT | /feedings/:id
Delete | DELETE | /feedings/:id

In addition, the Nursery API features the following routes.

Function | Action | URL | Details
--- | --- | --- | ---
Read recent | GET | /feedings/last_hours/:num | Fetches all records with an end time in the past :num hours
Read over an interval | GET | /feedings/:start/:finish | Fetches all records with an end time after :start and a start time before :finish. :start and :finish are formatted in YYYYMMDDHHmmss.
Read by side | PUT | /feedings/side/:side | Fetches all records nursed from that :side.

Note: all GET routes return results sorted by start time in descending order (most recent first).

#### Feedings-Foods Relationship
Feedings and foods are related in a many-to-many relationship. A feeding's associated foods are those that were eaten 1-6 hours (the approximate time it takes for food to be metabolized into breast milk) before the feeding. It is possible for several foods to be associated with a feeding. Likewise, it is possible for one food to be associated with multiple feedings.

The many-to-many relationship is achieved by joining the two tables on the feedings' start_time and foods' time columns. Instead of joining on equality, the join is on the food's time column being greater than the feeding's start_time minus an interval of six hours and less than the feeding's start_time minus an interval of one hour.

### Foods
#### Model
The foods model consists of three data columns: 
* id - key for database records
* time - when the food waas eaten
* food - name or description of the food eaten

#### Routes
The Nursery API features full CRUD on the foods model as well

Function | Action | URL
--- | --- | ---
Create | POST | /foods
Read | GET | /foods
Update | PUT | /foods/:id
Delete | DELETE | /foods/:id

Note: the GET route returns results sorted by time in descending order (most recent first).

## Technologies Used

  1. Used [React](https://reactjs.org/) for the front end.
  2. Used [PostgreSQL](https://www.postgresql.org) to store data for feedings and foods.
  3. Used [Ruby](https://www.ruby-lang.org/en/) on [Rails](https://rubyonrails.org/) for the back end API.
  4. Used [Font Awesome](https://fontawesome.com/) for icons.
