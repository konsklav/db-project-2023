import psycopg2

sql_query_a = "SELECT T.teams_name, DISTINCT CONCAT(P.players_name, ' ', P.players_surname) AS coach " + \
              "FROM Games G " + \
                "JOIN Teams T ON (G.home_team_id = T.team_id OR G.away_team_id = T.team_id) " + \
                "JOIN HasCoached HC ON HC.in_transfer_date <= G.games_date AND (HC.out_transfer_date >= G.games_date OR HC.out_transfer_date IS NULL) " + \
                "JOIN Coaches C ON C.coach_id = HC.coach_id " + \
                "JOIN Players P ON P.player_id = C.player_id " + \
              "WHERE Games.game_id = %s;"

parameters_a = ("") # Να βάλουμε τις παραμέτρους αφού δω αν θα τις περάσω ως user input ή όχι

sql_query_b = "SELECT event_type, moment, CONCAT(players_name, ' ', players_surname) AS player " + \
              "FROM GameEvents JOIN Players ON Players.player_id = GameEvents.player_id " + \
              "WHERE Games.game_id = %s AND event_type IN ('ΠΕΝΑΛΤΙ', 'ΓΚΟΛ');"

parameters_b = ("") # Να βάλουμε τις παραμέτρους αφού δω αν θα τις περάσω ως user input ή όχι

sql_query_c = "SELECT SUM(PGS.goals) AS number_of_goals, SUM(PGS.penalties) AS number_of_penalties, SUM(PGS.red_cards) AS number_of_red_cards, SUM(PGS.yellow_cards) AS number_of_yellow_cards, SUM(PGS.active_time::interval) AS active_time, (SELECT P.position FROM Players P WHERE P.player_id = PGS.player_id) AS position " + \
              "FROM Games G JOIN PlayerGameStatistics PGS ON PGS.game_id = G.game_id " + \
              "WHERE G.games_date >= %s AND G.games_date <= %s AND PGS.player_id = %s;"

parameters_c = ("", "", "") # Να βάλουμε τις παραμέτρους αφού δω αν θα τις περάσω ως user input ή όχι

sql_query_d = "SELECT COUNT(*) AS total_games, SUM(CASE WHEN home_team_id = T.team_id THEN 1 ELSE 0 END) AS home_games, SUM(CASE WHEN away_team_id = T.team_id THEN 1 ELSE 0 END) AS away_games, (T.home_losses + T.away_losses) AS losses, (T.home_wins + T.away_wins) AS wins, (T.home_draws + T.away_draws) AS draws, T.home_wins, T.away_wins, T.home_losses, T.away_losses, T.home_draws, T.away_draws " + \
              "FROM Teams T JOIN Games G ON T.team_id IN (G.home_team_id, G.away_team_id) " + \
              "WHERE T.teams_name = %s AND G.games_date BETWEEN ('2022-09-01' AND '2023-06-30');"   #Να βάλουμε: %s στις ημερομηνίες

parameters_d = ("", "", "") # Να βάλουμε τις παραμέτρους αφού δω αν θα τις περάσω ως user input ή όχι

valid_options = ['a', 'b', 'c', 'd']

try:
    connection = psycopg2.connect(dbname = 'db_name', host = 'localhost', port = '5432', user = 'postgres', password = 'your_password')

    cursor = connection.cursor()

    option = input("Choose a query to execute (options: a, b, c, d): ")

    while option not in valid_options:
        option = input("Invalid option. Choose again (options: a, b, c, d): ")

    if option == 'a':
        cursor.execute(sql_query_a, parameters_a)

        result_set = cursor.fetchall()

        #Να τα φτιάξουμε ανάλογα με το τι επιστέφει το query
        for row in result_set:
            print("id = ", row[0])
            print("name = ", row[1])
            print("dept_name = ", row[2])
            print("salary = ", row[3], '\n')
    elif option == 'b':
        cursor.execute(sql_query_b, parameters_b)

        result_set = cursor.fetchall()

        #Να τα φτιάξουμε ανάλογα με το τι επιστέφει το query
        for row in result_set:
            print("id = ", row[0])
            print("name = ", row[1])
            print("dept_name = ", row[2])
            print("salary = ", row[3], '\n')
    elif option == 'c':
        cursor.execute(sql_query_c, parameters_c)

        result_set = cursor.fetchall()

        #Να τα φτιάξουμε ανάλογα με το τι επιστέφει το query
        for row in result_set:
            print("id = ", row[0])
            print("name = ", row[1])
            print("dept_name = ", row[2])
            print("salary = ", row[3], '\n')
    elif option == 'd':
        cursor.execute(sql_query_d, parameters_d)

        result_set = cursor.fetchall()

        #Να τα φτιάξουμε ανάλογα με το τι επιστέφει το query
        for row in result_set:
            print("id = ", row[0])
            print("name = ", row[1])
            print("dept_name = ", row[2])
            print("salary = ", row[3], '\n')

except(Exception, psycopg2.Error) as error:
    print("Error while fetching data from PostgreSQL ", error)

finally:
    if cursor:
        cursor.close()
    if connection:
        connection.close()
