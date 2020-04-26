include "pruebas/Trivial2.dzn";
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
set of int: rangoActores = index_set(ACTORES);
set of int: rangoEscenas = 1..numeroEscenas;

array[rangoEscenas] of var rangoEscenas: ordenEscenas;
array[rangoActores, 1..2] of var 1..numeroEscenas: intervalos;
array[rangoActores, rangoEscenas] of var 0..1: ordenActuaciones;
array[rangoActores] of var 0..infinity: costoPorActor;
var 0..infinity: costo;

function var int: obtenerEscena(array[int] of var 0..1: elements, int: index) =
    if index = numeroEscenas+1
        then 0
    elseif elements[index] == 1
        then index
    else
        obtenerEscena(elements, index + 1)
    endif;

constraint alldifferent(ordenEscenas);

constraint forall(actor in rangoActores, escena in rangoEscenas)
                  (ordenActuaciones[actor, escena] = Escenas[actor, ordenEscenas[escena]]);

constraint forall(actor in rangoActores)
                    (let {array[int] of var int: x = row(ordenActuaciones, actor)} in
                     intervalos[actor, 1] = obtenerEscena(x, 1) /\
                     intervalos[actor, 2] = (numeroEscenas - obtenerEscena(reverse(x), 1) + 1));

constraint forall(actor in rangoActores)
                  (costoPorActor[actor] = sum([ Duracion[ordenEscenas[escena]] * Escenas[actor, numeroEscenas+1] |
                   escena in rangoEscenas where escena >= intervalos[actor, 1] /\ escena <= intervalos[actor, 2]]));

constraint sum(costoPorActor) = costo;

output[show(ordenEscenas)] ++ ["\n\n"];

output[show(costo)];

solve minimize costo;