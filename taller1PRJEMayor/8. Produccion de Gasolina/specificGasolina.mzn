% Gasolina (Point 8 - Specific form)


% LIBRARIES

include "globals.mzn";


% VARIABLES

%Number of gasoline galons.
int: gasolineGalons = 12000;

%Set of non negative integers.
set of int: nonNegative = 0..infinity;

%Defines the number of required galons of butane.
var nonNegative: butane;

%Defines the number of required galons of catalytic reformed.
var nonNegative: catalytic;

%Defines the number of required galons of heavy naphtha.
var nonNegative: naphtha;

%Defines the profit.
var int: profit;


% CONSTRAINTS

%Verifies the contraint of the octane.
constraint 1200*butane + 1000*catalytic + 740*naphtha >= 890*gasolineGalons;

%Verifies the contraint of the pression steam.
constraint 600*butane + 25*catalytic + 40*naphtha <= 110*gasolineGalons;

%Verifies the contraint of the volatility.
constraint 1050*butane + 30*catalytic + 120*naphtha >= 170*gasolineGalons;

%Calculates the profit.
constraint profit = 58*butane + 155*catalytic + 85*naphtha;


%Solve by maximizing the profit.
solve maximize profit;