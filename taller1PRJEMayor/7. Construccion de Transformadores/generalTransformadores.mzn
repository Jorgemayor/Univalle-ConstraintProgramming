% Transformadores (Point 7 - General form)


% LIBRARIES
include "globals.mzn";
include "transformadores.dzn";


% VARIABLES

%Time needed per transformer
array[int] of 0..infinity: timeNeeded;

%Material needed per transformer
array[int] of 0..infinity: materialNeeded;

%Profit generated per transformer
array[int] of 0..infinity: profitGen;

%Number of kinds of transformers
int: numberOfTransformers = length(profitGen);

%Total work time.
0..infinity: workTime;

%Quantity of ferromagnetic material available.
0..infinity: material;

%Array of transformers
array[1..numberOfTransformers] of var 0..infinity: transformers;

%Variable to store the profit.
var int: profit;


% CONSTRAINTS

%Makes sure not to exceed the material required.
constraint sum([materialNeeded[i]*transformers[i] | i in 1..numberOfTransformers]) <= material;

%Makes sure not to exceed the time required to finish.
constraint sum([timeNeeded[i]*transformers[i] | i in 1..numberOfTransformers]) <= workTime;

%Calculates the profit.
constraint profit = sum([profitGen[i]*transformers[i] | i in 1..numberOfTransformers]);


%Solves maximizing the profit.
solve maximize profit;