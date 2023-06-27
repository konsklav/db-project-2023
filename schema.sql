CREATE EXTENSION IF NOT EXISTS "citext";	--Χρήση EXTENSION "citext" για υποστήριξη πλήρους στίξης στα ελληνικά

CREATE TABLE IF NOT EXISTS Teams (
    team_id SERIAL PRIMARY KEY,
    teams_name VARCHAR(255) NOT NULL UNIQUE,    --Χρήση keyword unique, για την εξασφάλιση της μοναδικότητας του ονόματος της ομάδας 
    home_field_name VARCHAR(255) NOT NULL,
    history_description TEXT,
    home_wins INTEGER NOT NULL CHECK (home_wins >= 0) DEFAULT 0,    --Χρήση check για την εξασφάλιση μη αρνητικού insert στα πεδία των στατιστικών της ομάδας
    away_wins INTEGER NOT NULL CHECK (away_wins >= 0) DEFAULT 0,
    home_losses INTEGER NOT NULL CHECK (home_losses >= 0) DEFAULT 0,
    away_losses INTEGER NOT NULL CHECK (away_losses >= 0) DEFAULT 0,
    home_draws INTEGER NOT NULL CHECK (home_draws >= 0) DEFAULT 0,
    away_draws INTEGER NOT NULL CHECK (away_draws >= 0) DEFAULT 0
);

CREATE TABLE IF NOT EXISTS Players (
    player_id SERIAL PRIMARY KEY,
    players_name VARCHAR(10) COLLATE "C" NOT NULL,   --Χρήση COLLATE "C" για υποστήριξη πλήρους στίξης στα ελληνικά
    players_surname VARCHAR(10) COLLATE "C" NOT NULL,   --Χρήση COLLATE "C" για υποστήριξη πλήρους στίξης στα ελληνικά
    team_id INTEGER REFERENCES Teams(team_id) ON DELETE SET NULL,
    position VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Coaches (
    coach_id SERIAL PRIMARY KEY,
    player_id INTEGER NOT NULL REFERENCES Players(player_id) ON DELETE CASCADE,
    coaching_role VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Games (
    game_id SERIAL PRIMARY KEY,
    home_team_id INTEGER NOT NULL REFERENCES Teams(team_id),
    away_team_id INTEGER NOT NULL REFERENCES Teams(team_id),
    home_teams_score INTEGER NOT NULL CHECK (home_teams_score >= 0) DEFAULT 0,  --Χρήση check για την εξασφάλιση μη αρνητικού insert στα πεδία του σκορ
    away_teams_score INTEGER NOT NULL CHECK (away_teams_score >= 0) DEFAULT 0,
    games_date DATE NOT NULL,
    duration TIME NOT NULL DEFAULT '00:00:00'      
);

--Εξασφάλιση μοναδικότητας αγώνα μεταξύ δύο ομάδων σε μία συγκεκριμένη ημέρα 
ALTER TABLE Games ADD CONSTRAINT unique_game_per_day UNIQUE (home_team_id, away_team_id, games_date);   

CREATE TABLE IF NOT EXISTS PlayerGameStatistics (
    player_id INTEGER NOT NULL REFERENCES Players(player_id) ON DELETE CASCADE,
    team_id INTEGER NOT NULL REFERENCES Teams(team_id),
    game_id INTEGER NOT NULL REFERENCES Games(game_id) ON DELETE CASCADE,
    red_cards INTEGER NOT NULL CHECK (red_cards >= 0) DEFAULT 0,             --Χρήση check για την εξασφάλιση μη αρνητικού insert στα πεδία των στατιστικών του παίκτη 
    yellow_cards INTEGER NOT NULL CHECK (yellow_cards >= 0) DEFAULT 0,
    goals INTEGER NOT NULL CHECK (goals >= 0) DEFAULT 0,
    canceled_goals INTEGER NOT NULL CHECK (canceled_goals >= 0) DEFAULT 0,
    active_time TIME NOT NULL DEFAULT '00:00:00',
    penalties INTEGER NOT NULL CHECK (penalties >= 0) DEFAULT 0,
    corners INTEGER NOT NULL CHECK (corners >= 0) DEFAULT 0,
    PRIMARY KEY (player_id, game_id)
);

CREATE TABLE IF NOT EXISTS GameEvents (
    event_id SERIAL NOT NULL PRIMARY KEY,
    game_id INTEGER NOT NULL REFERENCES Games(game_id) ON DELETE CASCADE,
    player_id INTEGER NOT NULL REFERENCES Players(player_id),
    moment INTEGER NOT NULL,
    event_type VARCHAR(255) NOT NULL CHECK (UPPER(event_type) IN ('ΓΚΟΛ', 'ΑΚΥΡΩΜΕΝΟ ΓΚΟΛ', 'ΚΟΚΚΙΝΗ ΚΑΡΤΑ', 'ΚΙΤΡΙΝΗ ΚΑΡΤΑ', 'ΠΕΝΑΛΤΙ', 'ΚΟΡΝΕΡ')) --Χρήση check για την αποδοχή συγκεκριμένων συμβάντων του αγώνα (όπως περιγράφονται στην εκφώνηση)
);

CREATE TABLE IF NOT EXISTS HasPlayed (
    player_id INTEGER NOT NULL REFERENCES Players(player_id) ON DELETE CASCADE,
    team_id INTEGER NOT NULL REFERENCES Teams(team_id) ON DELETE CASCADE,
    in_transfer_date DATE NOT NULL,
    out_transfer_date DATE,
    PRIMARY KEY (player_id, team_id)
);

CREATE TABLE IF NOT EXISTS HasCoached (
    coach_id INTEGER NOT NULL REFERENCES Coaches(coach_id) ON DELETE CASCADE,
    team_id INTEGER NOT NULL REFERENCES Teams(team_id) ON DELETE CASCADE,
    in_transfer_date DATE NOT NULL,
    out_transfer_date DATE,
    PRIMARY KEY (coach_id, team_id)
);

--Έλεγχος, μέσω function και trigger, για κάθε ομάδα να υπάρχει διάστημα 10 ημερών μεταξύ των αγώνων της
CREATE OR REPLACE FUNCTION check_duration_between_games() 
RETURNS TRIGGER
AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM Games
        WHERE (home_team_id = NEW.home_team_id OR away_team_id = NEW.home_team_id) AND games_date >= (NEW.games_date - INTERVAL '10 days')
    ) THEN
        RAISE EXCEPTION 'The team must have each game at least 10 days after the previous one.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enforce_duration_between_games
BEFORE INSERT ON Games
FOR EACH ROW
EXECUTE FUNCTION check_duration_between_games();
