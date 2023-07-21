#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

MENU() {
if [[ -z $1 ]]
then
echo Please provide an element as an argument.
else

if [[ "$1" =~ ^[0-9]+$ ]]; then
  ARGUMENT="$1"
  WHERE_CLAUSE="WHERE e.atomic_number = $ARGUMENT"
else
  ARGUMENT="'$1'"
  WHERE_CLAUSE="WHERE e.symbol = $ARGUMENT or e.name = $ARGUMENT"
fi
# echo $WHERE_CLAUSE
# echo "select e.atomic_number, e.symbol, e.name, 
# melting_point_celsius, boiling_point_celsius, atomic_mass, type
# from elements e join properties using(atomic_number)
# join types using(type_id) $WHERE_CLAUSE"

ELEMENT=$($PSQL "select e.atomic_number, e.symbol, e.name, 
melting_point_celsius, boiling_point_celsius, atomic_mass, type
from elements e join properties using(atomic_number)
join types using(type_id)
$WHERE_CLAUSE")
IFS='|'

# Read the result into variables
read ATOMIC_NUMBER SYMBOL NAME MELTING_POINT BOILING_POINT ATOMIC_MASS TYPE <<< $ELEMENT

if [[ $NAME ]]
then
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
else
  echo "I could not find that element in the database."
fi
fi


}
MENU $1

