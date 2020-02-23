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

%Coordenates X of the squares.
array[rangeSquares] of var 0..(width-1): coordenatesX;

%Coordenates Y of the squares.
array[rangeSquares] of var 0..(height-1): coordenatesY;


% CONSTRAINTS

%Does not let the squares pass the limits of the rectangule.
constraint forall(i in rangeSquares)
              (coordenatesX[i]+squareSides[i]<=width /\ coordenatesY[i]+squareSides[i]<=height);

%Avoids gaps and squares of big area.
constraint sum([squareSides[i]*squareSides[i] | i in index_set(squareSides)])=width*height;

%Avoids overlap between squares vertically.
constraint forall(i, j in rangeSquares)
              (if i != j /\ coordenatesX[i] <= coordenatesX[j] /\ coordenatesX[j] <= coordenatesX[i]+squareSides[i]
               then coordenatesY[i]+squareSides[i] <= coordenatesY[j] else true endif);

%Avoids overlap between squares horizontally.
constraint forall(i, j in rangeSquares)
              (if i != j /\ coordenatesY[i] <= coordenatesY[j] /\ coordenatesY[j] <= coordenatesY[i]+squareSides[i]
               then coordenatesX[i]+squareSides[i] <= coordenatesX[j] else true endif);

%Searchs until satisfy (If its possible).
solve satisfy;