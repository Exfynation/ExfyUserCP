package exfy.user_cp

import grails.transaction.Transactional
import groovy.sql.Sql

@Transactional
class UserService {

	Sql deltaSql

	def getDataFromUUID(String uuid) {
		final query = 'SELECT name FROM users WHERE uuid = :uuid'
		deltaSql.firstRow(query, uuid: uuid)
	}
}
