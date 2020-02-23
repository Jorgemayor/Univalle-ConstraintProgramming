% Kakuro (Point 3)


% LIBRARIES
include "kakuro.dzn"; %Dataset


% VARIABLES

%Stores the board
array[int, int] of int: board;

%Vertical results
array[int, 1..4] of int: vertical;

%number of rows in vertical
int: constraintsVertical = length(vertical) div 4;

%Horizontal results
array[int, 1..4] of int: horizontal;


% CONSTRAINT

constraint forall (i in 1..constraintsVertical)
              ([vertical[i,j] | j in ]);