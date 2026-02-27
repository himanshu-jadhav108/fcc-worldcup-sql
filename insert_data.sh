#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# clear tables
echo $($PSQL "TRUNCATE games, teams")

# read csv
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT W_GOALS O_GOALS
do
  # skip header
  if [[ $YEAR != "year" ]]
  then
    # get winner id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    if [[ -z $WINNER_ID ]]
    then
      echo "Inserting team: $WINNER"
      $PSQL "INSERT INTO teams(name) VALUES('$WINNER')"
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi

    # get opponent id
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    if [[ -z $OPPONENT_ID ]]
    then
      echo "Inserting team: $OPPONENT"
      $PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')"
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    fi

    # insert game
    echo "Inserting game: $YEAR $ROUND"
    $PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals)
           VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$W_GOALS,$O_GOALS)"
  fi
done