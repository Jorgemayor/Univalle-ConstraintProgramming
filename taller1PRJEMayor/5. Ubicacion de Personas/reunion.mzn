include "globals.mzn";
include "reunion.dzn";

%VARIABLES

array[int] of string: people;
array[index_set(people)] of var index_set(people): positions;
array[index_set(people)] of var string: order;
array[int, 1..2] of index_set(people): next;
array[int, 1..2] of index_set(people): separate;
array[int, 1..3] of index_set(people): distance;

%CONSTRAINTS

constraint alldifferent([positions[i] | i in 1..length(positions)]);

constraint forall(i in 1..1)
              (abs(positions[next[i,1]]-positions[next[i,2]])==1);

constraint forall(i in 1..1)
              (abs(positions[separate[i,1]]-positions[separate[i,2]])>1);
              
constraint forall(i in 1..1)
              (abs(positions[distance[i,1]]-positions[distance[i,2]])==distance[i,3]);

constraint forall(i in index_set(positions)) (order[positions[i]]=people[positions[i]]);

solve satisfy;