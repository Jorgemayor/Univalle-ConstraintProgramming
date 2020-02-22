include "globals.mzn";
include "reunion.dzn";


%VARIABLES

%Names of the people in the meeting
array[int] of string: people;

%Number of people in the meeting
int: numberOfPeople = length(people);

%Possible positions
set of int: rangePositions = 1..numberOfPeople;

%Array of positions
array[rangePositions] of var rangePositions: positions;

array[int, 1..2] of rangePositions: next;
array[int, 1..2] of rangePositions: separate;
array[int, 1..3] of rangePositions: distance;

predicate distance(var int: a, var int: b, var int: distance) = abs(a - b) == distance;


%CONSTRAINTS

constraint alldifferent([positions[i] | i in 1..length(positions)]);


constraint forall(i in 1..1)
              (distance(positions[next[i,1]], positions[next[i,2]], 1));

constraint forall(i in 1..1)
              (not distance(positions[separate[i,1]],positions[separate[i,2]], 1));

constraint forall(i in 1..1)
              (distance(positions[distance[i,1]], positions[distance[i,2]], distance[i,3]));

solve satisfy;