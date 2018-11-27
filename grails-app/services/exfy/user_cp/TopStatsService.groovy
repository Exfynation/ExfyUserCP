package exfy.user_cp

import groovy.sql.Sql
import groovy.transform.Memoized

class TopStatsService {

    Sql deltaSql
    AuthService authService

    def getInfo(String gamemode, String stat) {
        final query = 'SELECT a.type, a.localization ' +
                'FROM available_game_stats a ' +
                'WHERE a.gamemode = :gamemode AND a.stat = :stat'

        deltaSql.firstRow(query, gamemode: gamemode, stat: stat)
    }

    def getTopInfo() {
        final query = 'SELECT a.gamemode, a.type, a.localization ' +
                'FROM available_game_stats a ' +
                'LEFT JOIN game_top_info i ON (i.gamemode = a.gamemode) ' +
                'WHERE a.stat = i.stat'

        deltaSql.rows(query).collectEntries {
            [(it.gamemode): it]
        }
    }

    def getTopOverview() {
        final query = 'CALL stats_overview()'

        def results = deltaSql.rows(query)

        def realRes = [:]

        results.each {
            if (!realRes.containsKey(it.gamemode)) {
                realRes[it.gamemode] = []
            }

            realRes[it.gamemode] << it
        }

        realRes
    }

    def getTopRanks(String uuid) {
        final query = 'SELECT t.gamemode as gamemode, t.rank as rank, t.score as score ' +
                'FROM game_stats_top t ' +
                'LEFT JOIN game_top_info i ON (t.gamemode = i.gamemode) ' +
                'WHERE t.stat = i.stat AND t.uuid = :uuid'

        deltaSql.rows(query, uuid: uuid).collectEntries {
            [(it.gamemode): it]
        }
    }

    def getStatTop(String gamemode, String stat) {
        final query = 'SELECT t.uuid, name, score, t.rank ' +
                'FROM game_stats_top t ' +
                'LEFT JOIN users u ON (t.uuid = u.uuid) ' +
                'WHERE gamemode = :gamemode AND stat = :stat ' +
                'ORDER BY rank ASC ' +
				'LIMIT 10'

        deltaSql.rows(query, gamemode: gamemode, stat: stat)
    }
}
