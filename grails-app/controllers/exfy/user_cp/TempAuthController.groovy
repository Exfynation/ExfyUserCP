package exfy.user_cp

class TempAuthController {

	AuthService authService

	def index() {
		final String uuid = params.uuid
		final String key = params.key

		boolean successful = authService.tempAuth(uuid, key)

		if (successful) {
			flash.message = [
			        type: 'success',
					message: 'Du wurdest temporär als ' + session['user'] + ' eingeloggt. ' +
							'Dein Login verfällt, sobald du den Browser schließt.'
			]
		} else {
			flash.message = [
			        type: 'danger',
					message: 'Der temporäre Login war fehlerhaft!'
			]
		}

		redirect(controller: 'home')
	}

	def logout() {
		if (!authService.loggedIn || authService.type != 'temp') {
			redirect(controller: 'home')
			return
		}

		flash.message = [
		        type: 'success',
				message: 'Du wurdest erfolgreich vom temporären Login ausgeloggt!'
		]
		authService.logout()
		redirect(controller: 'home')
	}
}
