-- a)
SELECT Players.players_name AS CoachesName
FROM Players, Coaches, Teams, Games, HasCoached
WHERE Players.player_id = Coaches.player_id AND Coaches.coach_id = HasCoached.coach_id AND HasCoached.team_id = Games.home_team_id AND Games.date BETWEEN (HasCoached.in_transfer_date AND HasCoached.out_transfer_date) AND Games.game_id = 1; 