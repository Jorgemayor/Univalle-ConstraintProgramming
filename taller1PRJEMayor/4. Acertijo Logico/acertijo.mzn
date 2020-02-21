%LIBRARIES
include "alldifferent.mzn";

%VARIABLES

%First names
var 24..26: juan;
var 24..26: dario;
var 24..26: oscar;

%Last names
var 24..26: gonzalez;
var 24..26: garcia;
var 24..26: lopez;

%Music
var 24..26: clasica;
var 24..26: pop;
var 24..26: jazz;


%CONSTRAINTS

constraint juan > gonzalez /\ gonzalez != clasica;
constraint pop != garcia /\ pop != 24;
constraint oscar != lopez /\ oscar = 25;
constraint dario != jazz;
constraint alldifferent([juan,oscar,dario]);

solve satisfy;