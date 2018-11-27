package exfy.user_cp

import grails.transaction.Transactional
import groovy.sql.Sql
import org.grails.web.servlet.mvc.GrailsWebRequest
import org.grails.web.util.WebUtils
import org.springframework.web.context.request.RequestContextHolder

import javax.sql.DataSource

class WBBSSOService {

	Sql forumSql

	def verifyCookie(def session) {
		def result = getUserInfo()
		if (result == false) {
			return false
		}

		if (!result.name.equals(session['name']) || !result.uuid.equals(session['uuid'])) {
			return false
		}

		true
	}

	def getUserInfo() {
		GrailsWebRequest webUtils = WebUtils.retrieveGrailsWebRequest()
		def request = webUtils.getCurrentRequest()

		final hash = WebUtils.getCookie(request, "wcf21_cookieHash")?.value
		if (hash == null) {
			// lelnoup
			return false
		}

		def query = 'SELECT userID FROM wcf1_session WHERE sessionID = :hash'
		def row = forumSql.firstRow(query, hash: hash)

		final id = row?.userID
		if (id == null) {
			return false
		}

		query = 'SELECT userOption39 AS uuid, userOption126 AS name FROM wcf1_user_option_value WHERE userID = :id'
		row = forumSql.firstRow(query, id: id)

		def name = row?.name?.trim()
		def uuid = row?.uuid?.trim()

		if (name == null || name.isEmpty() || uuid == null || uuid.isEmpty()) {
			// he is not verified, maybe do something about this
			request.setAttribute("showVerifyWarning", true)
			return false
		}

		row
	}
}
