package exfy.user_cp

import grails.transaction.Transactional
import groovy.sql.Sql

@Transactional
class TempAuthService {

	Sql deltaSql

	def checkValid(String uuid, String key) {
		if (uuid == null || uuid.trim().isEmpty() || key == null || key.trim().isEmpty()) {
			return false
		}

		final query = 'SELECT uuid FROM usercp_auth WHERE uuid = :uuid AND `key` = :key'

		def row = deltaSql.firstRow(query, uuid: uuid, key: key)
		row != null
	}

	def login(String uuid, String key) {
		if (uuid == null || uuid.trim().isEmpty() || key == null || key.trim().isEmpty()) {
			return false
		}

		final query = 'UPDATE usercp_auth SET used = 1 WHERE uuid = :uuid AND `key` = :key AND used = 0'
		final updated = deltaSql.executeUpdate(query, uuid: uuid, key: key)
		return updated > 0
	}
}
