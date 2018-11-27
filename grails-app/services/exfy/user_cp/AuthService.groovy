package exfy.user_cp

import exfy.user.cp.Application
import grails.core.GrailsApplication
import org.springframework.web.context.request.RequestContextHolder

class AuthService {

	WBBSSOService WBBSSOService
	TempAuthService tempAuthService
	UserService userService
	GrailsApplication grailsApplication

	def logout() {
		def session = RequestContextHolder.currentRequestAttributes().getSession()
		session['loggedIn'] = false
	}

	def verifyLogin() {
		def session = RequestContextHolder.currentRequestAttributes().getSession()
		if (session['loggedIn']) {
			switch (session['type']) {
				case 'WBB':
					if (!WBBSSOService.verifyCookie(session)) {
						session['loggedIn'] = false
					}
					break;

				case 'temp':
					String uuid = session['uuid'];
					String key = session['key'];
					if (!tempAuthService.checkValid(uuid, key)) {
						session['loggedIn'] = false
					}
			}
		}


		if ((!session['loggedIn'] || session['loggedIn'] == null) && Boolean.valueOf(grailsApplication.config.getProperty("ssoEnable", "true"))) {
			ssoLogin()
		}
	}

	boolean isLoggedIn() {
		def session = RequestContextHolder.currentRequestAttributes().getSession()
		return session['loggedIn'];
	}

	String getUsername() {
		def session = RequestContextHolder.currentRequestAttributes().getSession()
		return session['user'];
	}

	String getType() {
		def session = RequestContextHolder.currentRequestAttributes().getSession()
		return session['type'];
	}

	String getUuid() {
		def session = RequestContextHolder.currentRequestAttributes().getSession()
		return session['uuid'];
	}

	def tempAuth(String uuid, String key) {
		def session = RequestContextHolder.currentRequestAttributes().getSession()

		boolean result = tempAuthService.login(uuid, key);
		if (result) {
			session['loggedIn'] = true;
			session['type'] = 'temp';
			session['uuid'] = uuid;
			session['key'] = key;
			session['user'] = userService.getDataFromUUID(uuid)?.name;
		}

		result
	}

	def ssoLogin() {
		def session = RequestContextHolder.currentRequestAttributes().getSession()

		def result = WBBSSOService.getUserInfo()
		if (result == false) {
			// no success
			return
		}

		// authenticated!
		session['user'] = result.name
		session['uuid'] = result.uuid
		session['loggedIn'] = true
		session['type'] = 'WBB'
	}
}
