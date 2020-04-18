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
int: numeroEscenas  = length(Duracion);
int: numeroActores = max(rangoActores);

set of int: rangoActores = index_set_1of2(ACTORES);
set of int: rangoEscenas = 1..numeroEscenas;

array[rangoEscenas] of var rangoEscenas: ordenEscenas;
array[rangoActores, 1..2] of var 1..numeroEscenas: intervalos;
var numeroActores..max(rangoActores): costo;
array[rangoActores, rangoEscenas] of var 0..1: ordenActuaciones;

function var int: getIndex(array[int] of var int: elements, int: index) =
    if elements[index] == 1
        then index
    else
        getIndex(elements, index + 1)
    endif;

function var int: obtenerEscena(array[int] of var int: x) = getIndex(x, 0);

constraint forall(actor in rangoActores, escena in rangoEscenas)
                  (ordenActuaciones[actor, escena] = Escenas[actor, ordenEscenas[escena]]);

constraint forall(actor in rangoActores)
                    (let {array[int] of var int: x = [ordenActuaciones[actor, i] | i in rangoEscenas]} in
                     intervalos[actor, 1] = obtenerEscena(x) /\
                     intervalos[actor, 2] = (numeroEscenas - obtenerEscena(reverse(x))));

solve satisfy;