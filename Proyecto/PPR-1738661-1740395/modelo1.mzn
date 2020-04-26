%% LIBRARIES

include "pruebas/modelo1/Trivial1.dzn";
include "globals.mzn";


%% INPUT DATA

% Enumeration with actor's name
enum ACTORES;

% Matrix specifying the scenes which each actor
% perform and the salary of each actor per unity
% of time
array[int,int] of int: Escenas;

% Array specifying the duration of each scene
array[int] of int: Duracion;


%% CONSTANTS

% Number of scenes
int: numeroEscenas  = length(Duracion);

% Number of actor
int: numeroActores = max(rangoActores);

% Range of iterators for a set of actors
set of int: rangoActores = index_set(ACTORES);

% Range of iterators for a set of scenes
set of int: rangoEscenas = 1..numeroEscenas;


%% VARIABLES

% Right order of the scenes to minimize the cost
array[rangoEscenas] of var rangoEscenas: ordenEscenas;

% Limits of the intervals that define the first and last scene
% in which each actor have to be in the set
array[rangoActores, 1..2] of var 0..numeroEscenas: limites;

% Intervals defining the scene since each actor have to be in
% the set till each one of them could go out
array[rangoActores] of var set of 0..numeroEscenas: intervalos;

% Order of perfomances per actor, due to ordenEscenas
array[rangoActores, rangoEscenas] of var 0..1: ordenActuaciones;

% Time in set per actor
array[rangoActores] of var 0..infinity: horasEnSet; 

% Total cost per actor
array[rangoActores] of var 0..infinity: costoPorActor;

% Total cost
var 0..infinity: costo;


%% FUNCTIONS

% Returns the index of the first scene which an actor performs. If the actor
% do not perform any scene, returns 0
function var int: obtenerEscena(array[int] of var 0..1: scenes, int: index) =
    if index = numeroEscenas+1
        then 0
    elseif scenes[index] = 1
        then index
    else
        obtenerEscena(scenes, index + 1)
    endif;


%% CONSTRAINTS

% Avoid repeted scenes
constraint alldifferent(ordenEscenas);

% Organize the matrix of perfomances due to ordenEscenas
constraint forall(actor in rangoActores, escena in rangoEscenas)
                  (ordenActuaciones[actor, escena] = Escenas[actor, ordenEscenas[escena]]);

% Sets the firs and the last scene in which each actor have to be in the set
constraint forall(actor in rangoActores)
                    (let {array[int] of var int: x = row(ordenActuaciones, actor)} in
                     limites[actor, 1] = obtenerEscena(x, 1) /\
                     limites[actor, 2] = (numeroEscenas - obtenerEscena(reverse(x), 1) + 1));

% Define the interval in which each actor have to be in the set
constraint forall(actor in rangoActores)
                  (intervalos[actor] = limites[actor,1]..limites[actor,2]);

% Finds the amount of time unities that each actor spend in the set
constraint forall(actor in rangoActores)
                  (horasEnSet[actor] = sum([ Duracion[ordenEscenas[escena]] |
                  escena in intervalos[actor] where escena != 0]));

% Sets the total cost per actor
constraint forall(actor in rangoActores)
                  (costoPorActor[actor] = horasEnSet[actor] * Escenas[actor, numeroEscenas+1]);

% Constraints the total cost to be the sum of actors' salary 
constraint sum(costoPorActor) = costo;


% Outputs the scenes in the best order
output[show(ordenEscenas)] ++ ["\n\n"];

% Outputs the total cost
output[show(costo)];


% Minimize total cost
solve minimize costo;