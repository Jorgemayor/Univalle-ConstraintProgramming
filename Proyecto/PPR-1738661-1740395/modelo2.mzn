%% LIBRARIES

include "pruebas/modelo2/Med2-1.dzn";
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
function var int: obtenerEscena(array[int] of var 0..1: scenes) =
    getIndex(scenes, 1, 1);


function var int: getIndex(array[int] of var int: array_, int: index, int: value) =
    if index = numeroEscenas+1
        then 0
    elseif array_[index] = 1
        then index
    else
        getIndex(array_, index + 1, value)
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
                     limites[actor, 1] = obtenerEscena(x) /\
                     limites[actor, 2] = (numeroEscenas - obtenerEscena(reverse(x)) + 1));

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


%% ADDITIONAL INPUT

% Availability of time per actor
array[int, 1..2] of int: Disponibilidad;

% Actors that must be together the minimum
% quantity of time
array[int, 1..2] of int: Evitar;


%% ADDIOTION CALCULATED DATA
array[rangoEscenas] of var rangoEscenas: indicesOrdenEscenas;

%% ADDITIONAL VARIABLES

% Time that actors that do not like
% each other, spend together
var 0..infinity: timeToMinimize;


% ADDITIONAL CONSTRAINTS

% Avoids actor working more than allowed
% per journey
constraint forall(actor in rangoActores)
    (if Disponibilidad[actor, 2] = 0
        then true
    else
        horasEnSet[Disponibilidad[actor, 1]] <= Disponibilidad[actor, 2]
    endif);

% Finds the time that actors that do not like
% each other, spend together
constraint timeToMinimize =
                          sum([sum( [Duracion[ordenEscenas[scene]] | scene in (intervalos[Evitar[relacion,1]] intersect
                                                                intervalos[Evitar[relacion,2]])])
                                                    | relacion in 1..length(Evitar) div 2]);


%% AVOID SYMMETRIES

% Avoid inverse solutions
constraint lex_lesseq(ordenEscenas, reverse(ordenEscenas));

constraint forall(escena in rangoEscenas)
                  (indicesOrdenEscenas[ordenEscenas[escena]] = escena);

% Differenciate scenes that performs the same actors
constraint forall(escenaId in rangoEscenas)
                  (let {array[rangoActores] of 0..1: escena = col(Escenas, escenaId)} in
                        forall(escenaId2 in escenaId..numeroEscenas)
                              (if escena = col(Escenas, escenaId)
                                  then indicesOrdenEscenas[escenaId] < indicesOrdenEscenas[escenaId2]
                               else
                                  true
                               endif));


% Outputs the scenes in the best order
output[show(ordenEscenas)] ++ ["\n\n"];

output[show(Evitar)] ++ ["\n\n"];

% Outputs the total cost
output[show(costo)];


% Minimize total cost
solve minimize costo;