% Secuencia (Point 3)


% LIBRARIES
include "globals.mzn";
include "secuencia.dzn"; %Dataset


% VARIABLES

%Length of the sequence.
int: n;

%Range of the sequence.
set of int: rangeSequence = 0..(n-1);

%Array with the sequence.
array[rangeSequence] of var rangeSequence: sequence;


% CONTRAINTS

%Makes the sum of the numbers in the sequence, equal to its length.
constraint sum(sequence)=n;

%Constraints the number of times that a i-th element must appear in the sequence.
constraint forall(i in rangeSequence)
              (count(sequence,i,sequence[i]));

%Solves until satisfy (If possible).
solve satisfy;

output [show(sequence[i]) ++ if i != n then " " else "" endif | i in rangeSequence];