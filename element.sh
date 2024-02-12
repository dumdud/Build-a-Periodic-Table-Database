#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
  exit 0
fi

if [[ $1 =~ ^[0-9]+$ ]]
then
  RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1;")

  if [[ -z $RESULT ]]
  then
    echo "I could not find that element in the database."
    exit 0
  fi

  echo $RESULT | while IFS="|" read ID AT_NUM SYMBOL NAME MASS MELTING_P BOILING_P TYPE
  do
    echo "The element with atomic number $AT_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_P celsius and a boiling point of $BOILING_P celsius."
  done
fi

if [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]
then
  RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = INITCAP('$1');")
  if [[ -z $RESULT ]]
  then
    echo "I could not find that element in the database."
    exit 0
  fi
  echo $RESULT | while IFS="|" read ID AT_NUM SYMBOL NAME MASS MELTING_P BOILING_P TYPE
  do
    echo "The element with atomic number $AT_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_P celsius and a boiling point of $BOILING_P celsius."
  done
fi

if [[ $1 =~ ^[a-zA-Z]{3,} ]]
then
  RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name = INITCAP('$1');")

  if [[ -z $RESULT ]]
  then
    echo "I could not find that element in the database."
    exit 0
  fi
  echo $RESULT | while IFS="|" read ID AT_NUM SYMBOL NAME MASS MELTING_P BOILING_P TYPE
  do
    echo "The element with atomic number $AT_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_P celsius and a boiling point of $BOILING_P celsius."
  done
fi



