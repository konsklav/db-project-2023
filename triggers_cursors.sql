--a)
CREATE OR REPLACE FUNCTION team_relegation() 
RETURNS TRIGGER
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'RelegatedTeams') THEN
        CREATE TABLE RelegatedTeams (
            team_id SERIAL PRIMARY KEY,
            teams_name VARCHAR(255) NOT NULL, 
            home_field_name VARCHAR(255) NOT NULL,
            history_description TEXT,
            home_wins INTEGER NOT NULL,
            away_wins INTEGER NOT NULL,
            home_losses INTEGER NOT NULL,
            away_losses INTEGER NOT NULL,
            home_draws INTEGER NOT NULL,
            away_draws INTEGER NOT NULL
        );
    END IF;
    INSERT INTO RelegatedTeams (teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws) 
    VALUES (OLD.teams_name, OLD.home_field_name, OLD.history_description, OLD.home_wins, OLD.away_wins, OLD.home_losses, OLD.away_losses, OLD.home_draws, OLD.away_draws);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enforce_team_relegation
AFTER DELETE ON Teams
FOR EACH ROW
EXECUTE FUNCTION team_relegation();

--b)
--Ο κώδικας τοποθετήθηκε μέσα σε procedure για να μπορεί να τρέξει στο pgadmin4
CREATE OR REPLACE PROCEDURE statistics_cursors()
LANGUAGE plpgsql
AS $$
DECLARE
  current_player_id INTEGER;
  current_team_id INTEGER;
  current_game_id INTEGER;
  current_start_date DATE := '2022-09-01';
  current_end_date DATE;
  current_stats RECORD;
  current_goals INTEGER;
  current_penalties INTEGER;
  current_red_cards INTEGER;
  current_yellow_cards INTEGER;
  current_active_time TIME;
  current_position VARCHAR(255);
  count INTEGER := 0;

  player_cursor CURSOR FOR SELECT DISTINCT player_id FROM PlayerGameStatistics ORDER BY player_id;
  team_cursor CURSOR (team_player_id INTEGER) FOR SELECT DISTINCT team_id FROM PlayerGameStatistics WHERE player_id = team_player_id ORDER BY team_id;
  game_cursor CURSOR (game_player_id INTEGER, game_team_id INTEGER) FOR SELECT DISTINCT PGS.game_id, games_date FROM PlayerGameStatistics PGS JOIN Games G ON PGS.game_id = G.game_id WHERE player_id = game_player_id AND PGS.team_id = game_team_id ORDER BY PGS.game_id;

BEGIN
  OPEN player_cursor;
  LOOP
    FETCH player_cursor INTO current_player_id;
    EXIT WHEN current_player_id IS NULL;

    OPEN team_cursor(current_player_id);
    LOOP
      FETCH team_cursor INTO current_team_id;
      EXIT WHEN current_team_id IS NULL;

      OPEN game_cursor(current_player_id, current_team_id);
      LOOP
        FETCH game_cursor INTO current_game_id, current_start_date;
        EXIT WHEN current_game_id IS NULL;

        current_end_date := current_start_date + INTERVAL '10 days';

        FOR current_stats IN (
          SELECT
            goals,
            penalties,
            red_cards,
            yellow_cards,
            active_time,
            position
          FROM PlayerGameStatistics PGS
            JOIN Players P ON PGS.player_id = P.player_id
          WHERE
            PGS.player_id = current_player_id AND
            PGS.team_id = current_team_id AND
            game_id IN (SELECT game_id FROM Games WHERE games_date >= current_start_date AND games_date < current_end_date)
          GROUP BY goals, penalties, red_cards, yellow_cards, active_time, position
        ) LOOP

          current_goals := current_stats.goals;
          current_penalties := current_stats.penalties;
          current_red_cards := current_stats.red_cards;
          current_yellow_cards := current_stats.yellow_cards;
          current_active_time := current_stats.active_time;
          current_position := current_stats.position;

          RAISE NOTICE 'Player: %, Team: %, Period: % - %', current_player_id, current_team_id, current_start_date, current_end_date;
          RAISE NOTICE 'Goals: %, Penalties: %, Red Cards: %, Yellow Cards: %, Active Time: %, Position: %', current_goals, current_penalties, current_red_cards, current_yellow_cards, current_active_time, current_position;

          count := count + 1;

          IF count = 10 THEN
            count := 0;
            EXIT WHEN NOT FOUND;
          END IF;
        END LOOP;
      END LOOP;
      CLOSE game_cursor;
    END LOOP;
    CLOSE team_cursor;
  END LOOP;
  CLOSE player_cursor;
END;
$$

CALL statistics_cursors();  --Κλήση της διαδικασίας
