% Gasolina (Point 8 - Specific form)


% LIBRARIES

include "globals.mzn";
include "gasolina.dzn";

% VARIABLES

%Number of gasoline galons.
int: gasolineGalons;

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

%Defines the required octane, pression steam and volaility, respectively, of the butane.
array[1..3] of int: butaneData;

%Defines the required octane, pression steam and volatility, respectively, of the catalytic reformed.
array[1..3] of int: catalyticData;

%Defines the required octane, pression steam and volatility, respectively, of the heavy naphtha.
array[1..3] of int: naphthaData;

%Defines the requirements of the gasoline.
array[1..3] of int: requirements;


% CONSTRAINTS

%Verifies the contraint of the octane.
constraint butaneData[1]*butane + catalyticData[1]*catalytic + naphthaData[1]*naphtha >= requirements[1]*gasolineGalons;

%Verifies the contraint of the pression steam.
constraint butaneData[2]*butane + catalyticData[2]*catalytic + naphthaData[2]*naphtha <= requirements[2]*gasolineGalons;

%Verifies the contraint of the volatility.
constraint butaneData[3]*butane + catalyticData[3]*catalytic + naphthaData[3]*naphtha >= requirements[3]*gasolineGalons;

%Calculates the profit.
constraint profit = 58*butane + 155*catalytic + 85*naphtha;


%Solve by maximizing the profit.
solve maximize profit;