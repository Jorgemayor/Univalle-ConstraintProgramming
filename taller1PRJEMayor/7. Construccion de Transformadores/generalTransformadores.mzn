% Transformadores (Point 7 - General form)


% LIBRARIES
include "globals.mzn";
include "transformadores.dzn";

% VARIABLES

%Total work time.
0..infinity: workTime;

%Quantity of ferromagnetic material available.
0..infinity: material;

%First transformer.
var 0..infinity: transformer1;

%Second transformer.
var 0..infinity: transformer2;

%Variable to store the profit.
var int: profit;


% CONSTRAINTS

constraint 2*transformer1 + transformer2 <= material;

%Makes sure not to exceed the time required for the all the first kind transformers to finish.
constraint 7*transformer1 <= workTime;

%Makes sure not to exceed the time required for the all the second kind transformers to finish.
constraint 8*transformer2 <= workTime;

%Calculates the profit.
constraint profit = 120*transformer1 + 80*transformer2;


%Solves maximazing the profit.
solve maximize profit;