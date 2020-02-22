% Sudoku (Point 1)


% LIBRARIES

include "alldifferent.mzn"; %Library of MiniZinc
include "sudoku.dzn"; %Dataset of sudoku


% VARIABLES

%Size of the square that contains 9 cells. It's filled through the external dataset.
int: smallSquareSize;

%Size of the biggest square.
int: bigSquareSize = smallSquareSize*smallSquareSize;

%Size of the small square.
set of int: smallSquareRange = 1..smallSquareSize;

%Size of the board (It have to be a square, usually of 9x9).
set of int: bigSquareRange = 1..bigSquareSize;

%Board of the game. It's auto filled with the data in 'sudoku.dzn'.
array[1..bigSquareSize, 1..bigSquareSize] of var bigSquareRange: board;


%CONTRAINTS

%Makes all numbers in a row, different.
constraint forall(i in bigSquareRange) (alldifferent([board[i,j] | j in bigSquareRange]));

%Makes all numbers in a column, different.
constraint forall(j in bigSquareRange)
            (alldifferent([board[i,j] | i in bigSquareRange]));

%Makes different all numbers in smaller squares.
constraint forall(i,j in smallSquareRange)
            (alldifferent([board[m+3*(i-1),n+3*(j-1)] | m,n in smallSquareRange]));


%Solves until satisfy (If it's possible).
solve satisfy;

%Prints a sudoku board.
output [ show_int(0,board[i,j]) ++ " " ++ 
         if j mod smallSquareSize == 0 then " " else "" endif ++
         if j == bigSquareSize /\ i != bigSquareSize then 
             if i mod smallSquareSize == 0 then "\n\n" else "\n" endif 
         else "" endif | i,j in bigSquareRange ] ++ ["\n"];