% Rectangulo (Point 6)


% LIBRARIES
include "globals.mzn";
include "rectangulo.dzn"; %Dataset


% VARIABLES

%Sides of the squares.
array[int] of int: squareSides;

%Number of squares.
int: numberOfSquares = length(squareSides);

%Range of squares
set of int: rangeSquares = 1..numberOfSquares;

%Width of the final rectangle.
int: width;

%Height of the final rectangle.
int: height;

%Coordenates of the squares.
array[rangeSquares, 1..2] of var 0..(max([width,height])-1): coordenates;


% CONSTRAINTS

%Does not let the squares pass the limits of the rectangule.
constraint forall(i in rangeSquares)
              (coordenates[i,1]+squareSides[i]<=width /\ coordenates[i,2]+squareSides[i]<=height);

%Avoids gaps and squares of big area.
constraint sum([squareSides[i]*squareSides[i] | i in rangeSquares])=width*height;

%Does not let overlap between squares.
constraint forall(i, j in rangeSquares)
              (if i != j /\ coordenates[i,1] <= coordenates[j,1] /\ coordenates[j,1] <= coordenates[i,1]+squareSides[i]
               then coordenates[i,2]+squareSides[i] <= coordenates[j,2]
               elseif i != j /\ coordenates[i,2] <= coordenates[j,2] /\ coordenates[j,2] <= coordenates[i,2]+squareSides[i]
               then coordenates[i,1]+squareSides[i] <= coordenates[j,1]
               else true endif);


%Searchs until satisfy (If its possible).
solve satisfy;