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
-- Declare variables
DECLARE cur_player CURSOR FOR SELECT player_id, players_name, players_surname FROM Players;

DECLARE cur_game CURSOR FOR SELECT game_id, games_date FROM Games ORDER BY games_date;

DECLARE cur_stats CURSOR FOR
    SELECT P.players_name, P.players_surname, G.games_date, T.teams_name, PGS.goals, PGS.penalties, PGS.red_cards, PGS.yellow_cards, PGS.active_time, P.position
    FROM PlayerGameStatistics PGS
    JOIN Players P ON PGS.player_id = P.player_id
    JOIN Teams T ON PGS.team_id = T.team_id
    JOIN Games G ON PGS.game_id = G.game_id
    WHERE P.player_id = cur_player.player_id
    ORDER BY G.games_date;

-- Declare variables to hold fetched values
DECLARE @player_id INTEGER;
DECLARE @players_name VARCHAR(10);
DECLARE @players_surname VARCHAR(10);

DECLARE @game_id INTEGER;
DECLARE @games_date DATE;

DECLARE @goals INTEGER;
DECLARE @penalties INTEGER;
DECLARE @red_cards INTEGER;
DECLARE @yellow_cards INTEGER;
DECLARE @active_time TIME;
DECLARE @position VARCHAR(255);

-- Open the player cursor and fetch the first row
OPEN cur_player;
FETCH NEXT FROM cur_player INTO @player_id, @players_name, @players_surname;

-- Loop through each player
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Open the game cursor and fetch the first row
    OPEN cur_game;
    FETCH NEXT FROM cur_game INTO @game_id, @games_date;
    
    -- Loop through each game
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Open the stats cursor and fetch the first 10 rows
        OPEN cur_stats;
        FETCH NEXT FROM cur_stats INTO @players_name, @players_surname, @games_date, @teams_name, @goals, @penalties, @red_cards, @yellow_cards, @active_time, @position;
        
        -- Print header
        PRINT 'Player: ' + @players_name + ' ' + @players_surname + ', Game Date: ' + CONVERT(VARCHAR(10), @games_date, 120);
        PRINT '---------------------------------------------------------';
        PRINT 'Team           Goals   Penalties   Red Cards   Yellow Cards   Active Time   Position';
        PRINT '---------------------------------------------------------';
        
        -- Loop through each stat row
        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Print the statistics
            PRINT @teams_name + '       ' + CONVERT(VARCHAR(3), @goals) + '        ' + CONVERT(VARCHAR(3), @penalties) + '            ' + CONVERT(VARCHAR(3), @red_cards) + '            ' + CONVERT(VARCHAR(3), @yellow_cards) + '              ' + CONVERT(VARCHAR(8), @active_time, 108) + '    ' + @position;
            
            -- Fetch the next row
            FETCH NEXT FROM cur_stats INTO @players_name, @players_surname, @games_date, @teams_name, @goals, @penalties, @red_cards, @yellow_cards, @active_time, @position;
        END
        
        -- Close the stats cursor
        CLOSE cur_stats;
        DEALLOCATE cur_stats;
        
        -- Fetch the next game row
        FETCH NEXT FROM cur_game INTO @game_id, @games_date;
    END
    
    -- Close the game cursor
    CLOSE cur_game;
    DEALLOCATE cur_game;
    
    -- Fetch the next player row
    FETCH NEXT FROM cur_player INTO @player_id, @players_name, @players_surname;
    
    -- Print a separator between players
    PRINT '---------------------------------------------------------';
END

-- Close the player cursor
CLOSE cur_player;
DEALLOCATE cur_player;
