package exfy.user_cp


class AjaxInterceptor {
	AjaxInterceptor() {
		matchAll()
	}

	boolean before() {
		response.setHeader('Expires', '-1')

		true
	}
}
