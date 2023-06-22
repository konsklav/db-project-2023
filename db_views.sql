-- Πρόγραμμα Αγώνων
CREATE VIEW games_program AS
SELECT
    G.games_date,
    T1.home_field_name AS stadium,
    G.duration,
    T1.teams_name AS home_team,
    T2.teams_name AS away_team,
    G.home_teams_score AS home_score,
    G.away_teams_score AS away_score,
    ARRAY_AGG(DISTINCT CONCAT(P.players_name, ' ', P.players_surname)) FILTER (WHERE PGS.team_id = G.home_team_id AND P.player_id = PGS.player_id) AS home_players,
    ARRAY_AGG(DISTINCT P.position) FILTER (WHERE P.team_id = G.home_team_id) AS home_positions,
    ARRAY_AGG(PGS.active_time) FILTER (WHERE PGS.team_id = G.home_team_id) AS home_active_times,
    ARRAY_AGG(PGS.yellow_cards) FILTER (WHERE PGS.team_id = G.home_team_id) AS home_yellow_cards,
    ARRAY_AGG(PGS.red_cards) FILTER (WHERE PGS.team_id = G.home_team_id) AS home_red_cards,
    ARRAY_AGG(PGS.goals) FILTER (WHERE PGS.team_id = G.home_team_id) AS home_goals,
    ARRAY_AGG(GE.moment) FILTER (WHERE GE.team_id = G.home_team_id AND GE.event_type = 'ΓΚΟΛ') AS home_goal_moments,
    ARRAY_AGG(DISTINCT CONCAT(P.players_name, ' ', P.players_surname)) FILTER (WHERE PGS.team_id = G.away_team_id AND P.player_id = PGS.player_id) AS away_players,
    ARRAY_AGG(DISTINCT P.position) FILTER (WHERE P.team_id = G.away_team_id) AS away_positions,
    ARRAY_AGG(PGS.active_time) FILTER (WHERE PGS.team_id = G.away_team_id) AS away_active_times,
    ARRAY_AGG(PGS.yellow_cards) FILTER (WHERE PGS.team_id = G.away_team_id) AS away_yellow_cards,
    ARRAY_AGG(PGS.red_cards) FILTER (WHERE PGS.team_id = G.away_team_id) AS away_red_cards,
    ARRAY_AGG(PGS.goals) FILTER (WHERE PGS.team_id = G.away_team_id) AS away_goals,
    ARRAY_AGG(GE.moment) FILTER (WHERE GE.team_id = G.away_team_id AND GE.event_type = 'ΓΚΟΛ') AS away_goal_moments
FROM
    Games G
    JOIN Teams T1 ON G.home_team_id = T1.team_id
    JOIN Teams T2 ON G.away_team_id = T2.team_id
    JOIN PlayerGameStatistics PGS ON G.game_id = PGS.game_id
    JOIN Players P ON PGS.player_id = P.player_id
    JOIN GameEvents GE ON G.game_id = GE.game_id AND PGS.player_id = GE.player_id
WHERE
    G.games_date = '2023-05-30'
GROUP BY
    G.game_id, G.games_date, G.duration, T1.teams_name, T2.teams_name, G.home_teams_score, G.away_teams_score; -- Μπορεί να χρειάζεται να βγει το duration


-- CREATE VIEW games_program AS
-- SELECT
--     G.games_date,
--     T1.home_field_name AS stadium,
--     G.duration,
--     T1.teams_name AS home_team,
--     T2.teams_name AS away_team,
--     G.home_teams_score AS home_score,
--     G.away_teams_score AS away_score,
--     ARRAY_AGG(DISTINCT CONCAT(P.players_name, ' ', P.players_surname)) FILTER (WHERE PGS.team_id = G.home_team_id) AS home_players,
--     ARRAY_AGG(DISTINCT P.position) FILTER (WHERE P.team_id = G.home_team_id) AS home_positions,
--     ARRAY_AGG(PGS.active_time) FILTER (WHERE PGS.team_id = G.home_team_id) AS home_active_times,
--     ARRAY_AGG(PGS.yellow_cards) FILTER (WHERE PGS.team_id = G.home_team_id) AS home_yellow_cards,
--     ARRAY_AGG(PGS.red_cards) FILTER (WHERE PGS.team_id = G.home_team_id) AS home_red_cards,
--     ARRAY_AGG(PGS.goals) FILTER (WHERE PGS.team_id = G.home_team_id) AS home_goals,
--     ARRAY_AGG(GE.moment) FILTER (WHERE GE.team_id = G.home_team_id AND GE.event_type = 'ΓΚΟΛ') AS home_goal_moments,
--     ARRAY_AGG(DISTINCT CONCAT(P2.players_name, ' ', P2.players_surname)) FILTER (WHERE PGS2.team_id = G.away_team_id) AS away_players,
--     ARRAY_AGG(DISTINCT P2.position) FILTER (WHERE P2.team_id = G.away_team_id) AS away_positions,
--     ARRAY_AGG(PGS2.active_time) FILTER (WHERE PGS2.team_id = G.away_team_id) AS away_active_times,
--     ARRAY_AGG(PGS2.yellow_cards) FILTER (WHERE PGS2.team_id = G.away_team_id) AS away_yellow_cards,
--     ARRAY_AGG(PGS2.red_cards) FILTER (WHERE PGS2.team_id = G.away_team_id) AS away_red_cards,
--     ARRAY_AGG(PGS2.goals) FILTER (WHERE PGS2.team_id = G.away_team_id) AS away_goals,
--     ARRAY_AGG(GE2.moment) FILTER (WHERE GE2.team_id = G.away_team_id AND GE2.event_type = 'ΓΚΟΛ') AS away_goal_moments
-- FROM
--     Games G
--     JOIN Teams T1 ON G.home_team_id = T1.team_id
--     JOIN Teams T2 ON G.away_team_id = T2.team_id
--     JOIN PlayerGameStatistics PGS ON G.game_id = PGS.game_id
--     JOIN Players P ON PGS.player_id = P.player_id
--     JOIN GameEvents GE ON G.game_id = GE.game_id AND PGS.player_id = GE.player_id
--     JOIN PlayerGameStatistics PGS2 ON G.game_id = PGS2.game_id
--     JOIN Players P2 ON PGS2.player_id = P2.player_id
--     JOIN GameEvents GE2 ON G.game_id = GE2.game_id AND PGS2.player_id = GE2.player_id
-- WHERE
--     G.games_date = '2023-05-30'
-- GROUP BY
--     G.game_id, G.games_date, G.duration, T1.teams_name, T2.teams_name, G.home_teams_score, G.away_teams_score;


-- Ετήσιο πρωτάθλημα αγώνων
CREATE VIEW season_program AS
SELECT
    G.games_date,
    T1.home_field_name AS stadium,
    G.duration,
    T1.teams_name AS home_team,
    T2.teams_name AS away_team,
    CONCAT(G.home_teams_score, ' - ', G.away_teams_score) AS score,
FROM
    Games G
    JOIN Teams T1 ON G.home_team_id = T1.team_id
    JOIN Teams T2 ON G.away_team_id = T2.team_id
WHERE
    G.games_date BETWEEN '2022-09-01' AND '2023-06-30'
GROUP BY
    G.game_id;