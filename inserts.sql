-- Inserting 10 teams
-- Inserting team 1
INSERT INTO Teams (teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws)
VALUES ('Barcelona', 'Camp Nou', 'History of Barcelona', 2, 1, 0, 1, 0, 0);

-- Inserting team 2
INSERT INTO Teams (teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws)
VALUES ('Real Madrid', 'Santiago Bernabeu', 'History of Real Madrid', 1, 1, 1, 1, 0, 0);

-- Inserting team 3
INSERT INTO Teams (teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws)
VALUES ('Manchester United', 'Old Trafford', 'History of Manchester United', 1, 0, 1, 2, 0, 0);

-- Inserting team 4
INSERT INTO Teams (teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws)
VALUES ('Bayern Munich', 'Allianz Arena', 'History of Bayern Munich', 1, 2, 1, 0, 0, 0);

-- Inserting team 5
INSERT INTO Teams (teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws)
VALUES ('Juventus', 'Allianz Stadium', 'History of Juventus', 0, 1, 2, 1, 0, 0);

-- Inserting team 6
INSERT INTO Teams (teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws)
VALUES ('Liverpool', 'Anfield', 'History of Liverpool', 1, 1, 1, 1, 0, 0);

-- Inserting team 7
INSERT INTO Teams (teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws)
VALUES ('Paris Saint-Germain', 'Parc des Princes', 'History of Paris Saint-Germain', 0, 1, 2, 1, 0, 0);

-- Inserting team 8
INSERT INTO Teams (teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws)
VALUES ('Chelsea', 'Stamford Bridge', 'History of Chelsea', 2, 2, 0, 0, 0, 0);

-- Inserting team 9
INSERT INTO Teams (teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws)
VALUES ('Arsenal', 'Emirates Stadium', 'History of Arsenal', 2, 1, 0, 1, 0, 0);

-- Inserting team 10
INSERT INTO Teams (teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws)
VALUES ('AC Milan', 'San Siro', 'History of AC Milan', 0, 0, 2, 2, 0, 0);


-- Inserting 110 players (11 for each team, based on soccer positions)
-- Team 1 (Barcelona)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Lionel', 'Messi', 1, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Marc-André', 'ter Stegen', 1, 'Goalkeeper');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Gerard', 'Piqué', 1, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Jordi', 'Alba', 1, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Sergio', 'Busquets', 1, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Frenkie', 'de Jong', 1, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Pedri', '', 1, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Sergiño', 'Dest', 1, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Antoine', 'Griezmann', 1, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Ronald', 'Araújo', 1, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Sergi', 'Roberto', 1, 'Midfielder');

-- Team 2 (Real Madrid)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Karim', 'Benzema', 2, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Thibaut', 'Courtois', 2, 'Goalkeeper');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Raphael', 'Varane', 2, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Marcelo', '', 2, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Luka', 'Modric', 2, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Toni', 'Kroos', 2, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Eden', 'Hazard', 2, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Dani', 'Carvajal', 2, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Casemiro', '', 2, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Ferland', 'Mendy', 2, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Federico', 'Valverde', 2, 'Midfielder');

-- Team 3 (Manchester United)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Cristiano', 'Ronaldo', 3, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Bruno', 'Fernandes', 3, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Paul', 'Pogba', 3, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Marcus', 'Rashford', 3, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Harry', 'Maguire', 3, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Luke', 'Shaw', 3, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Aaron', 'Wan-Bissaka', 3, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Scott', 'McTominay', 3, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Fred', 'Rodrigues', 3, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Victor', 'Lindelof', 3, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Dean', 'Henderson', 3, 'Goalkeeper');

-- Team 4 (Bayern Munich)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Robert', 'Lewandowski', 4, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Thomas', 'Mueller', 4, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Manuel', 'Neuer', 4, 'Goalkeeper');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('David', 'Alaba', 4, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Joshua', 'Kimmich', 4, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Leon', 'Goretzka', 4, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Niklas', 'Sule', 4, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Alphonso', 'Davies', 4, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Kingsley', 'Coman', 4, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Leroy', 'Sane', 4, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Corentin', 'Tolisso', 4, 'Midfielder');

-- Team 5 (Juventus)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Cristiano', 'Ronaldo', 5, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Giorgio', 'Chiellini', 5, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Leonardo', 'Bonucci', 5, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Federico', 'Chiesa', 5, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Arthur', 'Melocni', 5, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Juan', 'Cuadrado', 5, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Paulo', 'Dybala', 5, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Aaron', 'Ramsey', 5, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Weston', 'McKennie', 5, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Dejan', 'Kulusevski', 5, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Wojciech', 'Szczesny', 5, 'Goalkeeper');

-- Team 6 (Liverpool)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Mohamed', 'Salah', 6, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Sadio', 'Mane', 6, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Virgil', 'van Dijk', 6, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Trent', 'Alexander-Arnold', 6, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Andrew', 'Robertson', 6, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Jordan', 'Henderson', 6, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Fabinho', 'Tavares', 6, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Diogo', 'Jota', 6, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Joel', 'Matip', 6, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Thiago', 'Alcantara', 6, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Alisson', 'Becker', 6, 'Goalkeeper');

-- Team 7 (Paris Saint-Germain)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Kylian', 'Mbappe', 7, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Neymar', 'Jr', 7, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Angel', 'Di Maria', 7, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Marco', 'Verratti', 7, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Presnel', 'Kimpembe', 7, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Marquinhos', '', 7, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Leandro', 'Paredes', 7, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Keylor', 'Navas', 7, 'Goalkeeper');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Achraf', 'Hakimi', 7, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Mauro', 'Icardi', 7, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Georginio', 'Wijnaldum', 7, 'Midfielder');

-- Team 8 (Chelsea)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Golo', 'Kante', 8, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Mason', 'Mount', 8, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Timo', 'Werner', 8, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Cesar', 'Azpilicueta', 8, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Kai', 'Havertz', 8, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Ben', 'Chilwell', 8, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Jorginho', '', 8, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Thiago', 'Silva', 8, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Reece', 'James', 8, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Edouard', 'Mendy', 8, 'Goalkeeper');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Hakim', 'Ziyech', 8, 'Midfielder');

-- Team 9 (Arsenal)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Pierre-Emerick', 'Aubameyang', 9, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Bukayo', 'Saka', 9, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Thomas', 'Partey', 9, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Gabriel', 'Magalhaes', 9, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Emile', 'Smith Rowe', 9, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Kieran', 'Tierney', 9, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Nicolas', 'Pepe', 9, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Bernd', 'Leno', 9, 'Goalkeeper');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Hector', 'Bellerin', 9, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Granit', 'Xhaka', 9, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Rob', 'Holding', 9, 'Defender');

-- Team 10 (AC Milan)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Gianluigi', 'Donnarumma', 10, 'Goalkeeper');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Theo', 'Hernandez', 10, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Franck', 'Kessie', 10, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Simon', 'Kjaer', 10, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Ante', 'Rebic', 10, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Ismael', 'Bennacer', 10, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Rafael', 'Leao', 10, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Alessio', 'Romagnoli', 10, 'Defender');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Sandro', 'Tonali', 10, 'Midfielder');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Zlatan', 'Ibrahimovic', 10, 'Forward');

INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Davide', 'Calabria', 10, 'Defender');

--Players to be used as coaches
-- Team 1 (Real Madrid)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Luis', 'Garcia', 1, 'Forward');

-- Team 2 (FC Barcelona)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Marc', 'Lopez', 2, 'Midfielder');

-- Team 3 (Manchester United)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Ryan', 'Wilson', 3, 'Defender');

-- Team 4 (Bayern Munich)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Julian', 'Muller', 4, 'Goalkeeper');

-- Team 5 (Juventus)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Matteo', 'Rossi', 5, 'Midfielder');

-- Team 6 (Liverpool)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Adam', 'Johnson', 6, 'Defender');

-- Team 7 (Paris Saint-Germain)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Antoine', 'Dubois', 7, 'Forward');

-- Team 8 (Chelsea)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Oliver', 'Baker', 8, 'Midfielder');

-- Team 9 (Arsenal)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Samuel', 'Wright', 9, 'Defender');

-- Team 10 (AC Milan)
INSERT INTO Players (players_name, players_surname, team_id, position)
VALUES ('Leonardo', 'Ricci', 10, 'Forward');

-- Coaches
-- Team 1 (Real Madrid)
INSERT INTO Coaches (player_id, coaching_role)
VALUES (111, 'Head Coach');

-- Team 2 (FC Barcelona)
INSERT INTO Coaches (player_id, coaching_role)
VALUES (112, 'Head Coach');

-- Team 3 (Manchester United)
INSERT INTO Coaches (player_id, coaching_role)
VALUES (113, 'Head Coach');

-- Team 4 (Bayern Munich)
INSERT INTO Coaches (player_id, coaching_role)
VALUES (114, 'Head Coach');

-- Team 5 (Juventus)
INSERT INTO Coaches (player_id, coaching_role)
VALUES (115, 'Head Coach');

-- Team 6 (Liverpool)
INSERT INTO Coaches (player_id, coaching_role)
VALUES (116, 'Head Coach');

-- Team 7 (Paris Saint-Germain)
INSERT INTO Coaches (player_id, coaching_role)
VALUES (117, 'Head Coach');

-- Team 8 (Chelsea)
INSERT INTO Coaches (player_id, coaching_role)
VALUES (118, 'Head Coach');

-- Team 9 (Arsenal)
INSERT INTO Coaches (player_id, coaching_role)
VALUES (119, 'Head Coach');

-- Team 10 (AC Milan)
INSERT INTO Coaches (player_id, coaching_role)
VALUES (120, 'Head Coach');

-- HasCoached
-- Team 1 (Real Madrid)
INSERT INTO HasCoached (coach_id, team_id, in_transfer_date, out_transfer_date)
VALUES (1, 1, '2021-05-10', NULL);

-- Team 2 (FC Barcelona)
INSERT INTO HasCoached (coach_id, team_id, in_transfer_date, out_transfer_date)
VALUES (2, 2, '2021-06-15', NULL);

-- Team 3 (Manchester United)
INSERT INTO HasCoached (coach_id, team_id, in_transfer_date, out_transfer_date)
VALUES (3, 3, '2021-07-02', NULL);

-- Team 4 (Bayern Munich)
INSERT INTO HasCoached (coach_id, team_id, in_transfer_date, out_transfer_date)
VALUES (4, 4, '2021-05-18', NULL);

-- Team 5 (Juventus)
INSERT INTO HasCoached (coach_id, team_id, in_transfer_date, out_transfer_date)
VALUES (5, 5, '2021-06-27', NULL);

-- Team 6 (Liverpool)
INSERT INTO HasCoached (coach_id, team_id, in_transfer_date, out_transfer_date)
VALUES (6, 6, '2021-07-12', NULL);

-- Team 7 (Paris Saint-Germain)
INSERT INTO HasCoached (coach_id, team_id, in_transfer_date, out_transfer_date)
VALUES (7, 7, '2021-05-05', NULL);

-- Team 8 (Chelsea)
INSERT INTO HasCoached (coach_id, team_id, in_transfer_date, out_transfer_date)
VALUES (8, 8, '2021-06-20', NULL);

-- Team 9 (Arsenal)
INSERT INTO HasCoached (coach_id, team_id, in_transfer_date, out_transfer_date)
VALUES (9, 9, '2021-07-28', NULL);

-- Team 10 (AC Milan)
INSERT INTO HasCoached (coach_id, team_id, in_transfer_date, out_transfer_date)
VALUES (10, 10, '2021-05-14', NULL);

-- HasPlayed
-- Player 1 (Team 1 - Real Madrid)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (1, 1, '2020-05-10', NULL);

-- Player 2 (Team 1 - Real Madrid)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (2, 1, '2020-06-15', NULL);

-- Player 3 (Team 1 - Real Madrid)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (3, 1, '2020-07-05', NULL);

-- Player 4 (Team 1 - Real Madrid)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (4, 1, '2020-08-10', NULL);

-- Player 5 (Team 1 - Real Madrid)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (5, 1, '2020-05-20', NULL);

-- Player 6 (Team 1 - Real Madrid)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (6, 1, '2020-06-25', NULL);

-- Player 7 (Team 1 - Real Madrid)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (7, 1, '2020-07-15', NULL);

-- Player 8 (Team 1 - Real Madrid)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (8, 1, '2020-08-01', NULL);

-- Player 9 (Team 1 - Real Madrid)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (9, 1, '2020-05-05', NULL);

-- Player 10 (Team 1 - Real Madrid)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (10, 1, '2020-06-10', NULL);

-- Player 11 (Team 1 - Real Madrid)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (11, 1, '2020-07-20', NULL);

-- Player 12 (Team 2 - Barcelona)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (12, 2, '2020-05-10', NULL);

-- Player 13 (Team 2 - Barcelona)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (13, 2, '2020-06-15', NULL);

-- Player 14 (Team 2 - Barcelona)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (14, 2, '2020-07-05', NULL);

-- Player 15 (Team 2 - Barcelona)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (15, 2, '2020-08-10', NULL);

-- Player 16 (Team 2 - Barcelona)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (16, 2, '2020-05-20', NULL);

-- Player 17 (Team 2 - Barcelona)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (17, 2, '2020-06-25', NULL);

-- Player 18 (Team 2 - Barcelona)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (18, 2, '2020-07-15', NULL);

-- Player 19 (Team 2 - Barcelona)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (19, 2, '2020-08-01', NULL);

-- Player 20 (Team 2 - Barcelona)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (20, 2, '2020-05-05', NULL);

-- Player 21 (Team 2 - Barcelona)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (21, 2, '2020-06-10', NULL);

-- Player 22 (Team 2 - Barcelona)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (22, 2, '2020-07-20', NULL);

-- Player 23 (Team 3 - Manchester United)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (23, 3, '2020-05-15', NULL);

-- Player 24 (Team 3 - Manchester United)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (24, 3, '2020-06-20', NULL);

-- Player 25 (Team 3 - Manchester United)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (25, 3, '2020-07-10', NULL);

-- Player 26 (Team 3 - Manchester United)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (26, 3, '2020-08-15', NULL);

-- Player 27 (Team 3 - Manchester United)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (27, 3, '2020-05-25', NULL);

-- Player 28 (Team 3 - Manchester United)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (28, 3, '2020-06-30', NULL);

-- Player 29 (Team 3 - Manchester United)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (29, 3, '2020-07-20', NULL);

-- Player 30 (Team 3 - Manchester United)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (30, 3, '2020-08-05', NULL);

-- Player 31 (Team 3 - Manchester United)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (31, 3, '2020-05-01', NULL);

-- Player 32 (Team 3 - Manchester United)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (32, 3, '2020-06-05', NULL);

-- Player 33 (Team 3 - Manchester United)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (33, 3, '2020-07-15', NULL);

-- Player 34 (Team 4 - Bayern Munich)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (34, 4, '2020-08-01', NULL);

-- Player 35 (Team 4 - Bayern Munich)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (35, 4, '2020-05-10', NULL);

-- Player 36 (Team 4 - Bayern Munich)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (36, 4, '2020-06-15', NULL);

-- Player 37 (Team 4 - Bayern Munich)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (37, 4, '2020-07-05', NULL);

-- Player 38 (Team 4 - Bayern Munich)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (38, 4, '2020-08-10', NULL);

-- Player 39 (Team 4 - Bayern Munich)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (39, 4, '2020-05-20', NULL);

-- Player 40 (Team 4 - Bayern Munich)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (40, 4, '2020-06-25', NULL);

-- Player 41 (Team 4 - Bayern Munich)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (41, 4, '2020-07-15', NULL);

-- Player 42 (Team 4 - Bayern Munich)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (42, 4, '2020-08-01', NULL);

-- Player 43 (Team 4 - Bayern Munich)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (43, 4, '2020-05-05', NULL);

-- Player 44 (Team 4 - Bayern Munich)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (44, 4, '2020-06-10', NULL);

-- Player 45 (Team 5 - Juventus)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (45, 5, '2020-07-20', NULL);

-- Player 46 (Team 5 - Juventus)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (46, 5, '2020-05-15', NULL);

-- Player 47 (Team 5 - Juventus)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (47, 5, '2020-06-20', NULL);

-- Player 48 (Team 5 - Juventus)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (48, 5, '2020-07-10', NULL);

-- Player 49 (Team 5 - Juventus)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (49, 5, '2020-08-15', NULL);

-- Player 50 (Team 5 - Juventus)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (50, 5, '2020-05-25', NULL);

-- Player 51 (Team 5 - Juventus)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (51, 5, '2020-06-30', NULL);

-- Player 52 (Team 5 - Juventus)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (52, 5, '2020-07-20', NULL);

-- Player 53 (Team 5 - Juventus)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (53, 5, '2020-08-05', NULL);

-- Player 54 (Team 5 - Juventus)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (54, 5, '2020-05-01', NULL);

-- Player 55 (Team 5 - Juventus)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (55, 5, '2020-06-05', NULL);

-- Player 56 (Team 6 - Liverpool)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (56, 6, '2020-07-10', NULL);

-- Player 57 (Team 6 - Liverpool)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (57, 6, '2020-08-15', NULL);

-- Player 58 (Team 6 - Liverpool)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (58, 6, '2020-05-25', NULL);

-- Player 59 (Team 6 - Liverpool)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (59, 6, '2020-06-30', NULL);

-- Player 60 (Team 6 - Liverpool)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (60, 6, '2020-07-20', NULL);

-- Player 61 (Team 6 - Liverpool)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (61, 6, '2020-08-05', NULL);

-- Player 62 (Team 6 - Liverpool)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (62, 6, '2020-05-01', NULL);

-- Player 63 (Team 6 - Liverpool)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (63, 6, '2020-06-05', NULL);

-- Player 64 (Team 6 - Liverpool)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (64, 6, '2020-05-10', NULL);

-- Player 65 (Team 6 - Liverpool)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (65, 6, '2020-06-15', NULL);

-- Player 66 (Team 6 - Liverpool)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (66, 6, '2020-07-05', NULL);

-- Player 67 (Team 7 - Paris Saint-Germain)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (67, 7, '2020-08-10', NULL);

-- Player 68 (Team 7 - Paris Saint-Germain)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (68, 7, '2020-05-20', NULL);

-- Player 69 (Team 7 - Paris Saint-Germain)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (69, 7, '2020-06-25', NULL);

-- Player 70 (Team 7 - Paris Saint-Germain)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (70, 7, '2020-07-15', NULL);

-- Player 71 (Team 7 - Paris Saint-Germain)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (71, 7, '2020-08-01', NULL);

-- Player 72 (Team 7 - Paris Saint-Germain)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (72, 7, '2020-05-05', NULL);

-- Player 73 (Team 7 - Paris Saint-Germain)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (73, 7, '2020-06-10', NULL);

-- Player 74 (Team 7 - Paris Saint-Germain)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (74, 7, '2020-07-01', NULL);

-- Player 75 (Team 7 - Paris Saint-Germain)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (75, 7, '2020-08-10', NULL);

-- Player 76 (Team 7 - Paris Saint-Germain)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (76, 7, '2020-05-15', NULL);

-- Player 77 (Team 7 - Paris Saint-Germain)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (77, 7, '2020-06-20', NULL);

-- Player 78 (Team 8 - Chelsea)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (78, 8, '2020-07-05', NULL);

-- Player 79 (Team 8 - Chelsea)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (79, 8, '2020-08-15', NULL);

-- Player 80 (Team 8 - Chelsea)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (80, 8, '2020-05-25', NULL);

-- Player 81 (Team 8 - Chelsea)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (81, 8, '2020-06-30', NULL);

-- Player 82 (Team 8 - Chelsea)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (82, 8, '2020-07-20', NULL);

-- Player 83 (Team 8 - Chelsea)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (83, 8, '2020-08-05', NULL);

-- Player 84 (Team 8 - Chelsea)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (84, 8, '2020-05-01', NULL);

-- Player 85 (Team 8 - Chelsea)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (85, 8, '2020-06-05', NULL);

-- Player 86 (Team 8 - Chelsea)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (86, 8, '2020-07-10', NULL);

-- Player 87 (Team 8 - Chelsea)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (87, 8, '2020-08-15', NULL);

-- Player 88 (Team 8 - Chelsea)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (88, 8, '2020-05-10', NULL);

-- Player 89 (Team 9 - Arsenal)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (89, 9, '2020-06-15', NULL);

-- Player 90 (Team 9 - Arsenal)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (90, 9, '2020-07-01', NULL);

-- Player 91 (Team 9 - Arsenal)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (91, 9, '2020-08-10', NULL);

-- Player 92 (Team 9 - Arsenal)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (92, 9, '2020-05-15', NULL);

-- Player 93 (Team 9 - Arsenal)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (93, 9, '2020-06-20', NULL);

-- Player 94 (Team 9 - Arsenal)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (94, 9, '2020-07-05', NULL);

-- Player 95 (Team 9 - Arsenal)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (95, 9, '2020-08-15', NULL);

-- Player 96 (Team 9 - Arsenal)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (96, 9, '2020-05-25', NULL);

-- Player 97 (Team 9 - Arsenal)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (97, 9, '2020-06-30', NULL);

-- Player 98 (Team 9 - Arsenal)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (98, 9, '2020-07-20', NULL);

-- Player 99 (Team 9 - Arsenal)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (99, 9, '2020-08-05', NULL);

-- Player 100 (Team 10 - AC Milan)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (100, 10, '2020-05-01', NULL);

-- Player 101 (Team 10 - AC Milan)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (101, 10, '2020-06-05', NULL);

-- Player 102 (Team 10 - AC Milan)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (102, 10, '2020-07-10', NULL);

-- Player 103 (Team 10 - AC Milan)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (103, 10, '2020-08-15', NULL);

-- Player 104 (Team 10 - AC Milan)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (104, 10, '2020-05-10', NULL);

-- Player 105 (Team 10 - AC Milan)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (105, 10, '2020-06-15', NULL);

-- Player 106 (Team 10 - AC Milan)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (106, 10, '2020-07-01', NULL);

-- Player 107 (Team 10 - AC Milan)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (107, 10, '2020-08-10', NULL);

-- Player 108 (Team 10 - AC Milan)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (108, 10, '2020-05-15', NULL);

-- Player 109 (Team 10 - AC Milan)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (109, 10, '2020-06-20', NULL);

-- Player 110 (Team 10 - AC Milan)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (110, 10, '2020-07-05', NULL);

-- Player 111 (Team 1 - Barcelona)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (111, 1, '1999-05-18', '2005-05-18');

-- Player 112 (Team 2 - Real Madrid)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (112, 2, '1994-08-10', '2001-08-10');

-- Player 113 (Team 3 - Manchester United)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (113, 3, '2003-02-27', '2010-02-27');

-- Player 114 (Team 4 - Bayern Munich)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (114, 4, '1997-11-21', '2004-11-21');

-- Player 115 (Team 5 - Juventus)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (115, 5, '1992-12-03', '1999-12-03');

-- Player 116 (Team 6 - Liverpool)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (116, 6, '1998-07-06', '2005-07-06');

-- Player 117 (Team 7 - Paris Saint-Germain)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (117, 7, '1995-04-14', '2002-04-14');

-- Player 118 (Team 8 - Chelsea)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (118, 8, '1996-09-29', '2003-09-29');

-- Player 119 (Team 9 - Arsenal)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (119, 9, '1993-06-08', '2000-06-08');

-- Player 120 (Team 10 - AC Milan)
INSERT INTO HasPlayed (player_id, team_id, in_transfer_date, out_transfer_date)
VALUES (120, 10, '1999-01-17', '2006-01-17');

-- Games
INSERT INTO Games (home_team_id, away_team_id, home_teams_score, away_teams_score, games_date, duration)
VALUES
  (1, 2, 3, 1, '2022-09-01', '01:32:00'),
  (2, 3, 4, 0, '2022-09-13', '01:38:00'),
  (3, 4, 2, 5, '2022-09-25', '01:40:00'),
  (4, 5, 1, 2, '2022-10-07', '01:35:00'),
  (5, 6, 0, 4, '2022-10-19', '01:37:00'),
  (6, 7, 5, 2, '2022-10-31', '01:39:00'),
  (7, 8, 1, 3, '2022-11-12', '01:36:00'),
  (8, 9, 2, 0, '2022-11-24', '01:40:00'),
  (9, 10, 3, 2, '2022-12-06', '01:33:00'),
  (10, 1, 0, 1, '2022-12-18', '01:38:00'),
  (1, 3, 5, 1, '2022-12-30', '01:40:00'),
  (2, 4, 1, 3, '2023-01-11', '01:35:00'),
  (3, 5, 4, 2, '2023-01-23', '01:32:00'),
  (4, 6, 3, 1, '2023-02-04', '01:39:00'),
  (5, 7, 2, 3, '2023-02-16', '01:36:00'),
  (6, 8, 1, 4, '2023-02-28', '01:40:00'),
  (7, 9, 0, 2, '2023-03-12', '01:33:00'),
  (8, 10, 5, 3, '2023-03-24', '01:38:00'),
  (9, 1, 4, 1, '2023-04-05', '01:35:00'),
  (10, 2, 1, 2, '2023-04-17', '01:37:00');

-- GameEvents
INSERT INTO GameEvents (game_id, player_id, moment, event_type)
VALUES
  (1, 1, 12, 'ΓΚΟΛ'),
  (1, 2, 23, 'ΓΚΟΛ'),
  (1, 1, 45, 'ΓΚΟΛ'),
  (1, 14, 18, 'ΓΚΟΛ'),
  (2, 13, 33, 'ΓΚΟΛ'),
  (2, 13, 59, 'ΓΚΟΛ'),
  (2, 13, 10, 'ΓΚΟΛ'),
  (2, 15, 36, 'ΓΚΟΛ');

-- PlayerGameStatistics
INSERT INTO PlayerGameStatistics (player_id, team_id, game_id, red_cards, yellow_cards, goals, canceled_goals, active_time, penalties, corners)
VALUES 
  (1, 1, 1, 0, 0, 2, 1, '01:32:00', 0, 5),
  (2, 1, 1, 1, 0, 1, 2, '01:32:00', 0, 5),
  (14, 2, 1, 0, 1, 2, 1, '01:32:00', 0, 5),
  (13, 1, 2, 0, 1, 3, 0, '01:38:00', 0, 5),
  (15, 1, 2, 0, 0, 1, 1, '01:38:00', 0, 5);
