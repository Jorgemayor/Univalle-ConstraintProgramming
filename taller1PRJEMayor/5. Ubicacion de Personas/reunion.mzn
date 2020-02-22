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

int: constraintsNext = length(next) div 2;
int: constraintsSeparate = length(separate) div 2;
int: constraintsDistance = length(distance) div 3;

predicate distance(var int: a, var int: b, var int: distance) = abs(a - b) == distance;


%CONSTRAINTS

%Makes positoins unique
constraint alldifferent([positions[i] | i in rangePositions]);

%Pair people that must be together.
constraint forall(i in 1..constraintsNext)
              (distance(positions[next[i,1]], positions[next[i,2]], 1));

constraint forall(i in 1..constraintsSeparate)
              (not distance(positions[separate[i,1]],positions[separate[i,2]], 1));

constraint forall(i in 1..constraintsDistance)
              (distance(positions[distance[i,1]], positions[distance[i,2]], distance[i,3]));

solve satisfy;
output ["Order:"]++[" "++people[fix(positions[i])]| i in rangePositions];