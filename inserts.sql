-- Inserting 10 teams
INSERT INTO Teams (teams_name, home_field_name, history_description)
VALUES ('Barcelona', 'Camp Nou', 'History of Barcelona');

INSERT INTO Teams (teams_name, home_field_name, history_description)
VALUES ('Real Madrid', 'Santiago Bernabeu', 'History of Real Madrid');

INSERT INTO Teams (teams_name, home_field_name, history_description)
VALUES ('Manchester United', 'Old Trafford', 'History of Manchester United');

INSERT INTO Teams (teams_name, home_field_name, history_description)
VALUES ('Bayern Munich', 'Allianz Arena', 'History of Bayern Munich');

INSERT INTO Teams (teams_name, home_field_name, history_description)
VALUES ('Juventus', 'Allianz Stadium', 'History of Juventus');

INSERT INTO Teams (teams_name, home_field_name, history_description)
VALUES ('Liverpool', 'Anfield', 'History of Liverpool');

INSERT INTO Teams (teams_name, home_field_name, history_description)
VALUES ('Paris Saint-Germain', 'Parc des Princes', 'History of Paris Saint-Germain');

INSERT INTO Teams (teams_name, home_field_name, history_description)
VALUES ('Chelsea', 'Stamford Bridge', 'History of Chelsea');

INSERT INTO Teams (teams_name, home_field_name, history_description)
VALUES ('Arsenal', 'Emirates Stadium', 'History of Arsenal');

INSERT INTO Teams (teams_name, home_field_name, history_description)
VALUES ('AC Milan', 'San Siro', 'History of AC Milan');


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

