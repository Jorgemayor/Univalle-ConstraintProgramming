include "pruebas/Trivial1.dzn";
include "globals.mzn";


/*
ACTORES = {Actor1, Actor2, Actor3} ;

Escenas = [| 0,1,0,0,0,0,10
           | 0,1,1,1,0,1,20
           | 0,0,0,0,1,1,15|]; 
           
Duracion = [2,1,1,1,3,4];
*/



enum ACTORES;
array[int,int] of int: Escenas;
array[int] of int: Duracion;
array[1..numeroEscenas] of var int: ordenEscenas;




var int: costo;
int: numeroEscenas  = length(Duracion);
int: numeroActores = length(set2array(ACTORES));


constraint ordenEscenas[3] = costo;
constraint costo = 4; 


solve satisfy;