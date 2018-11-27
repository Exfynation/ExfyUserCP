package exfy.user_cp


class StatsInterceptor {
	boolean before() {
		if (!session.loggedIn) {
			redirect(controller: 'topStats')
			return false
		}

		true
	}
}
