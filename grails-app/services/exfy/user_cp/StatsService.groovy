package exfy.user_cp

import groovy.sql.Sql

class StatsService {

	Sql deltaSql
	AuthService authService

	def getStatsForGamemode(String gamemode) {
		if (authService.loggedIn) {
			getAuthenticatedStatsForGamemode(gamemode, authService.uuid)
		} else {
			getAnonymousStatsForGamemode(gamemode)
		}
	}

	def getAnonymousStatsForGamemode(String gamemode) {
		final query = 'SELECT stat, type, localization FROM available_game_stats WHERE gamemode = :gamemode'

		deltaSql.rows(query, gamemode: gamemode)
	}

	def getAuthenticatedStatsForGamemode(String gamemode, String uuid) {
		final query = 'SELECT a.stat, a.localization, a.type, s.score, s.rank\n' +
				'FROM available_game_stats a\n' +
				'LEFT JOIN game_stats_top s ON (a.gamemode = s.gamemode AND a.stat = s.stat AND s.uuid = :uuid)\n' +
				'WHERE a.gamemode = :gamemode\n' +
				'GROUP BY a.gamemode, a.stat'

		deltaSql.rows(query, gamemode: gamemode, uuid: uuid)
	}
}
