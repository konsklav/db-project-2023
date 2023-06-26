--a)
CREATE OR REPLACE FUNCTION team_relegation() 
RETURNS TRIGGER
AS $$
BEGIN
    -- Create the table RelegatedTeams if it doesn't already exist
    CREATE TABLE IF NOT EXISTS RelegatedTeams (
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

    -- Insert the deleted row into the RelegatedTeams table
    INSERT INTO RelegatedTeams (teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws) 
    VALUES (OLD.teams_name, OLD.home_field_name, OLD.history_description, OLD.home_wins, OLD.away_wins, OLD.home_losses, OLD.away_losses, OLD.home_draws, OLD.away_draws);

    -- Return the modified row to proceed with the delete operation
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enforce_team_relegation
AFTER DELETE ON Teams
FOR EACH ROW
EXECUTE FUNCTION team_relegation();

--b)
