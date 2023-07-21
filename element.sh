#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

MENU() {
if [[ -z $1 ]]
then
echo Please provide an element as an argument.
else
ELEMENT=$($PSQL "select e.atomic_number, e.symbol, e.name, 
melting_point_celsius, boiling_point_celsius, atomic_mass, type
from elements e join properties using(atomic_number)
join types using(type_id)
where e.atomic_number = $1")
echo "$ELEMENT"
fi

}
MENU $1

# The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.