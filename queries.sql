-- a)
SELECT T.teams_name, CONCAT(P.players_name, ' ', P.players_surname) AS coach
FROM Games G 
    JOIN Teams T ON G.away_team_id = T.team_id --ή G.home_team_id = T.team_id
    JOIN HasCoached HC ON HC.team_id = T.team_id AND (HC.in_transfer_date <= G.games_date) AND (HC.out_transfer_date >= G.games_date OR HC.out_transfer_date IS NULL)
    LEFT JOIN Coaches C ON C.coach_id = HC.coach_id 
    JOIN Players P ON P.player_id = C.player_id
WHERE G.game_id = 1;

-- b)
SELECT GE.event_type, GE.moment, CONCAT(P.players_name, ' ', P.players_surname) AS player, T.teams_name
FROM GameEvents GE
    JOIN Players P ON P.player_id = GE.player_id
    JOIN HasPlayed HP ON HP.player_id = P.player_id
    JOIN Teams T ON T.team_id = HP.team_id
WHERE GE.game_id = 1
    AND GE.event_type IN ('ΠΕΝΑΛΤΙ', 'ΓΚΟΛ')
    AND (HP.in_transfer_date <= (SELECT games_date FROM Games WHERE game_id = 1)
    AND (HP.out_transfer_date IS NULL OR HP.out_transfer_date > (SELECT games_date FROM Games WHERE game_id = 1)));

-- c)
SELECT
    CONCAT(P.players_name, ' ', P.players_surname) AS player,
    SUM(PGS.goals) AS number_of_goals,
    SUM(PGS.penalties) AS number_of_penalties,
    SUM(PGS.red_cards) AS number_of_red_cards,
    SUM(PGS.yellow_cards) AS number_of_yellow_cards,
    SUM(PGS.active_time::interval) AS active_time,
    P.position
FROM Games G
    JOIN PlayerGameStatistics PGS ON PGS.game_id = G.game_id
    JOIN Players P ON P.player_id = PGS.player_id
WHERE G.games_date >= '2022-09-01' 
    AND G.games_date <= '2023-06-30' 
    AND PGS.player_id = 14
GROUP BY CONCAT(P.players_name, ' ', P.players_surname), P.position;

-- d)
SELECT T.teams_name, 
    COUNT(*) AS total_games, 
    SUM(CASE WHEN home_team_id = T.team_id THEN 1 ELSE 0 END) AS home_games, 
    SUM(CASE WHEN away_team_id = T.team_id THEN 1 ELSE 0 END) AS away_games, 
    (T.home_losses + T.away_losses) AS losses, 
    (T.home_wins + T.away_wins) AS wins, 
    (T.home_draws + T.away_draws) AS draws, 
    T.home_wins, 
    T.away_wins, 
    T.home_losses, 
    T.away_losses, 
    T.home_draws, 
    T.away_draws
FROM Teams T JOIN Games G ON T.team_id IN (G.home_team_id, G.away_team_id)
WHERE T.teams_name = 'Barcelona' AND G.games_date BETWEEN ('2022-09-01' AND '2023-06-30') 
GROUP BY T.team_id, T.home_losses, T.away_losses, T.home_wins, T.away_wins, T.home_draws, T.away_draws;
