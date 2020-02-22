% Rectangulo (Point 6)


% LIBRARIES
include "globals.mzn";
include "rectangulo.dzn"; %Dataset


% VARIABLES

%Sides of the squares.
array[int] of int: squareSides;

%Number of squares.
int: numberOfSquares = length(squareSides);

