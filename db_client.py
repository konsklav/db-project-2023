import sys
import psycopg2

sys.stdout.reconfigure(encoding='utf-8')

sql_query_a = "SELECT T.teams_name, CONCAT(P.players_name, ' ', P.players_surname) AS coach " + \
              "FROM Games G " + \
                "JOIN Teams T ON G.away_team_id = T.team_id " + \
                "JOIN HasCoached HC ON HC.team_id = T.team_id AND (HC.in_transfer_date <= G.games_date) AND (HC.out_transfer_date >= G.games_date OR HC.out_transfer_date IS NULL) " + \
                "LEFT JOIN Coaches C ON C.coach_id = HC.coach_id " + \
                "JOIN Players P ON P.player_id = C.player_id " + \
              "WHERE G.game_id = %s;"

parameters_a = (1,)

sql_query_b = "SELECT event_type, moment, CONCAT(players_name, ' ', players_surname) AS player, T.teams_name " + \
              "FROM GameEvents GE " + \
                "JOIN Players P ON P.player_id = GE.player_id " + \
                "JOIN HasPlayed HP ON HP.player_id = P.player_id " + \
                "JOIN Teams T ON T.team_id = HP.team_id " + \
              "WHERE GE.game_id = %s " + \
                "AND event_type IN ('ΠΕΝΑΛΤΙ', 'ΓΚΟΛ') " + \
                "AND (HP.in_transfer_date <= (SELECT games_date FROM Games WHERE game_id = %s) " + \
                "AND (HP.out_transfer_date IS NULL OR HP.out_transfer_date > (SELECT games_date FROM Games WHERE game_id = %s)));"

parameters_b = (1, 1, 1,)

sql_query_c = "SELECT CONCAT(P.players_name, ' ', P.players_surname) AS player, SUM(PGS.goals) AS number_of_goals, SUM(PGS.penalties) AS number_of_penalties, SUM(PGS.red_cards) AS number_of_red_cards, SUM(PGS.yellow_cards) AS number_of_yellow_cards, SUM(PGS.active_time::interval) AS active_time, P.position " + \
              "FROM Games G " + \
                "JOIN PlayerGameStatistics PGS ON PGS.game_id = G.game_id " + \
                "JOIN Players P ON P.player_id = PGS.player_id " + \
              "WHERE G.games_date >= %s " + \
                "AND G.games_date <= %s " + \
                "AND PGS.player_id = %s " + \
              "GROUP BY CONCAT(P.players_name, ' ', P.players_surname), P.position;"

parameters_c = ('2022-09-01', '2023-06-30', 14,)

sql_query_d = "SELECT T.teams_name, COUNT(*) AS total_games, SUM(CASE WHEN home_team_id = T.team_id THEN 1 ELSE 0 END) AS home_games, SUM(CASE WHEN away_team_id = T.team_id THEN 1 ELSE 0 END) AS away_games, (T.home_losses + T.away_losses) AS losses, (T.home_wins + T.away_wins) AS wins, (T.home_draws + T.away_draws) AS draws, T.home_wins, T.away_wins, T.home_losses, T.away_losses, T.home_draws, T.away_draws " + \
              "FROM Teams T JOIN Games G ON T.team_id IN (G.home_team_id, G.away_team_id) " + \
              "WHERE T.teams_name = %s AND G.games_date BETWEEN %s AND %s " + \
              "GROUP BY T.team_id, T.home_losses, T.away_losses, T.home_wins, T.away_wins, T.home_draws, T.away_draws;"

parameters_d = ('Barcelona', '2022-09-01', '2023-06-30',)

valid_options = ['a', 'b', 'c', 'd']

try:
    connection = psycopg2.connect(dbname = 'db_project_2023', host = 'localhost', port = '5432', user = 'postgres', password = 'p21xxx')

    cursor = connection.cursor()

    # option = input("Choose a query to execute (options: a, b, c, d): ")
    option = 'c'

    while option not in valid_options:
        option = input("Invalid option. Choose again (options: a, b, c, d): ")

    if option == 'a':
        cursor.execute(sql_query_a, parameters_a)

        result_set = cursor.fetchall()

        for row in result_set:
            print("Team =", row[0])
            print("Coach =", row[1])
    elif option == 'b':
        cursor.execute(sql_query_b, parameters_b)

        result_set = cursor.fetchall()

        for row in result_set:
            print("Event = ",row[0])
            print("Moment = ",row[1])
            print("Player = ",row[2])
            print("Team = ",row[3], '\n')
    elif option == 'c':
        cursor.execute(sql_query_c, parameters_c)

        result_set = cursor.fetchall()

        for row in result_set:
            print("Player = ",row[0])
            print("No. of goals = ",row[1])
            print("No. of penalties = ",row[2])
            print("No. of red cards = ",row[3])
            print("No. of yellow cards = ",row[4])
            print("Active time = ",row[5])
            print("Position = ",row[6])
    elif option == 'd':
        cursor.execute(sql_query_d, parameters_d)

        result_set = cursor.fetchall()

        for row in result_set:
            print("Team = ",row[0])
            print("Total games = ",row[1])
            print("Home games = ",row[2])
            print("Away games = ",row[3])
            print("Total losses = ",row[4])
            print("Total wins = ",row[5])
            print("Total draws = ",row[6])
            print("Home wins = ",row[7])
            print("Away wins = ",row[8])
            print("Home losses = ",row[9])
            print("Away losses = ",row[10])
            print("Home draws = ",row[11])
            print("Away draws = ",row[12])

except(Exception, psycopg2.Error) as error:
    print("Error while fetching data from PostgreSQL ", error)

finally:
    if cursor:
        cursor.close()
    if connection:
        connection.close()
