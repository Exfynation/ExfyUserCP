package exfy.user_cp

import grails.transaction.Transactional
import groovy.sql.Sql

@Transactional
class GamemodeService {

	Sql deltaSql

	def gamemodeExists(String gamemode) {
		if (gamemode == "TacticalIsland") {
			return true
		}

		final query = 'SELECT name FROM gamemodes WHERE name = :gamemode'

		!deltaSql.rows(query, gamemode: gamemode).isEmpty()
	}
}
