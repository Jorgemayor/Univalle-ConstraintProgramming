% Reunion (Point 5)


% LIBRARIES

include "globals.mzn";
include "reunion.dzn";


% VARIABLES

%Array of positions
array[rangePositions] of var rangePositions: positions;


% PARAMETERS

%Names of the people in the meeting
array[int] of string: people;

%Number of people in the meeting
int: numberOfPeople = length(people);

%Possible positions
set of int: rangePositions = 1..numberOfPeople;

%Array that specifies the people that must be together.
array[int, 1..2] of rangePositions: next;

%Array that specifies the people that must be separated.
array[int, 1..2] of rangePositions: separate;

%Array that specifies the distance between a pair of people.
array[int, 1..3] of rangePositions: distance;

%Number of constraints in array 'next'.
int: constraintsNext = length(next) div 2;

%Number of constraints in array 'separate'.
int: constraintsSeparate = length(separate) div 2;

%Number of constraints in array 'distance'.
int: constraintsDistance = length(distance) div 3;


%Predicate that determines if a pair of positions (numbers) have the given distance between them.
predicate distance(var int: a, var int: b, var int: distance) = abs(a - b) == distance;


%CONSTRAINTS

%Makes positoins unique
constraint alldifferent([positions[i] | i in rangePositions]);

%Pairs people that must be together.
constraint forall(i in 1..constraintsNext)
              (distance(positions[next[i,1]], positions[next[i,2]], 1));

%Separates people that must not be together.
constraint forall(i in 1..constraintsSeparate)
              (not distance(positions[separate[i,1]],positions[separate[i,2]], 1));

%Sets an obligatory distance between a pair of people.
constraint forall(i in 1..constraintsDistance)
              (distance(positions[distance[i,1]], positions[distance[i,2]], distance[i,3]));

%Solve until satisfy
solve satisfy;

output [show(positions)];