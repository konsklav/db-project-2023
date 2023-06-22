-- a)
SELECT T.teams_name, DISTINCT CONCAT(P.players_name, ' ', P.players_surname) AS coach
FROM Games G 
    JOIN Teams T ON (G.home_team_id = T.team_id OR G.away_team_id = T.team_id) 
    JOIN HasCoached HC ON HC.in_transfer_date <= G.games_date AND (HC.out_transfer_date >= G.games_date OR HC.out_transfer_date IS NULL) 
    JOIN Coaches C ON C.coach_id = HC.coach_id 
    JOIN Players P ON P.player_id = C.player_id
WHERE Games.game_id = ?;

-- b)
SELECT event_type, moment, CONCAT(players_name, ' ', players_surname) AS player 
FROM GameEvents JOIN Players ON Players.player_id = GameEvents.player_id
WHERE Games.game_id = ? AND event_type IN ('ΠΕΝΑΛΤΙ', 'ΓΚΟΛ');

-- c)
SELECT SUM(PGS.goals) AS number_of_goals, 
    SUM(PGS.penalties) AS number_of_penalties, 
    SUM(PGS.red_cards) AS number_of_red_cards,
    SUM(PGS.yellow_cards) AS number_of_yellow_cards,
    SUM(PGS.active_time::interval) AS active_time,
    (
        SELECT P.position
        FROM Players P
        WHERE P.player_id = PGS.player_id
    ) AS position
FROM Games G 
    JOIN PlayerGameStatistics PGS ON PGS.game_id = G.game_id
WHERE G.games_date >= ? 
    AND G.games_date <= ? 
    AND PGS.player_id = ?;

-- d)