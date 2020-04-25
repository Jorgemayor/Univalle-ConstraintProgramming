% Rectangulo (Point 6)


% LIBRARIES
include "globals.mzn";
include "rectangulo.dzn"; %Dataset


% VARIABLES

%Coordenates X of the squares.
array[rangeSquares] of var 0..(width-1): coordinatesX;

%Coordenates Y of the squares.
array[rangeSquares] of var 0..(height-1): coordinatesY;


% PARAMETERS

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


% CONSTRAINTS

%Does not let the squares pass the limits of the rectangule.
constraint forall(i in rangeSquares)
              (coordinatesX[i]+squareSides[i]<=width /\ coordinatesY[i]+squareSides[i]<=height);

%Avoids gaps and squares of big area in rows.
constraint sum([squareSides[j] | i in 1..height, j in 1..numberOfSquares where coordinatesY[j] < i /\ coordinatesY[j] + squareSides[j]>=i]) = width;

%Avoids gaps and squares of big area in columns.
constraint sum([squareSides[i] | j in 1..width, i in rangeSquares where coordinatesX[i]<j /\ coordinatesX[i] + squareSides[i]>=j]) = height;

%Avoids overlap between squares vertically.
constraint forall(i, j in rangeSquares)
              (if i != j /\ coordinatesX[i] <= coordinatesX[j] /\ coordinatesX[j] <= coordinatesX[i]+squareSides[i]
               then coordinatesY[i]+squareSides[i] <= coordinatesY[j] else true endif);

%Avoids overlap between squares horizontally.
constraint forall(i, j in rangeSquares)
              (if i != j /\ coordinatesY[i] <= coordinatesY[j] /\ coordinatesY[j] <= coordinatesY[i]+squareSides[i]
               then coordinatesX[i]+squareSides[i] <= coordinatesX[j] else true endif);

%Searchs until satisfy (If its possible).
solve satisfy;