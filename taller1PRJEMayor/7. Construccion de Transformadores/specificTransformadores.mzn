% Transformadores (Point 7 - Specific form)


% LIBRARIES
include "globals.mzn";


% VARIABLES

%First transformer.
var 0..infinity: transformer1;

%Second transformer.
var 0..infinity: transformer2;

%Variable to store the profit.
var int: profit;


% CONSTRAINTS

constraint 2*transformer1 + transformer2 <= 6;

%Makes sure not to exceed the time required to finish.
constraint 7*transformer1 + 8*transformer2 <= 28;

%Calculates the profit.
constraint profit = 120*transformer1 + 80*transformer2;


%Solves maximazing the profit.
solve maximize profit;